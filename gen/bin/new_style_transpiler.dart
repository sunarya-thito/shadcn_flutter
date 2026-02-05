import 'dart:convert';
import 'dart:io';

Map<String, String> paramMapping = {
  'background': 'background',
  'foreground': 'foreground',
  'card': 'card',
  'card-foreground': 'cardForeground',
  'popover': 'popover',
  'popover-foreground': 'popoverForeground',
  'primary': 'primary',
  'primary-foreground': 'primaryForeground',
  'secondary': 'secondary',
  'secondary-foreground': 'secondaryForeground',
  'muted': 'muted',
  'muted-foreground': 'mutedForeground',
  'accent': 'accent',
  'accent-foreground': 'accentForeground',
  'destructive': 'destructive',
  'destructive-foreground': 'destructiveForeground',
  'border': 'border',
  'input': 'input',
  'ring': 'ring',
  'chart-1': 'chart1',
  'chart-2': 'chart2',
  'chart-3': 'chart3',
  'chart-4': 'chart4',
  'chart-5': 'chart5',
  'sidebar': 'sidebar',
  'sidebar-foreground': 'sidebarForeground',
  'sidebar-primary': 'sidebarPrimary',
  'sidebar-primary-foreground': 'sidebarPrimaryForeground',
  'sidebar-accent': 'sidebarAccent',
  'sidebar-accent-foreground': 'sidebarAccentForeground',
  'sidebar-border': 'sidebarBorder',
  'sidebar-ring': 'sidebarRing',
};

/// HSL color class for parsing and converting HSL colors to Flutter Color
class HslColor {
  final double h; // hue [0, 360)
  final double s; // saturation [0, 100]
  final double l; // lightness [0, 100]
  final double a; // alpha [0, 1]

  HslColor(this.h, this.s, this.l, [this.a = 1.0]);

  /// Convert HSL to RGB
  /// Based on https://www.w3.org/TR/css-color-4/#hsl-to-rgb
  List<double> toRgb() {
    final hNorm = h / 360.0;
    final sNorm = s / 100.0;
    final lNorm = l / 100.0;

    if (sNorm == 0) {
      // Achromatic (gray)
      return [lNorm, lNorm, lNorm];
    }

    double hueToRgb(double p, double q, double t) {
      var tNorm = t;
      if (tNorm < 0) tNorm += 1;
      if (tNorm > 1) tNorm -= 1;
      if (tNorm < 1 / 6) return p + (q - p) * 6 * tNorm;
      if (tNorm < 1 / 2) return q;
      if (tNorm < 2 / 3) return p + (q - p) * (2 / 3 - tNorm) * 6;
      return p;
    }

    final q = lNorm < 0.5 ? lNorm * (1 + sNorm) : lNorm + sNorm - lNorm * sNorm;
    final p = 2 * lNorm - q;

    final r = hueToRgb(p, q, hNorm + 1 / 3);
    final g = hueToRgb(p, q, hNorm);
    final b = hueToRgb(p, q, hNorm - 1 / 3);

    return [r, g, b];
  }

  /// Convert to Flutter Color representation
  String toFlutterColor() {
    final rgb = toRgb();
    final r = (rgb[0] * 255).round().clamp(0, 255);
    final g = (rgb[1] * 255).round().clamp(0, 255);
    final b = (rgb[2] * 255).round().clamp(0, 255);
    final alpha = (a * 255).round().clamp(0, 255);

    final hex = ((alpha << 24) | (r << 16) | (g << 8) | b)
        .toRadixString(16)
        .padLeft(8, '0')
        .toUpperCase();
    return 'Color(0x$hex)';
  }
}

/// Parse HSL color string
/// Format: "H S% L%" or "H S% L% / A"
/// Examples: "0 0% 100%", "224 71.4% 4.1%", "0 84.2% 60.2% / 50%"
HslColor parseHslColor(String colorStr) {
  final content = colorStr.trim();

  // Split by / for alpha
  final alphaParts = content.split('/');
  final mainPart = alphaParts[0].trim();

  // Parse the main HSL values
  // Use regex to extract numbers with optional decimal points and %
  final regex = RegExp(r'([\d.]+)%?');
  final matches = regex.allMatches(mainPart).toList();

  if (matches.length < 3) {
    throw ArgumentError('Invalid HSL color format: $colorStr');
  }

  final h = double.parse(matches[0].group(1)!);
  final s = double.parse(matches[1].group(1)!);
  final l = double.parse(matches[2].group(1)!);

  // Handle alpha if present
  double a = 1.0;
  if (alphaParts.length > 1) {
    final alphaStr = alphaParts[1].trim();
    if (alphaStr.endsWith('%')) {
      a = double.parse(alphaStr.substring(0, alphaStr.length - 1)) / 100;
    } else {
      a = double.parse(alphaStr);
    }
  }

  return HslColor(h, s, l, a);
}

