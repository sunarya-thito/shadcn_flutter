import 'dart:io';

Map<String, String> paramMapping = {
  '--background': 'background',
  '--foreground': 'foreground',
  '--card': 'card',
  '--card-foreground': 'cardForeground',
  '--popover': 'popover',
  '--popover-foreground': 'popoverForeground',
  '--primary': 'primary',
  '--primary-foreground': 'primaryForeground',
  '--secondary': 'secondary',
  '--secondary-foreground': 'secondaryForeground',
  '--muted': 'muted',
  '--muted-foreground': 'mutedForeground',
  '--accent': 'accent',
  '--accent-foreground': 'accentForeground',
  '--destructive': 'destructive',
  '--destructive-foreground': 'destructiveForeground',
  '--border': 'border',
  '--input': 'input',
  '--ring': 'ring',
};

main() {
  var dir = Directory('./themes');
  print(dir.listSync());
  var files = dir.listSync();
  String result = '';
  result += 'import \'../../shadcn_flutter.dart\';\n';
  result += 'import \'dart:ui\';\n';
  result += 'class ColorSchemes {\n';

  for (var file in files) {
    if (file.path.endsWith('.css')) {
      String res = printTheme(File(file.path));
      result += res + '\n';
    }
  }
  result += '}';
  // write to generated file
  File('lib/src/theme/generated_themes.dart').writeAsStringSync(result);
  print('done');
}

String printTheme(File file) {
  var code = file.readAsStringSync();
  var lines = code.split('\n');
  Map<String, String> values = {};
  Map<String, String> darkValues = {};
  bool isDark = false;
  for (var line in lines) {
    if (line.contains('.dark')) {
      isDark = true;
    } else if (line.contains('--')) {
      var parts = line.split(':');
      var key = parts[0].trim();
      var value = parts[1].trim();
      if (isDark) {
        darkValues[key] = value;
      } else {
        values[key] = value;
      }
    }
  }
  // String name = 'Stone';
  String name = file.path.split('/').last.split('\\').last.split('.').first;
  // capitalize first letter
  name = name[0].toUpperCase() + name.substring(1);
  String result = '';
  // print('\tfactory ColorScheme.light$name() {');
  result += '\tstatic ColorScheme light$name() {\n';
  // print('\t\treturn ColorScheme(');
  result += '\t\treturn ColorScheme(\n';
  result += '\t\t\tbrightness: Brightness.light,\n';
  for (var key in values.keys) {
    var value = values[key]; // hsl
    var paramName = paramMapping[key];
    if (paramName == null) {
      continue;
    }
    // parse value into hsl
    value = value!.replaceAll(';', '');
    var hsl = value.split(' ');
    var h = hsl[0];
    var s = hsl[1]; // percentage
    var l = hsl[2]; // percentage
    // round hsl to 2 decimal places
    double hValue = double.parse(h);
    double sValue = double.parse(s.replaceAll('%', '')) / 100;
    double lValue = double.parse(l.replaceAll('%', '')) / 100;
    hValue = (hValue * 360).roundToDouble() / 360;
    sValue = (sValue * 100).roundToDouble() / 100;
    lValue = (lValue * 100).roundToDouble() / 100;
    // print(
    //     '\t\tthis.$paramName = HSLColor.fromAHSL(1, $hValue, $sValue, $lValue).toColor(),');
    // print(
    //     '\t\t\t$paramName: const HSLColor.fromAHSL(1, $hValue, $sValue, $lValue).toColor(),');
    result +=
        '\t\t\t$paramName: const HSLColor.fromAHSL(1, $hValue, $sValue, $lValue).toColor(),\n';
  }
  // print('\t\t);');
  // print('\t}');
  // print('');
  // print('\tfactory ColorScheme.dark$name() {');
  // print('\t\treturn ColorScheme(');
  result += '\t\t);\n';
  result += '\t}\n';
  result += '\n';
  result += '\tstatic ColorScheme dark$name() {\n';
  result += '\t\treturn ColorScheme(\n';
  result += '\t\t\tbrightness: Brightness.dark,\n';
  for (var key in darkValues.keys) {
    var value = darkValues[key]; // hsl
    var paramName = paramMapping[key];
    if (paramName == null) {
      continue;
    }
    // parse value into hsl
    value = value!.replaceAll(';', '');
    var hsl = value.split(' ');
    var h = hsl[0];
    var s = hsl[1]; // percentage
    var l = hsl[2]; // percentage
    // round hsl to 2 decimal places
    double hValue = double.parse(h);
    double sValue = double.parse(s.replaceAll('%', '')) / 100;
    double lValue = double.parse(l.replaceAll('%', '')) / 100;
    hValue = (hValue * 360).roundToDouble() / 360;
    sValue = (sValue * 100).roundToDouble() / 100;
    lValue = (lValue * 100).roundToDouble() / 100;
    // print(
    //     '\t\tthis.$paramName = HSLColor.fromAHSL(1, $hValue, $sValue, $lValue).toColor(),');
    // print(
    //     '\t\t\t$paramName: const HSLColor.fromAHSL(1, $hValue, $sValue, $lValue).toColor(),');
    result +=
        '\t\t\t$paramName: const HSLColor.fromAHSL(1, $hValue, $sValue, $lValue).toColor(),\n';
  }
  // print('\t\t);');
  // print('\t}');
  // print('');
  result += '\t\t);\n';
  result += '\t}\n';
  return result;
}
