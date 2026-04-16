// ignore_for_file: avoid_print

import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:path/path.dart' as p;
import 'package:analyzer/dart/analysis/features.dart';

void main() async {
  final componentsDir = Directory('lib/src/components');
  final docsDir = Directory('docs/lib/pages/docs/components');
  final skillsDir = Directory('skills/shadcn-flutter/components');

  if (!skillsDir.existsSync()) {
    skillsDir.createSync(recursive: true);
  }

  final files = componentsDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  final featureSet = FeatureSet.latestLanguageVersion();

  for (final file in files) {
    final fileName = p.basenameWithoutExtension(file.path);
    if (fileName == 'shadcn_localizations' ||
        fileName.contains('_en') ||
        fileName == 'async' ||
        fileName == 'debug') {
      continue;
    }

    print('Processing $fileName...');

    try {
      final result =
          parseFile(path: file.absolute.path, featureSet: featureSet);
      final unit = result.unit;

      for (final declaration in unit.declarations) {
        if (declaration is ClassDeclaration) {
          final className = declaration.name.lexeme;
          if (className.endsWith('State') || className.startsWith('_')) {
            continue;
          }

          if (!className
                  .toLowerCase()
                  .contains(fileName.replaceAll('_', '').toLowerCase()) &&
              declaration.documentationComment == null) {
            continue;
          }

          final markdown =
              generateMarkdown(fileName, className, declaration, docsDir);
          final outputFile = File(p.join(skillsDir.path, '$fileName.md'));
          outputFile.writeAsStringSync(markdown);
          print('  Generated ${outputFile.path}');
          break;
        }
      }
    } catch (e) {
      print('  Error processing $fileName: $e');
    }
  }
}

String generateMarkdown(String fileName, String className,
    ClassDeclaration clazz, Directory docsDir) {
  final comment = clazz.documentationComment?.tokens
          .map((t) => t.lexeme.replaceAll('///', '').trim())
          .join('\n') ??
      'No overview available.';

  // Split into overview and the rest
  final parts = comment.split('\n\n');
  final overview = parts.isNotEmpty ? parts.first : 'No overview available.';

  final features = extractFeatures(comment);
  final properties = extractProperties(clazz);
  final examples = findExamples(fileName, docsDir);

  return '''# $className

$overview

## Usage

$examples

## Features
${features.map((f) => '- $f').join('\n')}

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
${properties.map((p) => '| `${p.name}` | `${p.type}` | ${p.description} |').join('\n')}
''';
}

List<String> extractFeatures(String comment) {
  final lines = comment.split('\n');
  final features = <String>[];
  bool inFeatures = false;
  for (final line in lines) {
    if (line.toLowerCase().contains('## key features') ||
        line.toLowerCase().contains('## features')) {
      inFeatures = true;
      continue;
    }
    if (inFeatures && line.trim().startsWith('-')) {
      features.add(line.replaceFirst('-', '').trim());
    } else if (inFeatures && line.startsWith('##')) {
      break;
    }
  }
  if (features.isEmpty) {
    return [
      'Responsive design',
      'Customizable styling',
      'Accessibility support'
    ];
  }
  return features;
}

class Property {
  final String name;
  final String type;
  final String description;
  Property(this.name, this.type, this.description);
}

List<Property> extractProperties(ClassDeclaration clazz) {
  final props = <Property>[];
  for (final member in clazz.members) {
    if (member is FieldDeclaration) {
      final doc = member.documentationComment?.tokens
              .map((t) => t.lexeme.replaceAll('///', '').trim())
              .join(' ') ??
          '';
      final type = member.fields.type?.toString() ?? 'dynamic';
      for (final field in member.fields.variables) {
        props.add(Property(field.name.lexeme, type, doc));
      }
    }
  }
  return props;
}

String findExamples(String fileName, Directory docsDir) {
  final examples = <String, String>{};

  // 1. Look in subfolder docsDir/fileName/
  final subDir = Directory(p.join(docsDir.path, fileName));
  if (subDir.existsSync()) {
    final subDirFiles = subDir
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));
    for (final f in subDirFiles) {
      examples[p.basename(f.path)] = f.readAsStringSync();
    }
  }

  // 2. Look for flat files docsDir/fileName_example.dart or docsDir/fileName_example_*.dart
  if (docsDir.existsSync()) {
    final flatFiles = docsDir.listSync().whereType<File>().where((f) {
      final b = p.basename(f.path);
      return b == '${fileName}_example.dart' ||
          b.startsWith('${fileName}_example_');
    });
    for (final f in flatFiles) {
      examples[p.basename(f.path)] = f.readAsStringSync();
    }
  }

  if (examples.isEmpty) {
    return 'No examples found for $fileName.';
  }

  final sortedKeys = examples.keys.toList()..sort();
  final buffer = StringBuffer();
  for (final key in sortedKeys) {
    buffer.writeln(
        '### ${key.replaceAll('.dart', '').replaceAll('_', ' ').toTitleCase()}');
    buffer.writeln('```dart');
    buffer.writeln(examples[key]);
    buffer.writeln('```');
    buffer.writeln();
  }

  return buffer.toString();
}

extension StringExtension on String {
  String toTitleCase() {
    return split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