/// Parse JSON file and extract color variables
Map<String, Map<String, String>> parseJsonFile(String filePath) {
  final file = File(filePath);
  final content = file.readAsStringSync();
  final json = jsonDecode(content) as Map<String, dynamic>;

  final Map<String, Map<String, String>> themes = {};

  final cssVars = json['cssVars'] as Map<String, dynamic>?;
  if (cssVars == null) {
    throw ArgumentError('No cssVars found in $filePath');
  }

  final lightVars = cssVars['light'] as Map<String, dynamic>?;
  final darkVars = cssVars['dark'] as Map<String, dynamic>?;

  if (lightVars != null) {
    themes['light'] = lightVars.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  if (darkVars != null) {
    themes['dark'] = darkVars.map(
      (key, value) => MapEntry(key, value.toString()),
    );
  }

  return themes;
}

void main() {
  // Get all JSON files in the colors directory
  final colorsDir = Directory('../colors');
  final jsonFiles = colorsDir
      .listSync()
      .where((file) => file.path.endsWith('.json'))
      .cast<File>()
      .toList();

  String result = '';
  result += "import '../../shadcn_flutter.dart';\n";
  result += "import 'dart:ui';\n";
  result += 'void _assertNotThemeModeSystem(ThemeMode mode, String label) {\n';
  result += '  if (mode == ThemeMode.system) {\n';
  result += '    final List<DiagnosticsNode> diagnosticList = [];\n';
  result +=
      "    diagnosticList.add(ErrorSummary('ColorSchemes.\${label.toLowerCase()}(ThemeMode mode) can only be used with ThemeMode.light or ThemeMode.dark.'));\n";
  result +=
      "    diagnosticList.add(ErrorDescription('This method is only intended as a helper method to get either ColorSchemes.light\$label() or ColorSchemes.dark\$label().'));\n";
  result +=
      "    diagnosticList.add(ErrorHint('To use system theme mode, do this:\\n'\n";
  result += "      'ShadcnApp(\\n'\n";
  result +=
      "      '  theme: ThemeData(colorScheme: ColorSchemes.\${label.toLowerCase()}(ThemeMode.light)),\\n'\n";
  result +=
      "      '  darkTheme: ThemeData(colorScheme: ColorSchemes.\${label.toLowerCase()}(ThemeMode.dark)),\\n'\n";
  result +=
      "      '  themeMode: ThemeMode.system, // optional, default is ThemeMode.system\\n'\n";
  result += "      ')\\n'\n";
  result += "      'or:\\n'\n";
  result += "      'ShadcnApp(\\n'\n";
  result +=
      "      '  theme: ThemeData(colorScheme: ColorSchemes.light\$label),\\n'\n";
  result +=
      "      '  darkTheme: ThemeData(colorScheme: ColorSchemes.dark\$label),\\n'\n";
  result += "      ')\\n'\n";
  result += "      'instead of:\\n'\n";
  result += "      'ShadcnApp(\\n'\n";
  result +=
      "      '  theme: ThemeData(colorScheme: ColorSchemes.\${label.toLowerCase()}(ThemeMode.system)),\\n'\n";
  result += "      ')'));\n";

  result += '    throw FlutterError.fromParts(diagnosticList);\n';
  result += '  }\n';
  result += '}\n';
  result += 'class ColorSchemes {\n';
  result += '  ColorSchemes._();\n';

  // Process each JSON file
  for (final jsonFile in jsonFiles) {
    final fileName = jsonFile.uri.pathSegments.last;
    final themeName = fileName.replaceAll('.json', '');

    try {
      final jsonData = parseJsonFile(jsonFile.path);
      final res = printTheme(themeName, jsonData);
      result += '$res\n';
      print('Processed theme: $themeName');
    } catch (e) {
      print('Error processing $fileName: $e');
    }
  }

  result += '}';

  // write to generated file
  File('../lib/src/theme/generated_themes.dart').writeAsStringSync(result);
  print('done');
}

String printTheme(String name, Map<String, Map<String, String>> config) {
  final lightValues = config['light'] ?? <String, String>{};
  final darkValues = config['dark'] ?? <String, String>{};

  // capitalize first letter
  name = name[0].toUpperCase() + name.substring(1);
  String result = '';

  result += '\tstatic const ColorScheme light$name = \n';
  result += '\t\tColorScheme(\n';
  result += '\t\t\tbrightness: Brightness.light,\n';

  for (var key in lightValues.keys) {
    var value = lightValues[key]!;
    var paramName = paramMapping[key];
    if (paramName == null) {
      continue;
    }

    try {
      final hslColor = parseHslColor(value);
      final flutterColor = hslColor.toFlutterColor();
      result += '\t\t\t$paramName: $flutterColor,\n';
    } catch (e) {
      print('Warning: Could not parse color for $key: $value - $e');
      continue;
    }
  }

  result += '\t\t);\n';
  result += '\n';

  result += '\tstatic const ColorScheme dark$name = \n';
  result += '\t\tColorScheme(\n';
  result += '\t\t\tbrightness: Brightness.dark,\n';

  for (var key in darkValues.keys) {
    var value = darkValues[key]!;
    var paramName = paramMapping[key];
    if (paramName == null) {
      continue;
    }

    try {
      final hslColor = parseHslColor(value);
      final flutterColor = hslColor.toFlutterColor();
      result += '\t\t\t$paramName: $flutterColor,\n';
    } catch (e) {
      print('Warning: Could not parse color for $key: $value - $e');
      continue;
    }
  }

  result += '\t\t);\n';

  // create a method to return the color scheme based on ThemeMode
  result += '\n';
  result += '\tstatic ColorScheme ${name.toLowerCase()}(ThemeMode mode) {\n';
  result += '\t\tassert(() {\n';
  result += "\t\t\t_assertNotThemeModeSystem(mode, '$name');\n";
  result += '\t\t\treturn true;\n';
  result += '\t\t}());\n';
  result += '\t\treturn mode == ThemeMode.light ? light$name : dark$name;\n';
  result += '\t}\n';

  return result;
}
