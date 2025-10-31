import 'dart:io';
import 'dart:math' as math;

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

// OKLCH to RGB conversion functions
class OklchColor {
  final double l; // lightness [0, 1]
  final double c; // chroma [0, ~0.4]
  final double h; // hue [0, 360)
  final double a; // alpha [0, 1]

  OklchColor(this.l, this.c, this.h, this.a);

  // Convert OKLCH to RGB
  List<double> toRgb() {
    // First convert OKLCH to OKLab
    final hRad = h * math.pi / 180;
    final a_ = c * math.cos(hRad);
    final b_ = c * math.sin(hRad);

    // Then convert OKLab to Linear RGB
    final l_ = l + 0.3963377774 * a_ + 0.2158037573 * b_;
    final m_ = l - 0.1055613458 * a_ - 0.0638541728 * b_;
    final s_ = l - 0.0894841775 * a_ - 1.2914855480 * b_;

    final l3 = l_ * l_ * l_;
    final m3 = m_ * m_ * m_;
    final s3 = s_ * s_ * s_;

    final r = 4.0767416621 * l3 - 3.3077115913 * m3 + 0.2309699292 * s3;
    final g = -1.2684380046 * l3 + 2.6097574011 * m3 - 0.3413193965 * s3;
    final b = -0.0041960863 * l3 - 0.7034186147 * m3 + 1.7076147010 * s3;

    // Convert linear RGB to sRGB
    return [_linearToSrgb(r), _linearToSrgb(g), _linearToSrgb(b)];
  }

  double _linearToSrgb(double c) {
    if (c <= 0.0031308) {
      return 12.92 * c;
    } else {
      return 1.055 * math.pow(c, 1.0 / 2.4) - 0.055;
    }
  }

  // Convert to Flutter Color
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

// Parse OKLCH color string
OklchColor parseOklchColor(String colorStr) {
  // Remove oklch() wrapper and normalize
  final content = colorStr.replaceAll('oklch(', '').replaceAll(')', '').trim();

  // Split by space or / for alpha
  final parts = content.split(RegExp(r'\s*/\s*|\s+'));

  if (parts.length < 3) {
    throw ArgumentError('Invalid OKLCH color format: $colorStr');
  }

  final l = double.parse(parts[0]);
  final c = double.parse(parts[1]);
  final h = double.parse(parts[2]);

  // Handle alpha if present
  double a = 1.0;
  if (parts.length > 3) {
    final alphaStr = parts[3];
    if (alphaStr.endsWith('%')) {
      a = double.parse(alphaStr.substring(0, alphaStr.length - 1)) / 100;
    } else {
      a = double.parse(alphaStr);
    }
  }

  return OklchColor(l, c, h, a);
}

// Parse CSS file and extract color variables
Map<String, Map<String, String>> parseCssFile(String filePath) {
  final file = File(filePath);
  final content = file.readAsStringSync();

  final Map<String, Map<String, String>> themes = {};

  // Split into root and dark sections
  final rootMatch = RegExp(
    r':root\s*\{([^}]+)\}',
    multiLine: true,
  ).firstMatch(content);
  final darkMatch = RegExp(
    r'\.dark\s*\{([^}]+)\}',
    multiLine: true,
  ).firstMatch(content);

  if (rootMatch != null) {
    themes['light'] = _parseVariables(rootMatch.group(1)!);
  }

  if (darkMatch != null) {
    themes['dark'] = _parseVariables(darkMatch.group(1)!);
  }

  return themes;
}

Map<String, String> _parseVariables(String cssContent) {
  final Map<String, String> variables = {};

  // Match CSS variable declarations
  final varRegex = RegExp(r'--([^:]+):\s*([^;]+);', multiLine: true);
  final matches = varRegex.allMatches(cssContent);

  for (final match in matches) {
    final name = match.group(1)!.trim();
    final value = match.group(2)!.trim();

    // Skip radius variables
    if (name == 'radius') continue;

    variables[name] = value;
  }

  return variables;
}

void main() {
  // Get all CSS files in the colors directory
  final colorsDir = Directory('colors');
  final cssFiles = colorsDir
      .listSync()
      .where((file) => file.path.endsWith('.css'))
      .cast<File>()
      .toList();

  String result = '';
  result += 'import \'../../shadcn_flutter.dart\';\n';
  result += 'import \'dart:ui\';\n';
  result += 'void _assertNotThemeModeSystem(ThemeMode mode, String label) {\n';
  result += '  if (mode == ThemeMode.system) {\n';
  result += '    final List<DiagnosticsNode> diagnosticList = [];\n';
  result +=
      '    diagnosticList.add(ErrorSummary(\'ColorSchemes.\${label.toLowerCase()}(ThemeMode mode) can only be used with ThemeMode.light or ThemeMode.dark.\'));\n';
  result +=
      '    diagnosticList.add(ErrorDescription(\'This method is only intended as a helper method to get either ColorSchemes.light\$label() or ColorSchemes.dark\$label().\'));\n';
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
      '      \'  theme: ThemeData(colorScheme: ColorSchemes.light\$label),\\n\'\n';
  result +=
      '      \'  darkTheme: ThemeData(colorScheme: ColorSchemes.dark\$label),\\n\'\n';
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
  result += '  ColorSchemes._();\n';

  // Process each CSS file
  for (final cssFile in cssFiles) {
    final fileName = cssFile.uri.pathSegments.last;
    final themeName = fileName.replaceAll('.css', '');

    // Skip if it's defaultColor.css as it might be a duplicate
    // if (themeName == 'defaultColor') continue;

    try {
      final cssData = parseCssFile(cssFile.path);
      final res = printTheme(themeName, cssData);
      result += '$res\n';
      print('Processed theme: $themeName');
    } catch (e) {
      print('Error processing $fileName: $e');
    }
  }

  result += '}';

  // write to generated file
  File('lib/src/theme/generated_themes.dart').writeAsStringSync(result);
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
      final oklchColor = parseOklchColor(value);
      final flutterColor = oklchColor.toFlutterColor();
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
      final oklchColor = parseOklchColor(value);
      final flutterColor = oklchColor.toFlutterColor();
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
  result += '\t\t\t_assertNotThemeModeSystem(mode, \'$name\');\n';
  result += '\t\t\treturn true;\n';
  result += '\t\t}());\n';
  result += '\t\treturn mode == ThemeMode.light ? light$name : dark$name;\n';
  result += '\t}\n';

  return result;
}
