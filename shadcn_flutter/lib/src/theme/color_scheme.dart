import 'dart:ui';

import 'package:flutter/painting.dart';

Color _fromAHSL(double a, double h, double s, double l) {
  return HSLColor.fromAHSL(a, h, s, l).toColor();
}

class ColorShades {
  static const int step = 100;
  static const List<int> _shadeValues = [
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900,
    950
  ];
  final Map<int, Color> _colors = {};

  ColorShades._();

  factory ColorShades.fromAccent(Color accent,
      {int base = 500,
      int hueShift = 0,
      int saturationStepDown = 8,
      int saturationStepUp = 10,
      int lightnessStepDown = 9,
      int lightnessStepUp = 7}) {
    assert(_shadeValues.contains(base),
        'ColorShades.fromAccent: Invalid base value');
    assert(0 < saturationStepDown && saturationStepDown < 20,
        'ColorShades.fromAccent: Invalid saturationStepDown value');
    assert(0 < saturationStepUp && saturationStepUp < 20,
        'ColorShades.fromAccent: Invalid saturationStepUp value');
    assert(0 < lightnessStepDown && lightnessStepDown < 20,
        'ColorShades.fromAccent: Invalid lightnessStepDown value');
    assert(0 < lightnessStepUp && lightnessStepUp < 20,
        'ColorShades.fromAccent: Invalid lightnessStepUp value');
    assert(-100 <= hueShift && hueShift < 100,
        'ColorShades.fromAccent: Invalid hueShift value');
    final slate = ColorShades._();
    final hsl = HSLColor.fromColor(accent);
    for (final key in _shadeValues) {
      double delta = (key - base) / step;
      double saturationDelta =
          delta > 0 ? delta * saturationStepUp : delta * saturationStepDown;
      double lightnessDelta =
          delta > 0 ? delta * lightnessStepUp : delta * lightnessStepDown;
      final h = (hsl.hue + hueShift) % 360;
      // final s = hsl.saturation;
      // final l = (hsl.lightness * 100 - delta).clamp(0, 100) / 100;
      final s = (hsl.saturation * 100 - saturationDelta).clamp(0, 100) / 100;
      final l = (hsl.lightness * 100 - lightnessDelta).clamp(0, 100) / 100;
      final a = hsl.alpha;
      slate._colors[key] = _fromAHSL(a, h, s, l);
    }
    return slate;
  }

  factory ColorShades.fromMap(Map<int, Color> colors) {
    final slate = ColorShades._();
    for (final key in _shadeValues) {
      assert(colors.containsKey(key),
          'ColorShades.fromMap: Missing value for $key');
      slate._colors[key] = colors[key]!;
    }
    return slate;
  }

  Color get(int key) {
    assert(_colors.containsKey(key), 'ColorShades.get: Missing value for $key');
    return _colors[key]!;
  }

  Color get shade50 => _colors[50]!;
  Color get shade100 => _colors[100]!;
  Color get shade200 => _colors[200]!;
  Color get shade300 => _colors[300]!;
  Color get shade400 => _colors[400]!;
  Color get shade500 => _colors[500]!;
  Color get shade600 => _colors[600]!;
  Color get shade700 => _colors[700]!;
  Color get shade800 => _colors[800]!;
  Color get shade900 => _colors[900]!;
  Color get shade950 => _colors[950]!;
}

String hexFromColor(Color color) {
  return '#${color.value.toRadixString(16).toUpperCase()}';
}

class ColorScheme {
  static const Set<String> colorKeys = {
    'background',
    'foreground',
    'card',
    'cardForeground',
    'popover',
    'popoverForeground',
    'primary',
    'primaryForeground',
    'secondary',
    'secondaryForeground',
    'muted',
    'mutedForeground',
    'accent',
    'accentForeground',
    'destructive',
    'destructiveForeground',
    'border',
    'input',
    'ring',
    'chart1',
    'chart2',
    'chart3',
    'chart4',
    'chart5',
  };
  final Brightness brightness;
  final Color background;
  final Color foreground;
  final Color card;
  final Color cardForeground;
  final Color popover;
  final Color popoverForeground;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color muted;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color border;
  final Color input;
  final Color ring;
  final Color chart1;
  final Color chart2;
  final Color chart3;
  final Color chart4;
  final Color chart5;

  const ColorScheme({
    required this.brightness,
    required this.background,
    required this.foreground,
    required this.card,
    required this.cardForeground,
    required this.popover,
    required this.popoverForeground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.muted,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.border,
    required this.input,
    required this.ring,
    required this.chart1,
    required this.chart2,
    required this.chart3,
    required this.chart4,
    required this.chart5,
  });

  ColorScheme.fromMap(Map<String, dynamic> map)
      : background = map._col('background'),
        foreground = map._col('foreground'),
        card = map._col('card'),
        cardForeground = map._col('cardForeground'),
        popover = map._col('popover'),
        popoverForeground = map._col('popoverForeground'),
        primary = map._col('primary'),
        primaryForeground = map._col('primaryForeground'),
        secondary = map._col('secondary'),
        secondaryForeground = map._col('secondaryForeground'),
        muted = map._col('muted'),
        mutedForeground = map._col('mutedForeground'),
        accent = map._col('accent'),
        accentForeground = map._col('accentForeground'),
        destructive = map._col('destructive'),
        destructiveForeground = map._col('destructiveForeground'),
        border = map._col('border'),
        input = map._col('input'),
        ring = map._col('ring'),
        chart1 = map._col('chart1'),
        chart2 = map._col('chart2'),
        chart3 = map._col('chart3'),
        chart4 = map._col('chart4'),
        chart5 = map._col('chart5'),
        brightness = Brightness.values
                .where((element) => element.name == map['brightness'])
                .firstOrNull ??
            Brightness.light;

