import 'dart:io';

Map<String, String> paramMapping = {
  background: 'background',
  foreground: 'foreground',
  card: 'card',
  'card-foreground': 'cardForeground',
  popover: 'popover',
  'popover-foreground': 'popoverForeground',
  primary: 'primary',
  'primary-foreground': 'primaryForeground',
  secondary: 'secondary',
  'secondary-foreground': 'secondaryForeground',
  muted: 'muted',
  'muted-foreground': 'mutedForeground',
  accent: 'accent',
  'accent-foreground': 'accentForeground',
  destructive: 'destructive',
  'destructive-foreground': 'destructiveForeground',
  border: 'border',
  input: 'input',
  ring: 'ring',
  'chart-1': 'chart1',
  'chart-2': 'chart2',
  'chart-3': 'chart3',
  'chart-4': 'chart4',
  'chart-5': 'chart5',
};

void main() {
  String result = '';
  result += 'import \'../../shadcn_flutter.dart\';\n';
  result += 'import \'dart:ui\';\n';
  result += 'void _assertNotThemeModeSystem(ThemeMode mode, String label) {\n';
  // throw FlutterError with hint to use
  /*
  ShadcnApp(
    theme: ThemeData(colorScheme: ColorSchemes.zinc(ThemeMode.light)),
    darkTheme: ThemeData(colorScheme: ColorSchemes.zinc(ThemeMode.dark)),
    themeMode: ThemeMode.system, // optional, default is ThemeMode.system
    )
    or
    ShadcnApp(
    theme: ThemeData(colorScheme: ColorSchemes.lightZinc()),
    darkTheme: ThemeData(colorScheme: ColorSchemes.darkZinc()),
    )
    instead of
    ShadcnApp(
    theme: ThemeData(colorScheme: ColorSchemes.zinc(ThemeMode.system)),
    ),
   */
  // ThemeMode? mode;
  // String? label;
  // final List<DiagnosticsNode> diagnosticList = [];
  // if (mode == ThemeMode.system) {
  //   diagnosticList.add(ErrorSummary(
  //       'ColorSchemes.${label.toLowerCase()}(ThemeMode mode) can only be used with ThemeMode.light or ThemeMode.dark.'));
  //   diagnosticList.add(ErrorDescription(
  //       'This method is only intended as a helper method to get either ColorSchemes.light$label() or ColorSchemes.dark$label().'));
  //   diagnosticList.add(ErrorHint(
  //     'To use system theme mode, do this ShadcnApp(theme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.light)), darkTheme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.dark)), themeMode: ThemeMode.system,) instead of ShadcnApp(theme: ThemeData(colorScheme: ColorSchemes.${label.toLowerCase()}(ThemeMode.system)),).',
  //   ));
  // }
  // throw FlutterError.fromParts(diagnosticList);
  result += '  if (mode == ThemeMode.system) {\n';
  result += '    final List<DiagnosticsNode> diagnosticList = [];\n';
  result +=
      '    diagnosticList.add(ErrorSummary(\'ColorSchemes.\${label.toLowerCase()}(ThemeMode mode) can only be used with ThemeMode.light or ThemeMode.dark.\'));\n';
  result +=
      '    diagnosticList.add(ErrorDescription(\'This method is only intended as a helper method to get either ColorSchemes.light\$label() or ColorSchemes.dark\$label().\'));\n';
  // result +=
  //     '    diagnosticList.add(ErrorHint(\'To use system theme mode, do this ShadcnApp(theme: ThemeData(colorScheme: ColorSchemes.\${label.toLowerCase()}(ThemeMode.light)), darkTheme: ThemeData(colorScheme: ColorSchemes.\${label.toLowerCase()}(ThemeMode.dark)), themeMode: ThemeMode.system,) instead of ShadcnApp(theme: ThemeData(colorScheme: ColorSchemes.\${label.toLowerCase()}(ThemeMode.system)),).\'));\n';
  // try to use \n in the string so the code example is more readable
  result +=
      '    diagnosticList.add(ErrorHint(\'To use system theme mode, do this:\\n\'\n';
  result += '      \'ShadcnApp(\\n\'\n';
  result +=
      '      \'  theme: ThemeData(colorScheme: ColorSchemes.\${label.toLowerCase()}(ThemeMode.light)),\\n\'\n';
  result +=
      '      \'  darkTheme: ThemeData(colorScheme: ColorSchemes.\${label.toLowerCase()}(ThemeMode.dark)),\\n\'\n';
  result +=
      '      \'  themeMode: ThemeMode.system, // optional, default is ThemeMode.system\\n\'\n';
  result += '      \')\\n\'\n';
  result += '      \'or:\\n\'\n';
  result += '      \'ShadcnApp(\\n\'\n';
  result +=
      '      \'  theme: ThemeData(colorScheme: ColorSchemes.light\$label()),\\n\'\n';
  result +=
      '      \'  darkTheme: ThemeData(colorScheme: ColorScheme.dark\$label()),\\n\'\n';
  result += '      \')\\n\'\n';
  result += '      \'instead of:\\n\'\n';
  result += '      \'ShadcnApp(\\n\'\n';
  result +=
      '      \'  theme: ThemeData(colorScheme: ColorSchemes.\${label.toLowerCase()}(ThemeMode.system)),\\n\'\n';
  result += '      \')\'));\n';

  result += '    throw FlutterError.fromParts(diagnosticList);\n';
  result += '  }\n';
  result += '}\n';
  result += 'class ColorSchemes {\n';

  for (var theme in themes) {
    String res = printTheme(theme['name'] as String, theme['cssVars'] as Map);
    result += '$res\n';
  }
  result += '}';
  // write to generated file
  File('lib/src/theme/generated_themes.dart').writeAsStringSync(result);
  print('done');
}

