import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:glob/glob.dart';
import 'dart:io';
import 'package:file/local.dart';

const targetOutput = 'docs/public/llms-full.txt';

void main(List<String> args) async {
  await generateLLMSFull();
}

List<Glob> readFilesToInclude() {
  File includeFile = File('llms-include.txt');
  if (!includeFile.existsSync()) {
    return [];
  }
  List<String> lines = includeFile.readAsLinesSync();
  return lines
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty && !line.startsWith('#'))
      // Normalize leading slashes so patterns like "/docs/**" work cross-platform.
      .map((line) => line.startsWith('/') ? line.substring(1) : line)
      .map((line) => Glob(line))
      .toList();
}

/*
Output format:
For classes and methods:
/// <Dartdoc comments>
class ClassName extends SuperClass with Mixins implements Interfaces {
  /// <Dartdoc comments>
  Type fieldName;
  /// <Dartdoc comments>
  ClassName(Parameter params);
  /// <Dartdoc comments>
  ReturnType methodName(Parameter params);
  /// <Dartdoc comments>
  static ReturnType staticMethodName(Parameter params);
  /// <Dartdoc comments>
  ReturnType get propertyName;
  /// <Dartdoc comments>
  set propertyName(Type value);
  // ...
}
For example files:
# File: <relative path from root>
<contents of the file>
*/

void readAllDocs(void Function(String content) writer) {
  // Walk lib/ and extract class-like API surfaces with dartdoc comments.
  // Only signatures are emitted (no bodies), matching the format sketched above.
  final libDir = Directory('lib');
  if (!libDir.existsSync()) return;

  bool isPublicName(String name) => !name.startsWith('_');

  // Helper to convert a documentation comment to lines prefixed with '///'.
  String doc(Comment? comment) {
    if (comment == null) return '';
    // Join tokens to preserve any intra-line formatting.
    final text = comment.tokens.map((t) => t.lexeme).join('\n');
    if (text.trim().isEmpty) return '';
    // Ensure each line begins with '///'. If the token lexemes already contain
    // '///', keep as-is; otherwise, prefix.
    final lines = text.split('\n');
    return lines
        .map((l) => l.trim().startsWith('///') ? l : '/// ${l.trim()}')
        .join('\n');
  }

  // Render a type parameter list or return empty string.
  String toSrcOrEmpty(AstNode? node) => node == null ? '' : node.toSource();

  // Field declarations (possibly multiple variables in one).
  String fieldSignature(FieldDeclaration node) {
    final b = StringBuffer();
    final docs = doc(node.documentationComment);
    final isStatic = node.isStatic;
    final type = node.fields.type?.toSource() ?? 'var';
    for (final v in node.fields.variables) {
      final name = v.name.lexeme;
      if (!isPublicName(name)) continue;
      if (docs.isNotEmpty) b.writeln(docs);
      b.writeln('  ${isStatic ? 'static ' : ''}$type $name;'); // no initializer
    }
    return b.toString();
  }

  String constructorSignature(ConstructorDeclaration node) {
    final docs = doc(node.documentationComment);
    final b = StringBuffer();
    if (docs.isNotEmpty) b.writeln(docs);
    final mod = node.factoryKeyword != null
        ? 'factory '
        : (node.constKeyword != null ? 'const ' : '');
    final className = node.returnType.toSource();
    final name = node.name?.lexeme;
    final params = node.parameters.toSource();
    b.writeln('  ${mod}${className}${name != null ? '.$name' : ''}$params;');
    return b.toString();
  }

  String methodSignature(MethodDeclaration node) {
    final docs = doc(node.documentationComment);
    final b = StringBuffer();
    if (docs.isNotEmpty) b.writeln(docs);
    final isStatic = node.isStatic;
    final typeParams = toSrcOrEmpty(node.typeParameters);
    if (node.isGetter) {
      final rt = node.returnType?.toSource() ?? 'dynamic';
      b.writeln('  ${isStatic ? 'static ' : ''}$rt get ${node.name.lexeme};');
    } else if (node.isSetter) {
      // Setter always has one param; use parameter list to keep name/type.
      final params = node.parameters?.toSource() ?? '(value)';
      b.writeln(
          '  ${isStatic ? 'static ' : ''}set ${node.name.lexeme}$params;');
    } else {
      final rt = node.returnType?.toSource() ?? 'void';
      final op = node.operatorKeyword != null ? 'operator ' : '';
      final name = node.name.lexeme;
      final params = node.parameters?.toSource() ?? '()';
      b.writeln(
          '  ${isStatic ? 'static ' : ''}$rt $op$name$typeParams$params;');
    }
    return b.toString();
  }

  String classHeader(ClassDeclaration node) {
    final isAbstract = node.abstractKeyword != null;
    final isMixinClass = node.mixinKeyword != null;
    final name = node.name.lexeme;
    final typeParams = toSrcOrEmpty(node.typeParameters);
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
    final typeParams = toSrcOrEmpty(node.typeParameters);
    final onClause = node.onClause == null
        ? ''
        : ' on ${node.onClause!.superclassConstraints.map((t) => t.toSource()).join(', ')}';
    final implementsClause = node.implementsClause == null
        ? ''
        : ' implements ${node.implementsClause!.interfaces.join(', ')}';
    return 'mixin $name$typeParams$onClause$implementsClause';
  }

  String extensionHeader(ExtensionDeclaration node) {
    final name = node.name?.lexeme ?? '';
    final typeParams = toSrcOrEmpty(node.typeParameters);
    final onType = node.extendedType.toSource();
    return 'extension${name.isNotEmpty ? ' $name' : ''}$typeParams on $onType';
  }

  String enumSignature(EnumDeclaration node) {
    final docs = doc(node.documentationComment);
    final names = node.constants.map((c) => c.name.lexeme).join(', ');
    return [if (docs.isNotEmpty) docs, 'enum ${node.name.lexeme} { $names }']
        .join('\n');
  }

  for (final entity in libDir.listSync(recursive: true)) {
    if (entity is! File) continue;
    if (!entity.path.endsWith('.dart')) continue;
    final source = entity.readAsStringSync();
    final result = parseString(content: source, path: entity.path);
    final unit = result.unit;

    final buffer = StringBuffer();

    for (final decl in unit.declarations) {
      if (decl is ClassDeclaration) {
        final docs = doc(decl.documentationComment);
        if (docs.isNotEmpty) buffer.writeln(docs);
        buffer.writeln('${classHeader(decl)} {');
        for (final member in decl.members) {
          if (member is FieldDeclaration) {
            buffer.write(fieldSignature(member));
          } else if (member is ConstructorDeclaration) {
            buffer.write(constructorSignature(member));
          } else if (member is MethodDeclaration) {
            buffer.write(methodSignature(member));
          }
        }
        buffer.writeln('}');
        buffer.writeln();
      } else if (decl is MixinDeclaration) {
        final docs = doc(decl.documentationComment);
        if (docs.isNotEmpty) buffer.writeln(docs);
        buffer.writeln('${mixinHeader(decl)} {');
        for (final member in decl.members) {
          if (member is FieldDeclaration) {
            buffer.write(fieldSignature(member));
          } else if (member is MethodDeclaration) {
            buffer.write(methodSignature(member));
          }
        }
        buffer.writeln('}');
        buffer.writeln();
      } else if (decl is ExtensionDeclaration) {
        final docs = doc(decl.documentationComment);
        if (docs.isNotEmpty) buffer.writeln(docs);
        buffer.writeln('${extensionHeader(decl)} {');
        for (final member in decl.members) {
          if (member is FieldDeclaration) {
            buffer.write(fieldSignature(member));
          } else if (member is MethodDeclaration) {
            buffer.write(methodSignature(member));
          }
        }
        buffer.writeln('}');
        buffer.writeln();
      } else if (decl is EnumDeclaration) {
        buffer.writeln(enumSignature(decl));
        buffer.writeln();
      }
    }

    final out = buffer.toString().trim();
    if (out.isNotEmpty) {
      writer(out);
    }
  }
}

