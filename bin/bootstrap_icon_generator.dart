import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';

import 'woff2otf.dart';

main() {
  String fontFamily =
      'BootstrapIcons'; // as defined in pubspec.yml (not bootstrap-icons as defined in the font file)
  File jsonFile = File('icons/bootstrap/bootstrap-icons.json');
  File woffFile = File('icons/bootstrap/bootstrap-icons.woff');

  File targetClass = File('lib/src/icons/bootstrap_icons.dart');
  File targetOtf = File('lib/icons/BootstrapIcons.otf');

  File targetDocsClass = File('example/lib/bootstrap_icons.dart');

  String jsonContent = jsonFile.readAsStringSync();

  WoffConverter converter = WoffConverter();
  converter.convertFile(woffFile, targetOtf);

  Map<String, dynamic> icons = json.decode(jsonContent);
  Map<String, int> generalizedIcons = {};
  for (String key in icons.keys) {
    String iconName = generateIconName(key);
    generalizedIcons[iconName] = icons[key];
  }

  String builder = 'import \'package:flutter/widgets.dart\';\n\n';
  builder += 'class BootstrapIcons {\n';
  builder += '  BootstrapIcons._();\n\n';
  for (String key in generalizedIcons.keys) {
    builder +=
        '  static const IconData $key = IconData(${generalizedIcons[key]}, fontFamily: \'$fontFamily\');\n';
  }
  builder += '}\n';
  targetClass.writeAsStringSync(builder);

  String iconDocsClass =
      'import \'package:shadcn_flutter/shadcn_flutter.dart\';\nconst Map<String, IconData> kBootstrapIcons = {\n';
  // for (int i = 0; i < svgToOtfResult.glyphList.length; i++) {
  //   iconDocsClass += '  \'${variableNames[i]}\': $name.${variableNames[i]},\n';
  // }
  for (String key in generalizedIcons.keys) {
    iconDocsClass += '  \'$key\': BootstrapIcons.$key,\n';
  }
  iconDocsClass += '};';
  targetDocsClass.writeAsStringSync(iconDocsClass);
}

String generateIconName(String name) {
  name = name.replaceAll('-', ' ');
  name = ReCase(name).camelCase;
  // check if name starts with a number, then add "icon{number}"
  if (RegExp(r'^[0-9]').hasMatch(name)) {
    name = 'icon$name';
  }
  return name;
}