String printTheme(String name, Map config) {
  Map<String, String> values = {};
  Map<String, String> darkValues = {};
  for (final entry in (config[light] as Map).entries) {
    values[entry.key] = entry.value as String;
  }
  for (final entry in (config[dark] as Map).entries) {
    darkValues[entry.key] = entry.value as String;
  }
  // String name = 'Stone';
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

  // create a method to return the color scheme based on ThemeMode
  // as such:
  // static ColorScheme zinc(ThemeMode mode) {
  //   return mode == ThemeMode.light ? lightZinc() : darkZinc();
  // }

  result += '\n';
  result += '\tstatic ColorScheme ${name.toLowerCase()}(ThemeMode mode) {\n';
  result += '\t\tassert(() {\n';
  result +=
      '\t\t\t_assertNotThemeModeSystem(mode, \'$name\');\n'; // assert not system
  result += '\t\t\treturn true;\n';
  result += '\t\t}());\n';
  result +=
      '\t\treturn mode == ThemeMode.light ? light$name() : dark$name();\n';
  result += '\t}\n';
  return result;
}

// HELPER CONSTANTS
const name = "name";
const label = "label";
const activeColor = "activeColor";
const light = "light";
const dark = "dark";
const cssVars = "cssVars";
const background = "background";
const foreground = "foreground";
const card = "card";
const popover = "popover";
const primary = "primary";
const secondary = "secondary";
const muted = "muted";
const accent = "accent";
const destructive = "destructive";
const border = "border";
const input = "input";
const radius = "radius";
const ring = "ring";

