import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

const topicsDirPath = '.guides/docs';
const usageMdPath = '.guides/usage.md';

Future<void> main(List<String> args) async {
  await generateTopicPrompts();
}

// Note: usage.md is now maintained manually under .guides/usage.md

Future<void> generateTopicPrompts() async {
  final dir = Directory(topicsDirPath);
  if (!dir.existsSync()) dir.createSync(recursive: true);

  final topics = <_Topic>[];
  topics.addAll(_collectApiTopics());
  topics.addAll(_collectExampleTopics());

  for (final t in topics) {
    final fileName = '${_sanitizeFileName(t.slug)}.md';
    final category = _categoryDirFor(t);
    final outDirPath = category.isEmpty
        ? topicsDirPath
        : '$topicsDirPath/$category';
    final outDir = Directory(outDirPath);
    if (!outDir.existsSync()) {
      outDir.createSync(recursive: true);
    }
    final outFile = File('$outDirPath/$fileName');
    final fm = StringBuffer()
      ..writeln('---')
      ..writeln('title: ${_yamlString(t.title)}')
      ..writeln('description: ${_yamlString(t.description)}')
      ..writeln('---');
    final body = t.body.trim();
    final content = body.isEmpty ? fm.toString() : '$fm\n$body\n';
    await outFile.writeAsString(content);
    stdout.writeln('Wrote topic: ${outFile.path}');
  }
}

/// Map topic slug prefixes to directory categories under .guides/docs
String _categoryDirFor(_Topic t) {
  final slug = t.slug;
  final prefix = slug.contains('-') ? slug.split('-').first : slug;
  switch (prefix) {
    case 'class':
      return 'classes';
    case 'mixin':
      return 'mixins';
    case 'extension':
      return 'extensions';
    case 'enum':
      return 'enums';
    case 'var':
      return 'vars';
    case 'fn':
      return 'fns';
    case 'example':
      return 'examples';
    default:
      return '';
  }
}

String _yamlString(String v) {
  // Ensure valid YAML scalar by quoting and escaping characters.
  // Replace newlines and carriage returns with spaces to keep single-line values.
  final safe = v
      .replaceAll('\\', r'\\')
      .replaceAll('"', r'\"')
      .replaceAll('\r', ' ')
      .replaceAll('\n', ' ');
  return '"$safe"';
}

class _Topic {
  final String slug;
  final String title;
  final String description;
  final String body;
  _Topic({
    required this.slug,
    required this.title,
    required this.description,
    required this.body,
  });
}

bool _isPrivateName(String name) => name.startsWith('_');

String _docLines(Comment? comment) {
  if (comment == null) return '';
  final text = comment.tokens.map((t) => t.lexeme).join('\n');
  if (text.trim().isEmpty) return '';
  return text
      .split('\n')
      .map((l) => l.trim().startsWith('///') ? l : '/// ${l.trim()}')
      .join('\n');
}

String _indentDocs(String docs, String indent) {
  if (docs.isEmpty) return '';
  return docs.split(RegExp(r'\r?\n')).map((l) => '$indent$l').join('\n');
}

String classHeader(ClassDeclaration node) {
  final isAbstract = node.abstractKeyword != null;
  final isMixinClass = node.mixinKeyword != null;
  final name = node.name.lexeme;
  final typeParams = node.typeParameters?.toSource() ?? '';
  final extendsClause = node.extendsClause == null
      ? ''
      : ' extends ${node.extendsClause!.superclass.toSource()}';
  final withClause = node.withClause == null
      ? ''
      : ' with ${node.withClause!.mixinTypes.map((t) => t.toSource()).join(', ')}';
  final implementsClause = node.implementsClause == null
      ? ''
      : ' implements ${node.implementsClause!.interfaces.map((t) => t.toSource()).join(', ')}';
  return '${isAbstract ? 'abstract ' : ''}${isMixinClass ? 'mixin ' : ''}class '
      '$name$typeParams$extendsClause$withClause$implementsClause';
}

String mixinHeader(MixinDeclaration node) {
  final name = node.name.lexeme;
  final typeParams = node.typeParameters?.toSource() ?? '';
  final onClause = node.onClause == null
      ? ''
      : ' on ${node.onClause!.superclassConstraints.map((t) => t.toSource()).join(', ')}';
  final implementsClause = node.implementsClause == null
      ? ''
      : ' implements ${node.implementsClause!.interfaces.map((t) => t.toSource()).join(', ')}';
  return 'mixin $name$typeParams$onClause$implementsClause';
}

String extensionHeader(ExtensionDeclaration node) {
  final name = node.name?.lexeme ?? '';
  final typeParams = node.typeParameters?.toSource() ?? '';
  final onType = node.extendedType.toSource();
  return 'extension${name.isNotEmpty ? ' $name' : ''}$typeParams on $onType';
}