  Map<String, dynamic> toMap() {
    return {
      'background': hexFromColor(background),
      'foreground': hexFromColor(foreground),
      'card': hexFromColor(card),
      'cardForeground': hexFromColor(cardForeground),
      'popover': hexFromColor(popover),
      'popoverForeground': hexFromColor(popoverForeground),
      'primary': hexFromColor(primary),
      'primaryForeground': hexFromColor(primaryForeground),
      'secondary': hexFromColor(secondary),
      'secondaryForeground': hexFromColor(secondaryForeground),
      'muted': hexFromColor(muted),
      'mutedForeground': hexFromColor(mutedForeground),
      'accent': hexFromColor(accent),
      'accentForeground': hexFromColor(accentForeground),
      'destructive': hexFromColor(destructive),
      'destructiveForeground': hexFromColor(destructiveForeground),
      'border': hexFromColor(border),
      'input': hexFromColor(input),
      'ring': hexFromColor(ring),
      'chart1': hexFromColor(chart1),
      'chart2': hexFromColor(chart2),
      'chart3': hexFromColor(chart3),
      'chart4': hexFromColor(chart4),
      'chart5': hexFromColor(chart5),
      'brightness': brightness.name,
    };
  }

  Map<String, Color> toColorMap() {
    return {
      'background': background,
      'foreground': foreground,
      'card': card,
      'cardForeground': cardForeground,
      'popover': popover,
      'popoverForeground': popoverForeground,
      'primary': primary,
      'primaryForeground': primaryForeground,
      'secondary': secondary,
      'secondaryForeground': secondaryForeground,
      'muted': muted,
      'mutedForeground': mutedForeground,
      'accent': accent,
      'accentForeground': accentForeground,
      'destructive': destructive,
      'destructiveForeground': destructiveForeground,
      'border': border,
      'input': input,
      'ring': ring,
      'chart1': chart1,
      'chart2': chart2,
      'chart3': chart3,
      'chart4': chart4,
      'chart5': chart5,
    };
  }

  ColorScheme.fromColors({
    required Map<String, Color> colors,
    required Brightness brightness,
  }) : this(
          brightness: brightness,
          background: colors._col('background'),
          foreground: colors._col('foreground'),
          card: colors._col('card'),
          cardForeground: colors._col('cardForeground'),
          popover: colors._col('popover'),
          popoverForeground: colors._col('popoverForeground'),
          primary: colors._col('primary'),
          primaryForeground: colors._col('primaryForeground'),
          secondary: colors._col('secondary'),
          secondaryForeground: colors._col('secondaryForeground'),
          muted: colors._col('muted'),
          mutedForeground: colors._col('mutedForeground'),
          accent: colors._col('accent'),
          accentForeground: colors._col('accentForeground'),
          destructive: colors._col('destructive'),
          destructiveForeground: colors._col('destructiveForeground'),
          border: colors._col('border'),
          input: colors._col('input'),
          ring: colors._col('ring'),
          chart1: colors._col('chart1'),
          chart2: colors._col('chart2'),
          chart3: colors._col('chart3'),
          chart4: colors._col('chart4'),
          chart5: colors._col('chart5'),
        );

  ColorScheme copyWith({
    Brightness? brightness,
    Color? background,
    Color? foreground,
    Color? card,
    Color? cardForeground,
    Color? popover,
    Color? popoverForeground,
    Color? primary,
    Color? primaryForeground,
    Color? secondary,
    Color? secondaryForeground,
    Color? muted,
    Color? mutedForeground,
    Color? accent,
    Color? accentForeground,
    Color? destructive,
    Color? destructiveForeground,
    Color? border,
    Color? input,
    Color? ring,
  }) {
    return ColorScheme(
      brightness: brightness ?? this.brightness,
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      card: card ?? this.card,
      cardForeground: cardForeground ?? this.cardForeground,
      popover: popover ?? this.popover,
      popoverForeground: popoverForeground ?? this.popoverForeground,
      primary: primary ?? this.primary,
      primaryForeground: primaryForeground ?? this.primaryForeground,
      secondary: secondary ?? this.secondary,
      secondaryForeground: secondaryForeground ?? this.secondaryForeground,
      muted: muted ?? this.muted,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      accent: accent ?? this.accent,
      accentForeground: accentForeground ?? this.accentForeground,
      destructive: destructive ?? this.destructive,
      destructiveForeground:
          destructiveForeground ?? this.destructiveForeground,
      border: border ?? this.border,
      input: input ?? this.input,
      ring: ring ?? this.ring,
      chart1: chart1,
      chart2: chart2,
      chart3: chart3,
      chart4: chart4,
      chart5: chart5,
    );
  }

  List<Color> get chartColors => [chart1, chart2, chart3, chart4, chart5];
}

extension _MapColorGetter on Map<String, Color> {
  Color _col(String name) {
    Color? color = this[name];
    assert(color != null, 'ColorScheme: Missing color for $name');
    return color!;
  }
}

extension _DynamicMapColorGetter on Map<String, dynamic> {
  Color _col(String name) {
    String? value = this[name];
    assert(value != null, 'ColorScheme: Missing color for $name');
    if (value!.startsWith('#')) {
      value = value.substring(1);
    }
    if (value.length == 6) {
      value = 'FF$value';
    }
    var parse = int.tryParse(value, radix: 16);
    assert(parse != null, 'ColorScheme: Invalid hex color value $value');
    return Color(parse!);
  }
}