// GENERATED REGION, DO NOT EDIT MANUALLY
const themes = [
  {
    name: "zinc",
    label: "Zinc",
    activeColor: {light: "240 5.9% 10%", dark: "240 5.2% 33.9%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "240 10% 3.9%",
        card: "0 0% 100%",
        "card-foreground": "240 10% 3.9%",
        popover: "0 0% 100%",
        "popover-foreground": "240 10% 3.9%",
        primary: "240 5.9% 10%",
        "primary-foreground": "0 0% 98%",
        secondary: "240 4.8% 95.9%",
        "secondary-foreground": "240 5.9% 10%",
        muted: "240 4.8% 95.9%",
        "muted-foreground": "240 3.8% 46.1%",
        accent: "240 4.8% 95.9%",
        "accent-foreground": "240 5.9% 10%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "0 0% 98%",
        border: "240 5.9% 90%",
        input: "240 5.9% 90%",
        ring: "240 5.9% 10%",
        radius: "0.5rem",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "240 10% 3.9%",
        foreground: "0 0% 98%",
        card: "240 10% 3.9%",
        "card-foreground": "0 0% 98%",
        popover: "240 10% 3.9%",
        "popover-foreground": "0 0% 98%",
        primary: "0 0% 98%",
        "primary-foreground": "240 5.9% 10%",
        secondary: "240 3.7% 15.9%",
        "secondary-foreground": "0 0% 98%",
        muted: "240 3.7% 15.9%",
        "muted-foreground": "240 5% 64.9%",
        accent: "240 3.7% 15.9%",
        "accent-foreground": "0 0% 98%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "0 0% 98%",
        border: "240 3.7% 15.9%",
        input: "240 3.7% 15.9%",
        ring: "240 4.9% 83.9%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "slate",
    label: "Slate",
    activeColor: {light: "215.4 16.3% 46.9%", dark: "215.3 19.3% 34.5%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "222.2 84% 4.9%",
        card: "0 0% 100%",
        "card-foreground": "222.2 84% 4.9%",
        popover: "0 0% 100%",
        "popover-foreground": "222.2 84% 4.9%",
        primary: "222.2 47.4% 11.2%",
        "primary-foreground": "210 40% 98%",
        secondary: "210 40% 96.1%",
        "secondary-foreground": "222.2 47.4% 11.2%",
        muted: "210 40% 96.1%",
        "muted-foreground": "215.4 16.3% 46.9%",
        accent: "210 40% 96.1%",
        "accent-foreground": "222.2 47.4% 11.2%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "210 40% 98%",
        border: "214.3 31.8% 91.4%",
        input: "214.3 31.8% 91.4%",
        ring: "222.2 84% 4.9%",
        radius: "0.5rem",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "222.2 84% 4.9%",
        foreground: "210 40% 98%",
        card: "222.2 84% 4.9%",
        "card-foreground": "210 40% 98%",
        popover: "222.2 84% 4.9%",
        "popover-foreground": "210 40% 98%",
        primary: "210 40% 98%",
        "primary-foreground": "222.2 47.4% 11.2%",
        secondary: "217.2 32.6% 17.5%",
        "secondary-foreground": "210 40% 98%",
        muted: "217.2 32.6% 17.5%",
        "muted-foreground": "215 20.2% 65.1%",
        accent: "217.2 32.6% 17.5%",
        "accent-foreground": "210 40% 98%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "210 40% 98%",
        border: "217.2 32.6% 17.5%",
        input: "217.2 32.6% 17.5%",
        ring: "212.7 26.8% 83.9",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "stone",
    label: "Stone",
    activeColor: {light: "25 5.3% 44.7%", dark: "33.3 5.5% 32.4%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "20 14.3% 4.1%",
        card: "0 0% 100%",
        "card-foreground": "20 14.3% 4.1%",
        popover: "0 0% 100%",
        "popover-foreground": "20 14.3% 4.1%",
        primary: "24 9.8% 10%",
        "primary-foreground": "60 9.1% 97.8%",
        secondary: "60 4.8% 95.9%",
        "secondary-foreground": "24 9.8% 10%",
        muted: "60 4.8% 95.9%",
        "muted-foreground": "25 5.3% 44.7%",
        accent: "60 4.8% 95.9%",
        "accent-foreground": "24 9.8% 10%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "60 9.1% 97.8%",
        border: "20 5.9% 90%",
        input: "20 5.9% 90%",
        ring: "20 14.3% 4.1%",
        radius: "0.95rem",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "20 14.3% 4.1%",
        foreground: "60 9.1% 97.8%",
        card: "20 14.3% 4.1%",
        "card-foreground": "60 9.1% 97.8%",
        popover: "20 14.3% 4.1%",
        "popover-foreground": "60 9.1% 97.8%",
        primary: "60 9.1% 97.8%",
        "primary-foreground": "24 9.8% 10%",
        secondary: "12 6.5% 15.1%",
        "secondary-foreground": "60 9.1% 97.8%",
        muted: "12 6.5% 15.1%",
        "muted-foreground": "24 5.4% 63.9%",
        accent: "12 6.5% 15.1%",
        "accent-foreground": "60 9.1% 97.8%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "60 9.1% 97.8%",
        border: "12 6.5% 15.1%",
        input: "12 6.5% 15.1%",
        ring: "24 5.7% 82.9%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "gray",
    label: "Gray",
    activeColor: {light: "220 8.9% 46.1%", dark: "215 13.8% 34.1%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "224 71.4% 4.1%",
        card: "0 0% 100%",
        "card-foreground": "224 71.4% 4.1%",
        popover: "0 0% 100%",
        "popover-foreground": "224 71.4% 4.1%",
        primary: "220.9 39.3% 11%",
        "primary-foreground": "210 20% 98%",
        secondary: "220 14.3% 95.9%",
        "secondary-foreground": "220.9 39.3% 11%",
        muted: "220 14.3% 95.9%",
        "muted-foreground": "220 8.9% 46.1%",
        accent: "220 14.3% 95.9%",
        "accent-foreground": "220.9 39.3% 11%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "210 20% 98%",
        border: "220 13% 91%",
        input: "220 13% 91%",
        ring: "224 71.4% 4.1%",
        radius: "0.35rem",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "224 71.4% 4.1%",
        foreground: "210 20% 98%",
        card: "224 71.4% 4.1%",
        "card-foreground": "210 20% 98%",
        popover: "224 71.4% 4.1%",
        "popover-foreground": "210 20% 98%",
        primary: "210 20% 98%",
        "primary-foreground": "220.9 39.3% 11%",
        secondary: "215 27.9% 16.9%",
        "secondary-foreground": "210 20% 98%",
        muted: "215 27.9% 16.9%",
        "muted-foreground": "217.9 10.6% 64.9%",
        accent: "215 27.9% 16.9%",
        "accent-foreground": "210 20% 98%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "210 20% 98%",
        border: "215 27.9% 16.9%",
        input: "215 27.9% 16.9%",
        ring: "216 12.2% 83.9%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "neutral",
    label: "Neutral",
    activeColor: {light: "0 0% 45.1%", dark: "0 0% 32.2%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "0 0% 3.9%",
        card: "0 0% 100%",
        "card-foreground": "0 0% 3.9%",
        popover: "0 0% 100%",
        "popover-foreground": "0 0% 3.9%",
        primary: "0 0% 9%",
        "primary-foreground": "0 0% 98%",
        secondary: "0 0% 96.1%",
        "secondary-foreground": "0 0% 9%",
        muted: "0 0% 96.1%",
        "muted-foreground": "0 0% 45.1%",
        accent: "0 0% 96.1%",
        "accent-foreground": "0 0% 9%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "0 0% 98%",
        border: "0 0% 89.8%",
        input: "0 0% 89.8%",
        ring: "0 0% 3.9%",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "0 0% 3.9%",
        foreground: "0 0% 98%",
        card: "0 0% 3.9%",
        "card-foreground": "0 0% 98%",
        popover: "0 0% 3.9%",
        "popover-foreground": "0 0% 98%",
        primary: "0 0% 98%",
        "primary-foreground": "0 0% 9%",
        secondary: "0 0% 14.9%",
        "secondary-foreground": "0 0% 98%",
        muted: "0 0% 14.9%",
        "muted-foreground": "0 0% 63.9%",
        accent: "0 0% 14.9%",
        "accent-foreground": "0 0% 98%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "0 0% 98%",
        border: "0 0% 14.9%",
        input: "0 0% 14.9%",
        ring: "0 0% 83.1%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "red",
    label: "Red",
    activeColor: {light: "0 72.2% 50.6%", dark: "0 72.2% 50.6%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "0 0% 3.9%",
        card: "0 0% 100%",
        "card-foreground": "0 0% 3.9%",
        popover: "0 0% 100%",
        "popover-foreground": "0 0% 3.9%",
        primary: "0 72.2% 50.6%",
        "primary-foreground": "0 85.7% 97.3%",
        secondary: "0 0% 96.1%",
        "secondary-foreground": "0 0% 9%",
        muted: "0 0% 96.1%",
        "muted-foreground": "0 0% 45.1%",
        accent: "0 0% 96.1%",
        "accent-foreground": "0 0% 9%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "0 0% 98%",
        border: "0 0% 89.8%",
        input: "0 0% 89.8%",
        ring: "0 72.2% 50.6%",
        radius: "0.4rem",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "0 0% 3.9%",
        foreground: "0 0% 98%",
        card: "0 0% 3.9%",
        "card-foreground": "0 0% 98%",
        popover: "0 0% 3.9%",
        "popover-foreground": "0 0% 98%",
        primary: "0 72.2% 50.6%",
        "primary-foreground": "0 85.7% 97.3%",
        secondary: "0 0% 14.9%",
        "secondary-foreground": "0 0% 98%",
        muted: "0 0% 14.9%",
        "muted-foreground": "0 0% 63.9%",
        accent: "0 0% 14.9%",
        "accent-foreground": "0 0% 98%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "0 0% 98%",
        border: "0 0% 14.9%",
        input: "0 0% 14.9%",
        ring: "0 72.2% 50.6%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "rose",
    label: "Rose",
    activeColor: {light: "346.8 77.2% 49.8%", dark: "346.8 77.2% 49.8%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "240 10% 3.9%",
        card: "0 0% 100%",
        "card-foreground": "240 10% 3.9%",
        popover: "0 0% 100%",
        "popover-foreground": "240 10% 3.9%",
        primary: "346.8 77.2% 49.8%",
        "primary-foreground": "355.7 100% 97.3%",
        secondary: "240 4.8% 95.9%",
        "secondary-foreground": "240 5.9% 10%",
        muted: "240 4.8% 95.9%",
        "muted-foreground": "240 3.8% 46.1%",
        accent: "240 4.8% 95.9%",
        "accent-foreground": "240 5.9% 10%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "0 0% 98%",
        border: "240 5.9% 90%",
        input: "240 5.9% 90%",
        ring: "346.8 77.2% 49.8%",
        radius: "0.5rem",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "20 14.3% 4.1%",
        foreground: "0 0% 95%",
        popover: "0 0% 9%",
        "popover-foreground": "0 0% 95%",
        card: "24 9.8% 10%",
        "card-foreground": "0 0% 95%",
        primary: "346.8 77.2% 49.8%",
        "primary-foreground": "355.7 100% 97.3%",
        secondary: "240 3.7% 15.9%",
        "secondary-foreground": "0 0% 98%",
        muted: "0 0% 15%",
        "muted-foreground": "240 5% 64.9%",
        accent: "12 6.5% 15.1%",
        "accent-foreground": "0 0% 98%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "0 85.7% 97.3%",
        border: "240 3.7% 15.9%",
        input: "240 3.7% 15.9%",
        ring: "346.8 77.2% 49.8%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "orange",
    label: "Orange",
    activeColor: {light: "24.6 95% 53.1%", dark: "20.5 90.2% 48.2%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "20 14.3% 4.1%",
        card: "0 0% 100%",
        "card-foreground": "20 14.3% 4.1%",
        popover: "0 0% 100%",
        "popover-foreground": "20 14.3% 4.1%",
        primary: "24.6 95% 53.1%",
        "primary-foreground": "60 9.1% 97.8%",
        secondary: "60 4.8% 95.9%",
        "secondary-foreground": "24 9.8% 10%",
        muted: "60 4.8% 95.9%",
        "muted-foreground": "25 5.3% 44.7%",
        accent: "60 4.8% 95.9%",
        "accent-foreground": "24 9.8% 10%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "60 9.1% 97.8%",
        border: "20 5.9% 90%",
        input: "20 5.9% 90%",
        ring: "24.6 95% 53.1%",
        radius: "0.95rem",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "20 14.3% 4.1%",
        foreground: "60 9.1% 97.8%",
        card: "20 14.3% 4.1%",
        "card-foreground": "60 9.1% 97.8%",
        popover: "20 14.3% 4.1%",
        "popover-foreground": "60 9.1% 97.8%",
        primary: "20.5 90.2% 48.2%",
        "primary-foreground": "60 9.1% 97.8%",
        secondary: "12 6.5% 15.1%",
        "secondary-foreground": "60 9.1% 97.8%",
        muted: "12 6.5% 15.1%",
        "muted-foreground": "24 5.4% 63.9%",
        accent: "12 6.5% 15.1%",
        "accent-foreground": "60 9.1% 97.8%",
        destructive: "0 72.2% 50.6%",
        "destructive-foreground": "60 9.1% 97.8%",
        border: "12 6.5% 15.1%",
        input: "12 6.5% 15.1%",
        ring: "20.5 90.2% 48.2%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "green",
    label: "Green",
    activeColor: {light: "142.1 76.2% 36.3%", dark: "142.1 70.6% 45.3%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "240 10% 3.9%",
        card: "0 0% 100%",
        "card-foreground": "240 10% 3.9%",
        popover: "0 0% 100%",
        "popover-foreground": "240 10% 3.9%",
        primary: "142.1 76.2% 36.3%",
        "primary-foreground": "355.7 100% 97.3%",
        secondary: "240 4.8% 95.9%",
        "secondary-foreground": "240 5.9% 10%",
        muted: "240 4.8% 95.9%",
        "muted-foreground": "240 3.8% 46.1%",
        accent: "240 4.8% 95.9%",
        "accent-foreground": "240 5.9% 10%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "0 0% 98%",
        border: "240 5.9% 90%",
        input: "240 5.9% 90%",
        ring: "142.1 76.2% 36.3%",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "20 14.3% 4.1%",
        foreground: "0 0% 95%",
        popover: "0 0% 9%",
        "popover-foreground": "0 0% 95%",
        card: "24 9.8% 10%",
        "card-foreground": "0 0% 95%",
        primary: "142.1 70.6% 45.3%",
        "primary-foreground": "144.9 80.4% 10%",
        secondary: "240 3.7% 15.9%",
        "secondary-foreground": "0 0% 98%",
        muted: "0 0% 15%",
        "muted-foreground": "240 5% 64.9%",
        accent: "12 6.5% 15.1%",
        "accent-foreground": "0 0% 98%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "0 85.7% 97.3%",
        border: "240 3.7% 15.9%",
        input: "240 3.7% 15.9%",
        ring: "142.4 71.8% 29.2%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "blue",
    label: "Blue",
    activeColor: {light: "221.2 83.2% 53.3%", dark: "217.2 91.2% 59.8%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "222.2 84% 4.9%",
        card: "0 0% 100%",
        "card-foreground": "222.2 84% 4.9%",
        popover: "0 0% 100%",
        "popover-foreground": "222.2 84% 4.9%",
        primary: "221.2 83.2% 53.3%",
        "primary-foreground": "210 40% 98%",
        secondary: "210 40% 96.1%",
        "secondary-foreground": "222.2 47.4% 11.2%",
        muted: "210 40% 96.1%",
        "muted-foreground": "215.4 16.3% 46.9%",
        accent: "210 40% 96.1%",
        "accent-foreground": "222.2 47.4% 11.2%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "210 40% 98%",
        border: "214.3 31.8% 91.4%",
        input: "214.3 31.8% 91.4%",
        ring: "221.2 83.2% 53.3%",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "222.2 84% 4.9%",
        foreground: "210 40% 98%",
        card: "222.2 84% 4.9%",
        "card-foreground": "210 40% 98%",
        popover: "222.2 84% 4.9%",
        "popover-foreground": "210 40% 98%",
        primary: "217.2 91.2% 59.8%",
        "primary-foreground": "222.2 47.4% 11.2%",
        secondary: "217.2 32.6% 17.5%",
        "secondary-foreground": "210 40% 98%",
        muted: "217.2 32.6% 17.5%",
        "muted-foreground": "215 20.2% 65.1%",
        accent: "217.2 32.6% 17.5%",
        "accent-foreground": "210 40% 98%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "210 40% 98%",
        border: "217.2 32.6% 17.5%",
        input: "217.2 32.6% 17.5%",
        ring: "224.3 76.3% 48%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "yellow",
    label: "Yellow",
    activeColor: {light: "47.9 95.8% 53.1%", dark: "47.9 95.8% 53.1%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "20 14.3% 4.1%",
        card: "0 0% 100%",
        "card-foreground": "20 14.3% 4.1%",
        popover: "0 0% 100%",
        "popover-foreground": "20 14.3% 4.1%",
        primary: "47.9 95.8% 53.1%",
        "primary-foreground": "26 83.3% 14.1%",
        secondary: "60 4.8% 95.9%",
        "secondary-foreground": "24 9.8% 10%",
        muted: "60 4.8% 95.9%",
        "muted-foreground": "25 5.3% 44.7%",
        accent: "60 4.8% 95.9%",
        "accent-foreground": "24 9.8% 10%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "60 9.1% 97.8%",
        border: "20 5.9% 90%",
        input: "20 5.9% 90%",
        ring: "20 14.3% 4.1%",
        radius: "0.95rem",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "20 14.3% 4.1%",
        foreground: "60 9.1% 97.8%",
        card: "20 14.3% 4.1%",
        "card-foreground": "60 9.1% 97.8%",
        popover: "20 14.3% 4.1%",
        "popover-foreground": "60 9.1% 97.8%",
        primary: "47.9 95.8% 53.1%",
        "primary-foreground": "26 83.3% 14.1%",
        secondary: "12 6.5% 15.1%",
        "secondary-foreground": "60 9.1% 97.8%",
        muted: "12 6.5% 15.1%",
        "muted-foreground": "24 5.4% 63.9%",
        accent: "12 6.5% 15.1%",
        "accent-foreground": "60 9.1% 97.8%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "60 9.1% 97.8%",
        border: "12 6.5% 15.1%",
        input: "12 6.5% 15.1%",
        ring: "35.5 91.7% 32.9%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
  {
    name: "violet",
    label: "Violet",
    activeColor: {light: "262.1 83.3% 57.8%", dark: "263.4 70% 50.4%"},
    cssVars: {
      light: {
        background: "0 0% 100%",
        foreground: "224 71.4% 4.1%",
        card: "0 0% 100%",
        "card-foreground": "224 71.4% 4.1%",
        popover: "0 0% 100%",
        "popover-foreground": "224 71.4% 4.1%",
        primary: "262.1 83.3% 57.8%",
        "primary-foreground": "210 20% 98%",
        secondary: "220 14.3% 95.9%",
        "secondary-foreground": "220.9 39.3% 11%",
        muted: "220 14.3% 95.9%",
        "muted-foreground": "220 8.9% 46.1%",
        accent: "220 14.3% 95.9%",
        "accent-foreground": "220.9 39.3% 11%",
        destructive: "0 84.2% 60.2%",
        "destructive-foreground": "210 20% 98%",
        border: "220 13% 91%",
        input: "220 13% 91%",
        ring: "262.1 83.3% 57.8%",
        "chart-1": "12 76% 61%",
        "chart-2": "173 58% 39%",
        "chart-3": "197 37% 24%",
        "chart-4": "43 74% 66%",
        "chart-5": "27 87% 67%",
      },
      dark: {
        background: "224 71.4% 4.1%",
        foreground: "210 20% 98%",
        card: "224 71.4% 4.1%",
        "card-foreground": "210 20% 98%",
        popover: "224 71.4% 4.1%",
        "popover-foreground": "210 20% 98%",
        primary: "263.4 70% 50.4%",
        "primary-foreground": "210 20% 98%",
        secondary: "215 27.9% 16.9%",
        "secondary-foreground": "210 20% 98%",
        muted: "215 27.9% 16.9%",
        "muted-foreground": "217.9 10.6% 64.9%",
        accent: "215 27.9% 16.9%",
        "accent-foreground": "210 20% 98%",
        destructive: "0 62.8% 30.6%",
        "destructive-foreground": "210 20% 98%",
        border: "215 27.9% 16.9%",
        input: "215 27.9% 16.9%",
        ring: "263.4 70% 50.4%",
        "chart-1": "220 70% 50%",
        "chart-2": "160 60% 45%",
        "chart-3": "30 80% 55%",
        "chart-4": "280 65% 60%",
        "chart-5": "340 75% 55%",
      },
    },
  },
];