String _fieldSigWithDocs(FieldDeclaration node) {
  final b = StringBuffer();
  final docs = _docLines(node.documentationComment);
  final isStatic = node.isStatic;
  final isConst = node.fields.isConst;
  final isFinal = node.fields.isFinal;
  final typeSrc = node.fields.type?.toSource();
  for (final v in node.fields.variables) {
    final name = v.name.lexeme;
    if (_isPrivateName(name)) continue;
    if (docs.isNotEmpty) b.writeln(_indentDocs(docs, '  '));
    final init = v.initializer?.toSource().trim();
    final staticPart = isStatic ? 'static ' : '';
    final constPart = isConst ? 'const ' : (isFinal ? 'final ' : '');
    // For const, omit 'var' when type is not provided.
    final typePart = typeSrc ?? (isConst ? '' : 'var');
    final typeSpace = typePart.isNotEmpty ? ' ' : '';
    if (isConst &&
        init != null &&
        init.isNotEmpty &&
        !_isIconDataInit(typeSrc, init)) {
      b.writeln('  $staticPart$constPart$typePart$typeSpace$name = $init;');
    } else {
      b.writeln('  $staticPart$constPart$typePart$typeSpace$name;');
    }
  }
  return b.toString();
}

String _ctorSigWithDocs(ConstructorDeclaration node) {
  final name = node.name?.lexeme;
  if (name != null && _isPrivateName(name)) return '';
  final b = StringBuffer();
  final docs = _docLines(node.documentationComment);
  if (docs.isNotEmpty) b.writeln(_indentDocs(docs, '  '));
  final mod = node.factoryKeyword != null
      ? 'factory '
      : (node.constKeyword != null ? 'const ' : '');
  final className = node.returnType.toSource();
  final params = node.parameters.toSource();
  b.writeln('  $mod$className${name != null ? '.$name' : ''}$params;');
  return b.toString();
}

String _methodSigWithDocs(MethodDeclaration node) {
  final name = node.name.lexeme;
  if (_isPrivateName(name)) return '';
  final b = StringBuffer();
  final docs = _docLines(node.documentationComment);
  if (docs.isNotEmpty) b.writeln(_indentDocs(docs, '  '));
  final isStatic = node.isStatic;
  final typeParams = node.typeParameters?.toSource() ?? '';
  if (node.isGetter) {
    final rt = node.returnType?.toSource() ?? 'dynamic';
    b.writeln('  ${isStatic ? 'static ' : ''}$rt get $name;');
  } else if (node.isSetter) {
    final params = node.parameters?.toSource() ?? '(value)';
    b.writeln('  ${isStatic ? 'static ' : ''}set $name$params;');
  } else {
    final rt = node.returnType?.toSource() ?? 'void';
    final op = node.operatorKeyword != null ? 'operator ' : '';
    final params = node.parameters?.toSource() ?? '()';
    b.writeln('  ${isStatic ? 'static ' : ''}$rt $op$name$typeParams$params;');
  }
  return b.toString();
}

String _renderClassTopic(ClassDeclaration decl) {
  final b = StringBuffer();
  b.writeln('```dart');
  final cdocs = _docLines(decl.documentationComment);
  if (cdocs.isNotEmpty) b.writeln(cdocs);
  b.writeln('${classHeader(decl)} {');
  for (final member in decl.members) {
    if (member is FieldDeclaration) {
      b.write(_fieldSigWithDocs(member));
    } else if (member is ConstructorDeclaration) {
      final sig = _ctorSigWithDocs(member);
      if (sig.isNotEmpty) b.write(sig);
    } else if (member is MethodDeclaration) {
      final sig = _methodSigWithDocs(member);
      if (sig.isNotEmpty) b.write(sig);
    }
  }
  b.writeln('}');
  b.writeln('```');
  return b.toString();
}

String _renderMixinTopic(MixinDeclaration decl) {
  final b = StringBuffer();
  b.writeln('```dart');
  final cdocs = _docLines(decl.documentationComment);
  if (cdocs.isNotEmpty) b.writeln(cdocs);
  b.writeln('${mixinHeader(decl)} {');
  for (final member in decl.members) {
    if (member is FieldDeclaration) {
      b.write(_fieldSigWithDocs(member));
    } else if (member is MethodDeclaration) {
      final sig = _methodSigWithDocs(member);
      if (sig.isNotEmpty) b.write(sig);
    }
  }
  b.writeln('}');
  b.writeln('```');
  return b.toString();
}

