// ignore_for_file: avoid_print

import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:path/path.dart' as p;
import 'package:analyzer/dart/analysis/features.dart';

void main() async {
  final iconDir = Directory('lib/src/icons');
  final colorsFile = File('lib/src/theme/generated_colors.dart');
  final themesFile = File('lib/src/theme/generated_themes.dart');

  final iconOutputFolder = Directory('skills/shadcn-flutter/icons');
  final colorsGuide = File('skills/shadcn-flutter/guides/colors.md');

  final featureSet = FeatureSet.latestLanguageVersion();

  // Create input/output folders if they don't exist
  if (!iconOutputFolder.existsSync()) {
    iconOutputFolder.createSync(recursive: true);
  }
  if (!colorsGuide.parent.existsSync()) {
    colorsGuide.parent.createSync(recursive: true);
  }

  // 1. Generate Provider-Specific Icons Listings
  print('Generating Provider-Specific Icons Listings...');

  final iconFiles = iconDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));
  for (final file in iconFiles) {
    final fileName = p.basenameWithoutExtension(file.path);
    final className =
        '${fileName.split('_').map((s) => s[0].toUpperCase() + s.substring(1)).join()}s';
    final setName = fileName
        .split('_')
        .map((s) => s[0].toUpperCase() + s.substring(1))
        .join(' ');

    final providerFile = File(p.join(iconOutputFolder.path, '$fileName.md'));
    final iconBuffer = StringBuffer();

    iconBuffer.writeln('# $setName');
    iconBuffer.writeln();
    iconBuffer.writeln('Exhaustive listing for the $setName set.');
    iconBuffer.writeln();
    iconBuffer.writeln('Usage: `Icon($className.iconName)`');
    iconBuffer.writeln();

    final result = parseFile(path: file.absolute.path, featureSet: featureSet);
    final unit = result.unit;
    final icons = <String>[];

    for (final declaration in unit.declarations) {
      if (declaration is ClassDeclaration) {
        for (final member in declaration.members) {
          if (member is FieldDeclaration && member.isStatic) {
            for (final field in member.fields.variables) {
              icons.add(field.name.lexeme);
            }
          }
        }
      }
    }

    iconBuffer.writeln('Total icons: ${icons.length}');
    iconBuffer.writeln();
    for (final icon in icons) {
      iconBuffer.writeln('- `$icon`');
    }
    iconBuffer.writeln();

    providerFile.writeAsStringSync(iconBuffer.toString());
    print('Generated icons listing for $setName at ${providerFile.path}');
  }

  // 2. Generate Colors Listing
  print('Generating Colors Listing...');
  final colorBuffer = StringBuffer();
  colorBuffer.writeln('# Colors & Themes');
  colorBuffer.writeln();
  colorBuffer.writeln(
      'Shadcn Flutter uses a Tailwind-inspired color palette and a flexible theme system.');
  colorBuffer.writeln();

  if (colorsFile.existsSync()) {
    colorBuffer.writeln('## Color Palette');
    colorBuffer.writeln(
        'Access via `Colors.colorName.shade` (e.g., `Colors.blue[500]`).');
    colorBuffer.writeln();

    final result =
        parseFile(path: colorsFile.absolute.path, featureSet: featureSet);
    final unit = result.unit;
    for (final declaration in unit.declarations) {
      if (declaration is ClassDeclaration &&
          declaration.name.lexeme == 'Colors') {
        colorBuffer.writeln('| Palette | Shades |');
        colorBuffer.writeln('| :--- | :--- |');
        for (final member in declaration.members) {
          if (member is FieldDeclaration && member.isStatic) {
            final type = member.fields.type?.toString() ?? '';
            if (type == 'ColorShades') {
              for (final field in member.fields.variables) {
                colorBuffer.writeln(
                    '| **${field.name.lexeme}** | 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950 |');
              }
            }
          }
        }
        colorBuffer.writeln();
      }
    }
  }

  if (themesFile.existsSync()) {
    colorBuffer.writeln('## Predefined Color Schemes');
    colorBuffer.writeln(
        'Usage: `ShadcnApp(theme: ThemeData(colorScheme: ColorSchemes.schemeName))`');
    colorBuffer.writeln();

    final result =
        parseFile(path: themesFile.absolute.path, featureSet: featureSet);
    final unit = result.unit;
    for (final declaration in unit.declarations) {
      if (declaration is ClassDeclaration &&
          declaration.name.lexeme == 'ColorSchemes') {
        final schemes = <String>[];
        for (final member in declaration.members) {
          if (member is FieldDeclaration &&
              member.isStatic &&
              member.fields.type?.toString() == 'ColorScheme') {
            for (final field in member.fields.variables) {
              schemes.add(field.name.lexeme);
            }
          }
        }
        colorBuffer.writeln('| Scheme Name | Brightness |');
        colorBuffer.writeln('| :--- | :--- |');
        for (final scheme in schemes) {
          final brightness = scheme.startsWith('dark') ? 'Dark' : 'Light';
          colorBuffer.writeln('| `$scheme` | $brightness |');
        }
        colorBuffer.writeln();
      }
    }
  }
  colorsGuide.parent.createSync(recursive: true);
  colorsGuide.writeAsStringSync(colorBuffer.toString());

  print('Done!');
}