Future<void> generateLLMSFull() async {
  print('Generating full LLMs documentation at $targetOutput');
  File target = File(targetOutput);
  // Ensure output directory exists.
  if (!target.parent.existsSync()) {
    target.parent.createSync(recursive: true);
  }
  IOSink sink = target.openWrite();
  // Remove empty/whitespace-only lines from any block before writing.
  String stripEmptyLines(String input) {
    final lines = input.split(RegExp(r'\r?\n'));
    final kept = <String>[];
    for (final line in lines) {
      if (line.trim().isEmpty) continue;
      kept.add(line);
    }
    return kept.join('\n');
  }

  readAllDocs((content) {
    final filtered = stripEmptyLines(content);
    if (filtered.isEmpty) return;
    sink.writeln(filtered);
  });
  for (Glob glob in readFilesToInclude()) {
    print('Including files matching pattern: ${glob.pattern}');
    for (FileSystemEntity entity in glob.listFileSystemSync(
      // FileSystem
      const LocalFileSystem(),
    )) {
      if (entity is File && entity.path.endsWith('.dart')) {
        String relativePath =
            entity.path.replaceFirst('docs/', ''); // relative to root
        print('Including file: $relativePath');
        sink.writeln('# File: $relativePath');
        final fileText = entity.readAsStringSync();
        final filtered = stripEmptyLines(fileText);
        if (filtered.isNotEmpty) {
          sink.writeln(filtered);
        }
      }
    }
  }
  await sink.close();
  print('Generation complete.');
  print('Total size: ${target.lengthSync()} bytes');
}
