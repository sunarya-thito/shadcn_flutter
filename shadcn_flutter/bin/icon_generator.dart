import 'dart:io';

import 'package:icon_font_generator/icon_font_generator.dart';
import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

const List<String> keywords = [
  'switch',
];

main() {
  generateIcon('icons_optimized/radix', 'RadixIcons', 'radix_icons');
}

void generateIcon(String path, String name, String dartName) {
  print('Generating $name');
  var dir = Directory(path);
  Map<String, String> svgMap = {};
  var regExp = RegExp(r'(^[0-9]+)[^a-zA-Z]');
  for (var file in dir.listSync()) {
    if (file.path.endsWith('.svg')) {
      File svgFile = File(file.path);
      var name = file.path.split('/').last.split('\\').last.split('.').first;

      if (keywords.contains(name.toLowerCase())) {
        name = '${name}Icon';
      }

      // if name starts with a number following any non alphabet character
      if (regExp.hasMatch(name)) {
        // move the number to the end
        String number = regExp.firstMatch(name)!.group(1)!;
        name = name.replaceAll(number, '') + number;
      }

      name = name.replaceAll('-', ' ');

      name = ReCase(name).pascalCase;

      print('Processing $name');
      var code = svgFile.readAsStringSync();

      svgMap[name] = code;
    }
  }

  final svgToOtfResult = svgToOtf(
    svgMap: svgMap,
    fontName: name,
  );

  writeToFile('lib/icons/$name.otf', svgToOtfResult.font);

  final generatedClass = generateFlutterClass(
    glyphList: svgToOtfResult.glyphList,
    className: name,
    familyName: svgToOtfResult.font.familyName,
    fontFileName: '$name.otf',
  );

  File('lib/src/icons/$dartName.dart').writeAsStringSync(generatedClass);

  List<String> variableNames = _generateVariableNames(svgToOtfResult.glyphList);

  String iconDocsClass =
      'import \'package:shadcn_flutter/shadcn_flutter.dart\';\nconst Map<String, IconData> k$name = {\n';
  for (int i = 0; i < svgToOtfResult.glyphList.length; i++) {
    iconDocsClass += '  \'${variableNames[i]}\': $name.${variableNames[i]},\n';
  }
  iconDocsClass += '};';
  File('example/lib/$dartName.dart').writeAsStringSync(iconDocsClass);
  print('Generated $name');
}

const _kUnnamedIconName = 'unnamed';

bool shouldRename(String name) {
  final baseName =
      ReCase(_getVarName(p.basenameWithoutExtension(name))).camelCase;
  return baseName.isEmpty;
}

List<String> _generateVariableNames(List<GenericGlyph> glyphList) {
  final iconNameSet = <String>{};

  return glyphList.map((g) {
    final baseName =
        ReCase(_getVarName(p.basenameWithoutExtension(g.metadata.name!)))
            .camelCase;
    final usingDefaultName = baseName.isEmpty;

    var variableName = usingDefaultName ? _kUnnamedIconName : baseName;

    if (iconNameSet.contains(variableName)) {
      final countMatch = RegExp(r'^(.*)_([0-9]+)$').firstMatch(variableName);

      var variableNameCount = 1;
      var variableWithoutCount = variableName;

      if (countMatch != null) {
        variableNameCount = int.parse(countMatch.group(2)!);
        variableWithoutCount = countMatch.group(1)!;
      }

      String variableNameWithCount;

      do {
        variableNameWithCount =
            '${variableWithoutCount}_${++variableNameCount}';
      } while (iconNameSet.contains(variableNameWithCount));

      variableName = variableNameWithCount;
    }

    iconNameSet.add(variableName);

    return variableName;
  }).toList();
}

String _getVarName(String string) {
  final replaced = string.replaceAll(RegExp(r'[^a-zA-Z0-9_$]'), '');
  return RegExp(r'^[a-zA-Z$].*').firstMatch(replaced)?.group(0) ?? '';
}

SvgToOtfResult svgToOtf({
  required Map<String, String> svgMap,
  bool? ignoreShapes,
  bool? normalize,
  String? fontName,
}) {
  normalize ??= true;

  List<Svg> svgList = [];
  for (final e in svgMap.entries) {
    try {
      var svg = Svg.parse(e.key, e.value, ignoreShapes: ignoreShapes);
      svgList.add(svg);
    } catch (error, stackTrace) {
      print('Error parsing ${e.key}: $error');
      print(stackTrace);
    }
  }

  if (!normalize) {
    for (var i = 1; i < svgList.length; i++) {
      if (svgList[i - 1].viewBox.height != svgList[i].viewBox.height) {
        print('Some SVG files contain different view box height, '
            'while normalization option is disabled. '
            'This is not recommended.');
        break;
      }
    }
  }

  final glyphList = svgList.map(GenericGlyph.fromSvg).toList();

  final font = OpenTypeFont.createFromGlyphs(
    glyphList: glyphList,
    fontName: fontName,
    normalize: normalize,
    useOpenType: true,
    usePostV2: true,
  );

  return SvgToOtfResult(glyphList, font);
}

class SvgToOtfResult {
  SvgToOtfResult(this.glyphList, this.font);

  final List<GenericGlyph> glyphList;
  final OpenTypeFont font;
}
