import 'dart:io';

import 'package:recase/recase.dart';

import 'woff2otf.dart';

// Extract these css:
//.icon-align-vertical-centers:before {
//   content: "\e13e";
// }
//
// .icon-align-top:before {
//   content: "\e13f";
// }
// to get the icon name, and icon codepoint

const kUnsafeName = [
  'switch',
];

main() {
  String fontFamily =
      'RadixIcons'; // as defined in pubspec.yml (not bootstrap-icons as defined in the font file)
  File cssFile = File('icons/radix/iconly.css');
  File woffFile = File('icons/radix/iconly.woff');

  File targetClass = File('lib/src/icons/radix_icons.dart');
  File targetOtf = File('lib/icons/RadixIcons.otf');

  File targetDocsClass = File('example/lib/radix_icons.dart');

  String cssContent = cssFile.readAsStringSync();

  WoffConverter converter = WoffConverter();
  converter.convertFile(woffFile, targetOtf);

  Map<String, int> generalizedIcons = {};
  List<String> lines = cssContent.split('\n');
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i].trim();
    if (line.startsWith('.') && line.endsWith(':before {')) {
      String iconName = line.substring(1, line.indexOf(':'));
      if (iconName.startsWith("icon-") &&
          !kUnsafeName.contains(iconName.substring(5))) {
        iconName = iconName.substring(5);
      }
      iconName = generateIconName(iconName);
      String nextLine = lines[i + 1].trim();
      nextLine = nextLine.substring(nextLine.indexOf('"') + 1);
      nextLine = nextLine.substring(0, nextLine.indexOf('"'));
      // nextLine would look something like this: \e002
      // parse it to get the codepoint
      int codepoint = int.parse(nextLine.substring(1), radix: 16);
      generalizedIcons[iconName] = codepoint;
    }
  }

  String builder = 'import \'package:flutter/widgets.dart\';\n\n';
  builder += 'class RadixIcons {\n';
  builder += '  RadixIcons._();\n\n';
  for (String key in generalizedIcons.keys) {
    builder +=
        '  static const IconData $key = IconData(${generalizedIcons[key]}, fontFamily: \'$fontFamily\');\n';
  }
  builder += '}\n';
  targetClass.writeAsStringSync(builder);

  String iconDocsClass =
      'import \'package:shadcn_flutter/shadcn_flutter.dart\';\nconst Map<String, IconData> kRadixIcons = {\n';
  // for (int i = 0; i < svgToOtfResult.glyphList.length; i++) {
  //   iconDocsClass += '  \'${variableNames[i]}\': $name.${variableNames[i]},\n';
  // }
  for (String key in generalizedIcons.keys) {
    iconDocsClass += '  \'$key\': RadixIcons.$key,\n';
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
