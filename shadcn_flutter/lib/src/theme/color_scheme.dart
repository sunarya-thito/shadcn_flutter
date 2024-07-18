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

Color colorFromHex(String hex) {
  if (hex.startsWith('#')) {
    hex = hex.substring(1);
  }
  if (hex.length == 6) {
    hex = 'FF$hex';
  }
  return Color(int.parse(hex, radix: 16));
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
  });

  ColorScheme.fromMap(Map<String, dynamic> map)
      : background = colorFromHex(map['background']),
        foreground = colorFromHex(map['foreground']),
        card = colorFromHex(map['card']),
        cardForeground = colorFromHex(map['cardForeground']),
        popover = colorFromHex(map['popover']),
        popoverForeground = colorFromHex(map['popoverForeground']),
        primary = colorFromHex(map['primary']),
        primaryForeground = colorFromHex(map['primaryForeground']),
        secondary = colorFromHex(map['secondary']),
        secondaryForeground = colorFromHex(map['secondaryForeground']),
        muted = colorFromHex(map['muted']),
        mutedForeground = colorFromHex(map['mutedForeground']),
        accent = colorFromHex(map['accent']),
        accentForeground = colorFromHex(map['accentForeground']),
        destructive = colorFromHex(map['destructive']),
        destructiveForeground = colorFromHex(map['destructiveForeground']),
        border = colorFromHex(map['border']),
        input = colorFromHex(map['input']),
        ring = colorFromHex(map['ring']),
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
    };
  }

  ColorScheme.fromColors({
    required Map<String, Color> colors,
    required Brightness brightness,
  }) : this(
          brightness: brightness,
          background: colors['background']!,
          foreground: colors['foreground']!,
          card: colors['card']!,
          cardForeground: colors['cardForeground']!,
          popover: colors['popover']!,
          popoverForeground: colors['popoverForeground']!,
          primary: colors['primary']!,
          primaryForeground: colors['primaryForeground']!,
          secondary: colors['secondary']!,
          secondaryForeground: colors['secondaryForeground']!,
          muted: colors['muted']!,
          mutedForeground: colors['mutedForeground']!,
          accent: colors['accent']!,
          accentForeground: colors['accentForeground']!,
          destructive: colors['destructive']!,
          destructiveForeground: colors['destructiveForeground']!,
          border: colors['border']!,
          input: colors['input']!,
          ring: colors['ring']!,
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
    );
  }
}