String _renderExtensionTopic(ExtensionDeclaration decl) {
  final b = StringBuffer();
  b.writeln('```dart');
  final cdocs = _docLines(decl.documentationComment);
  if (cdocs.isNotEmpty) b.writeln(cdocs);
  b.writeln('${extensionHeader(decl)} {');
  for (final member in decl.members) {
    if (member is FieldDeclaration) {
      b.write(_fieldSigWithDocs(member));
    } else if (member is MethodDeclaration) {
      final sig = _methodSigWithDocs(member);
      if (sig.isNotEmpty) b.write(sig);
    }
  }
  b.writeln('}');
  b.writeln('```');
  return b.toString();
}

String _renderEnumTopic(EnumDeclaration decl) {
  final b = StringBuffer();
  b.writeln('```dart');
  final edocs = _docLines(decl.documentationComment);
  if (edocs.isNotEmpty) b.writeln(edocs);
  b.writeln('enum ${decl.name.lexeme} {');
  for (final c in decl.constants) {
    final name = c.name.lexeme;
    if (_isPrivateName(name)) continue;
    final cdoc = _docLines(c.documentationComment);
    if (cdoc.isNotEmpty) b.writeln(_indentDocs(cdoc, '  '));
    b.writeln('  $name,');
  }
  b.writeln('}');
  b.writeln('```');
  return b.toString();
}

String _firstSentence(String text) {
  final t = text.trim();
  if (t.isEmpty) return '';
  final idx = t.indexOf(RegExp(r'[.!?]'));
  return idx == -1 ? t : t.substring(0, idx + 1);
}

String _sanitizeFileName(String input) {
  final mid = input
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9\-_]+'), '-')
      .replaceAll(RegExp(r'-+'), '-');
  final trimmed = mid
      .replaceAll(RegExp(r'^-+'), '')
      .replaceAll(RegExp(r'-+$'), '');
  return trimmed.isEmpty ? 'topic' : trimmed;
}

bool _isIconDataInit(String? typeSrc, String? initSrc) {
  if ((typeSrc ?? '').contains('IconData')) return true;
  final init = initSrc ?? '';
  // Common patterns for icon data in this repo/ecosystem
  // - IconData(hex, ...)
  // - Icons.name
  // - LucideIcons.name
  // - BootstrapIcons.name
  // - RadixIcons.name
  return RegExp(r'\bIconData\s*\(').hasMatch(init) ||
      init.contains('Icons.') ||
      init.contains('LucideIcons.') ||
      init.contains('BootstrapIcons.') ||
      init.contains('RadixIcons.');
}

