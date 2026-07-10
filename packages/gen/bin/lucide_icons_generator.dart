import 'dart:convert';
import 'dart:io';

import 'bootstrap_icon_generator.dart';

Future<void> main() async {
  String fontFamily = 'LucideIcons'; // as defined in pubspec.yml
  File jsonFile = File('packages/shadcn_flutter/icons/lucide/info.json');

  File targetClass = File('packages/shadcn_flutter/lib/src/icons/lucide_icons.dart');

  File targetDocsClass = File('packages/docs/lib/lucide_icons.dart');

  String jsonContent = jsonFile.readAsStringSync();

  Map<String, dynamic> icons = json.decode(jsonContent);
  Map<String, int> generalizedIcons = {};
  for (String key in icons.keys) {
    String iconName = generateIconName(key);
    generalizedIcons[iconName] = lucideInfoToInt(icons[key]['unicode']);
  }

  String builder = 'import \'package:flutter/widgets.dart\';\n\n';
  builder += 'class LucideIcons {\n';
  builder += '  LucideIcons._();\n\n';
  for (String key in generalizedIcons.keys) {
    builder +=
        '  static const IconData $key = IconData(${generalizedIcons[key]}, fontFamily: \'$fontFamily\', fontPackage: \'shadcn_flutter\');\n';
  }
  builder += '}\n';
  targetClass.writeAsStringSync(builder);

  String iconDocsClass =
      'import \'package:shadcn_flutter/shadcn_flutter.dart\';\nconst Map<String, IconData> kLucideIcons = {\n';
  for (String key in generalizedIcons.keys) {
    iconDocsClass += '  \'$key\': LucideIcons.$key,\n';
  }
  iconDocsClass += '};';
  targetDocsClass.writeAsStringSync(iconDocsClass);
  // copy ./icons/lucide/lucide.ttf to ./lib/icons/LucideIcons.ttf
  File sourceTtf = File('packages/shadcn_flutter/icons/lucide/lucide.ttf');
  File targetTtf = File('packages/shadcn_flutter/lib/icons/LucideIcons.ttf');
  await sourceTtf.copy(targetTtf.path);
  print('LucideIcons.ttf copied to packages/shadcn_flutter/lib/icons/LucideIcons.ttf');
}

int lucideInfoToInt(String unicodeString) {
  return int.parse(unicodeString.substring(2, unicodeString.length - 1));
}