List<_Topic> _collectApiTopics() {
  final topics = <_Topic>[];
  final libDir = Directory('lib');
  if (!libDir.existsSync()) return topics;
  for (final entity in libDir.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    final source = entity.readAsStringSync();
    final result = parseString(content: source, path: entity.path);
    final unit = result.unit;
    for (final decl in unit.declarations) {
      if (decl is ClassDeclaration) {
        final name = decl.name.lexeme;
        if (_isPrivateName(name)) continue;
        final docs =
            decl.documentationComment?.tokens.map((t) => t.lexeme).join('\n') ??
            '';
        final desc = _firstSentence(docs.replaceAll('///', '').trim());
        final body = StringBuffer()..writeln(_renderClassTopic(decl));
        topics.add(
          _Topic(
            slug: 'class-$name',
            title: 'Class: $name',
            description: desc.isEmpty ? 'Reference for $name' : desc,
            body: body.toString(),
          ),
        );
      } else if (decl is MixinDeclaration) {
        final name = decl.name.lexeme;
        if (_isPrivateName(name)) continue;
        final docs =
            decl.documentationComment?.tokens.map((t) => t.lexeme).join('\n') ??
            '';
        final desc = _firstSentence(docs.replaceAll('///', '').trim());
        final body = StringBuffer()..writeln(_renderMixinTopic(decl));
        topics.add(
          _Topic(
            slug: 'mixin-$name',
            title: 'Mixin: $name',
            description: desc.isEmpty ? 'Reference for $name' : desc,
            body: body.toString(),
          ),
        );
      } else if (decl is ExtensionDeclaration) {
        final name = decl.name?.lexeme;
        if (name != null && _isPrivateName(name)) continue;
        final docs =
            decl.documentationComment?.tokens.map((t) => t.lexeme).join('\n') ??
            '';
        final desc = _firstSentence(docs.replaceAll('///', '').trim());
        final body = StringBuffer()..writeln(_renderExtensionTopic(decl));
        topics.add(
          _Topic(
            slug:
                'extension-${name ?? 'on-${decl.extendedType.toSource().replaceAll(' ', '-')}'}',
            title: 'Extension: ${name ?? decl.extendedType.toSource()}',
            description: desc.isEmpty ? 'Reference for extension' : desc,
            body: body.toString(),
          ),
        );
      } else if (decl is EnumDeclaration) {
        final name = decl.name.lexeme;
        if (_isPrivateName(name)) continue;
        final docs =
            decl.documentationComment?.tokens.map((t) => t.lexeme).join('\n') ??
            '';
        final desc = _firstSentence(docs.replaceAll('///', '').trim());
        final body = StringBuffer()..writeln(_renderEnumTopic(decl));
        topics.add(
          _Topic(
            slug: 'enum-$name',
            title: 'Enum: $name',
            description: desc.isEmpty ? 'Reference for $name' : desc,
            body: body.toString(),
          ),
        );
      } else if (decl is TopLevelVariableDeclaration) {
        final list = decl.variables;
        final docs =
            decl.documentationComment?.tokens.map((t) => t.lexeme).join('\n') ??
            '';
        final desc = _firstSentence(docs.replaceAll('///', '').trim());
        final isConst = list.isConst;
        final isFinal = list.isFinal;
        final type = list.type?.toSource();
        for (final v in list.variables) {
          final name = v.name.lexeme;
          if (_isPrivateName(name)) continue;
          final init = v.initializer?.toSource().trim();
          final constPart = isConst ? 'const ' : (isFinal ? 'final ' : '');
          final typePart = type ?? (isConst ? '' : 'var');
          final typeSpace = typePart.isNotEmpty ? ' ' : '';
          final sig =
              (isConst &&
                  init != null &&
                  init.isNotEmpty &&
                  !_isIconDataInit(type, init))
              ? '$constPart$typePart$typeSpace$name = $init;'
              : '$constPart$typePart$typeSpace$name;';
          final body = StringBuffer()
            ..writeln('Signature')
            ..writeln('```dart')
            ..writeln(sig)
            ..writeln('```');
          topics.add(
            _Topic(
              slug: 'var-$name',
              title: 'Variable: $name',
              description: desc.isEmpty ? 'Top-level variable $name' : desc,
              body: body.toString(),
            ),
          );
        }
      } else if (decl is FunctionDeclaration) {
        final name = decl.name.lexeme;
        if (_isPrivateName(name)) continue;
        final docs =
            decl.documentationComment?.tokens.map((t) => t.lexeme).join('\n') ??
            '';
        final desc = _firstSentence(docs.replaceAll('///', '').trim());
        final rt = decl.returnType?.toSource() ?? 'void';
        final typeParams =
            decl.functionExpression.typeParameters?.toSource() ?? '';
        final params = decl.functionExpression.parameters?.toSource() ?? '()';
        final body = StringBuffer()
          ..writeln('Signature')
          ..writeln('```dart')
          ..writeln('$rt $name$typeParams$params;')
          ..writeln('```');
        topics.add(
          _Topic(
            slug: 'fn-$name',
            title: 'Function: $name',
            description: desc.isEmpty ? 'Top-level function $name' : desc,
            body: body.toString(),
          ),
        );
      }
    }
  }
  return topics;
}

List<_Topic> _collectExampleTopics() {
  final topics = <_Topic>[];
  final examplesRoot = Directory('docs/lib/pages/docs/components');
  if (!examplesRoot.existsSync()) return topics;
  for (final entity in examplesRoot.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    // only include files that has number (e.g., tile_example_1.dart, tile_example_2.dart)
    if (!RegExp(r'_\d+\.dart$').hasMatch(entity.path)) {
      continue;
    }
    final content = entity.readAsStringSync();
    final lines = content.split(RegExp(r'\r?\n'));
    final descLines = <String>[];
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        if (descLines.isEmpty) continue;
        break;
      }
      if (trimmed.startsWith('//')) {
        descLines.add(trimmed.replaceFirst(RegExp(r'^//+\s?'), ''));
      } else if (trimmed.startsWith('///')) {
        descLines.add(trimmed.replaceFirst(RegExp(r'^///\s?'), ''));
      } else if (trimmed.startsWith('/*')) {
        descLines.add(trimmed.replaceAll(RegExp(r'^/\*+|\*+/$'), '').trim());
      } else {
        break;
      }
      if (descLines.length >= 6) break;
    }
    final rel = entity.path.replaceAll('\\', '/');
    final slug = rel
        .split('/')
        .skipWhile((s) => s != 'components')
        .skip(1)
        .join('-')
        .replaceAll('.dart', '');
    final title = 'Example: ${rel.split('/').takeLast(3).join('/')}';
    final desc = descLines.isEmpty
        ? 'Component example'
        : _firstSentence(descLines.join(' '));
    final preview = lines.take(60).join('\n');
    final body = StringBuffer()
      ..writeln('Source preview')
      ..writeln('```dart')
      ..writeln(preview)
      ..writeln('```');
    topics.add(
      _Topic(
        slug: 'example-$slug',
        title: title,
        description: desc,
        body: body.toString(),
      ),
    );
  }
  return topics;
}

extension _TakeLast on Iterable<String> {
  List<String> takeLast(int n) {
    final list = toList();
    if (n >= list.length) return list;
    return list.sublist(list.length - n);
  }
}
