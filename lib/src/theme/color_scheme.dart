import 'dart:collection';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

Color _fromAHSL(double a, double h, double s, double l) {
  return HSLColor.fromAHSL(a, h, s, l).toColor();
}

class SingleChartColorScheme implements ChartColorScheme {
  final Color color;

  const SingleChartColorScheme(this.color);

  @override
  List<Color> get chartColors => [color, color, color, color, color];

  @override
  Color get chart1 => color;

  @override
  Color get chart2 => color;

  @override
  Color get chart3 => color;

  @override
  Color get chart4 => color;

  @override
  Color get chart5 => color;
}

class ChartColorScheme {
  final List<Color> chartColors;

  const ChartColorScheme(this.chartColors);

  factory ChartColorScheme.single(Color color) {
    return SingleChartColorScheme(color);
  }

  Color get chart1 => chartColors[0];
  Color get chart2 => chartColors[1];
  Color get chart3 => chartColors[2];
  Color get chart4 => chartColors[3];
  Color get chart5 => chartColors[4];
}

class ColorShades implements Color, ColorSwatch {
  static const int _step = 100;
  static const List<int> shadeValues = [
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
  final Map<int, Color> _colors;

  ColorShades._() : _colors = {};

  @protected
  const ColorShades.raw(this._colors);

  factory ColorShades.sorted(List<Color> colors) {
    assert(colors.length == shadeValues.length,
        'ColorShades.sorted: Invalid number of colors');
    final slate = ColorShades._();
    for (int i = 0; i < shadeValues.length; i++) {
      slate._colors[shadeValues[i]] = colors[i];
    }
    return slate;
  }

  factory ColorShades.fromAccent(Color accent,
      {int base = 500,
      int hueShift = 0,
      int saturationStepDown = 0,
      int saturationStepUp = 0,
      int lightnessStepDown = 8,
      int lightnessStepUp = 9}) {
    assert(shadeValues.contains(base),
        'ColorShades.fromAccent: Invalid base value');
    final hsl = HSLColor.fromColor(accent);
    return ColorShades.fromAccentHSL(hsl,
        base: base,
        hueShift: hueShift,
        saturationStepDown: saturationStepDown,
        saturationStepUp: saturationStepUp,
        lightnessStepDown: lightnessStepDown,
        lightnessStepUp: lightnessStepUp);
  }
  factory ColorShades.fromAccentHSL(HSLColor accent,
      {int base = 500,
      int hueShift = 0,
      int saturationStepDown = 0,
      int saturationStepUp = 0,
      int lightnessStepDown = 8,
      int lightnessStepUp = 9}) {
    assert(shadeValues.contains(base),
        'ColorShades.fromAccent: Invalid base value');
    final slate = ColorShades._();
    for (final key in shadeValues) {
      double delta = (key - base) / _step;
      double hueDelta = delta * (hueShift / 10);
      double saturationDelta =
          delta > 0 ? delta * saturationStepUp : delta * saturationStepDown;
      double lightnessDelta =
          delta > 0 ? delta * lightnessStepUp : delta * lightnessStepDown;
      final h = (accent.hue + hueDelta) % 360;
      final s = (accent.saturation * 100 - saturationDelta).clamp(0, 100) / 100;
      final l = (accent.lightness * 100 - lightnessDelta).clamp(0, 100) / 100;
      final a = accent.alpha;
      slate._colors[key] = _fromAHSL(a, h, s, l);
    }
    return slate;
  }

  static HSLColor shiftHSL(
    HSLColor hsv,
    int targetBase, {
    int base = 500,
    int hueShift = 0,
    int saturationStepUp = 0,
    int saturationStepDown = 0,
    int lightnessStepUp = 9,
    int lightnessStepDown = 8,
  }) {
    assert(shadeValues.contains(base),
        'ColorShades.fromAccent: Invalid base value');
    double delta = (targetBase - base) / _step;
    double hueDelta = delta * (hueShift / 10);
    double saturationDelta =
        delta > 0 ? delta * saturationStepUp : delta * saturationStepDown;
    double lightnessDelta =
        delta > 0 ? delta * lightnessStepUp : delta * lightnessStepDown;
    final h = (hsv.hue + hueDelta) % 360;
    final s = (hsv.saturation * 100 - saturationDelta).clamp(0, 100) / 100;
    final l = (hsv.lightness * 100 - lightnessDelta).clamp(0, 100) / 100;
    final a = hsv.alpha;
    return HSLColor.fromAHSL(a, h, s, l);
  }

  factory ColorShades.fromMap(Map<int, Color> colors) {
    final slate = ColorShades._();
    for (final key in shadeValues) {
      assert(colors.containsKey(key),
          'ColorShades.fromMap: Missing value for $key');
      slate._colors[key] = colors[key]!;
    }
    return slate;
  }

  ColorShades._direct(this._colors);

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

  Color get _primary => _colors[500]!;

  @override
  int get alpha => _primary.alpha;

  @override
  int get blue => _primary.blue;

  @override
  double computeLuminance() {
    return _primary.computeLuminance();
  }

  @override
  int get green => _primary.green;

  @override
  double get opacity => _primary.opacity;

  @override
  int get red => _primary.red;

  @override
  int get value => _primary.value;

  @override
  ColorShades withAlpha(int a) {
    Map<int, Color> colors = {};
    for (final key in shadeValues) {
      colors[key] = _colors[key]!.withAlpha(a);
    }
    return ColorShades._direct(colors);
  }

  @override
  ColorShades withBlue(int b) {
    Map<int, Color> colors = {};
    // calculate the difference between the current blue value and the new value
    int delta = b - blue;
    for (final key in shadeValues) {
      int safe = (_colors[key]!.blue + delta).clamp(0, 255);
      colors[key] = _colors[key]!.withBlue(safe);
    }
    return ColorShades._direct(colors);
  }

  @override
  Color withGreen(int g) {
    Map<int, Color> colors = {};
    // calculate the difference between the current green value and the new value
    int delta = g - green;
    for (final key in shadeValues) {
      int safe = (_colors[key]!.green + delta).clamp(0, 255);
      colors[key] = _colors[key]!.withGreen(safe);
    }
    return ColorShades._direct(colors);
  }

  @override
  Color withOpacity(double opacity) {
    Map<int, Color> colors = {};
    for (final key in shadeValues) {
      colors[key] = _colors[key]!.scaleAlpha(opacity);
    }
    return ColorShades._direct(colors);
  }

  @override
  Color withRed(int r) {
    Map<int, Color> colors = {};
    // calculate the difference between the current red value and the new value
    int delta = r - red;
    for (final key in shadeValues) {
      int safe = (_colors[key]!.red + delta).clamp(0, 255);
      colors[key] = _colors[key]!.withRed(safe);
    }
    return ColorShades._direct(colors);
  }

  @override
  Color operator [](index) {
    var color = _colors[index];
    assert(color != null, 'ColorShades: Missing color for $index');
    return color!;
  }

  @override
  double get a => _primary.a;

  @override
  double get b => _primary.b;

  @override
  ColorSpace get colorSpace => _primary.colorSpace;

  @override
  double get g => _primary.g;

  @override
  Iterable get keys => _colors.keys;

  @override
  double get r => _primary.r;

  @override
  Color withValues(
      {double? alpha,
      double? red,
      double? green,
      double? blue,
      ColorSpace? colorSpace}) {
    Map<int, Color> colors = {};
    for (final key in shadeValues) {
      colors[key] = _colors[key]!.withValues(
        alpha: alpha,
        red: red,
        green: green,
        blue: blue,
        colorSpace: colorSpace,
      );
    }
    return ColorShades._direct(colors);
  }

  @override
  int toARGB32() {
    return _primary.toARGB32();
  }
}

String hexFromColor(Color color) {
  return '#${color.value.toRadixString(16).toUpperCase()}';
}

class ColorScheme implements ChartColorScheme {
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
  @override
  final Color chart1;
  @override
  final Color chart2;
  @override
  final Color chart3;
  @override
  final Color chart4;
  @override
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

  Map<String, String> toMap() {
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
    ValueGetter<Brightness>? brightness,
    ValueGetter<Color>? background,
    ValueGetter<Color>? foreground,
    ValueGetter<Color>? card,
    ValueGetter<Color>? cardForeground,
    ValueGetter<Color>? popover,
    ValueGetter<Color>? popoverForeground,
    ValueGetter<Color>? primary,
    ValueGetter<Color>? primaryForeground,
    ValueGetter<Color>? secondary,
    ValueGetter<Color>? secondaryForeground,
    ValueGetter<Color>? muted,
    ValueGetter<Color>? mutedForeground,
    ValueGetter<Color>? accent,
    ValueGetter<Color>? accentForeground,
    ValueGetter<Color>? destructive,
    ValueGetter<Color>? destructiveForeground,
    ValueGetter<Color>? border,
    ValueGetter<Color>? input,
    ValueGetter<Color>? ring,
    ValueGetter<Color>? chart1,
    ValueGetter<Color>? chart2,
    ValueGetter<Color>? chart3,
    ValueGetter<Color>? chart4,
    ValueGetter<Color>? chart5,
  }) {
    return ColorScheme(
      brightness: brightness == null ? this.brightness : brightness(),
      background: background == null ? this.background : background(),
      foreground: foreground == null ? this.foreground : foreground(),
      card: card == null ? this.card : card(),
      cardForeground:
          cardForeground == null ? this.cardForeground : cardForeground(),
      popover: popover == null ? this.popover : popover(),
      popoverForeground: popoverForeground == null
          ? this.popoverForeground
          : popoverForeground(),
      primary: primary == null ? this.primary : primary(),
      primaryForeground: primaryForeground == null
          ? this.primaryForeground
          : primaryForeground(),
      secondary: secondary == null ? this.secondary : secondary(),
      secondaryForeground: secondaryForeground == null
          ? this.secondaryForeground
          : secondaryForeground(),
      muted: muted == null ? this.muted : muted(),
      mutedForeground:
          mutedForeground == null ? this.mutedForeground : mutedForeground(),
      accent: accent == null ? this.accent : accent(),
      accentForeground:
          accentForeground == null ? this.accentForeground : accentForeground(),
      destructive: destructive == null ? this.destructive : destructive(),
      destructiveForeground: destructiveForeground == null
          ? this.destructiveForeground
          : destructiveForeground(),
      border: border == null ? this.border : border(),
      input: input == null ? this.input : input(),
      ring: ring == null ? this.ring : ring(),
      chart1: chart1 == null ? this.chart1 : chart1(),
      chart2: chart2 == null ? this.chart2 : chart2(),
      chart3: chart3 == null ? this.chart3 : chart3(),
      chart4: chart4 == null ? this.chart4 : chart4(),
      chart5: chart5 == null ? this.chart5 : chart5(),
    );
  }

  @override
  List<Color> get chartColors => [chart1, chart2, chart3, chart4, chart5];

  static ColorScheme lerp(ColorScheme a, ColorScheme b, double t) {
    return ColorScheme(
      brightness: t < 0.5 ? a.brightness : b.brightness,
      background: Color.lerp(a.background, b.background, t)!,
      foreground: Color.lerp(a.foreground, b.foreground, t)!,
      card: Color.lerp(a.card, b.card, t)!,
      cardForeground: Color.lerp(a.cardForeground, b.cardForeground, t)!,
      popover: Color.lerp(a.popover, b.popover, t)!,
      popoverForeground:
          Color.lerp(a.popoverForeground, b.popoverForeground, t)!,
      primary: Color.lerp(a.primary, b.primary, t)!,
      primaryForeground:
          Color.lerp(a.primaryForeground, b.primaryForeground, t)!,
      secondary: Color.lerp(a.secondary, b.secondary, t)!,
      secondaryForeground:
          Color.lerp(a.secondaryForeground, b.secondaryForeground, t)!,
      muted: Color.lerp(a.muted, b.muted, t)!,
      mutedForeground: Color.lerp(a.mutedForeground, b.mutedForeground, t)!,
      accent: Color.lerp(a.accent, b.accent, t)!,
      accentForeground: Color.lerp(a.accentForeground, b.accentForeground, t)!,
      destructive: Color.lerp(a.destructive, b.destructive, t)!,
      destructiveForeground:
          Color.lerp(a.destructiveForeground, b.destructiveForeground, t)!,
      border: Color.lerp(a.border, b.border, t)!,
      input: Color.lerp(a.input, b.input, t)!,
      ring: Color.lerp(a.ring, b.ring, t)!,
      chart1: Color.lerp(a.chart1, b.chart1, t)!,
      chart2: Color.lerp(a.chart2, b.chart2, t)!,
      chart3: Color.lerp(a.chart3, b.chart3, t)!,
      chart4: Color.lerp(a.chart4, b.chart4, t)!,
      chart5: Color.lerp(a.chart5, b.chart5, t)!,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ColorScheme &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          background == other.background &&
          foreground == other.foreground &&
          card == other.card &&
          cardForeground == other.cardForeground &&
          popover == other.popover &&
          popoverForeground == other.popoverForeground &&
          primary == other.primary &&
          primaryForeground == other.primaryForeground &&
          secondary == other.secondary &&
          secondaryForeground == other.secondaryForeground &&
          muted == other.muted &&
          mutedForeground == other.mutedForeground &&
          accent == other.accent &&
          accentForeground == other.accentForeground &&
          destructive == other.destructive &&
          destructiveForeground == other.destructiveForeground &&
          border == other.border &&
          input == other.input &&
          ring == other.ring &&
          chart1 == other.chart1 &&
          chart2 == other.chart2 &&
          chart3 == other.chart3 &&
          chart4 == other.chart4 &&
          chart5 == other.chart5;

  @override
  int get hashCode =>
      brightness.hashCode ^
      background.hashCode ^
      foreground.hashCode ^
      card.hashCode ^
      cardForeground.hashCode ^
      popover.hashCode ^
      popoverForeground.hashCode ^
      primary.hashCode ^
      primaryForeground.hashCode ^
      secondary.hashCode ^
      secondaryForeground.hashCode ^
      muted.hashCode ^
      mutedForeground.hashCode ^
      accent.hashCode ^
      accentForeground.hashCode ^
      destructive.hashCode ^
      destructiveForeground.hashCode ^
      border.hashCode ^
      input.hashCode ^
      ring.hashCode ^
      chart1.hashCode ^
      chart2.hashCode ^
      chart3.hashCode ^
      chart4.hashCode ^
      chart5.hashCode;

  @override
  String toString() {
    return 'ColorScheme{brightness: $brightness, background: $background, foreground: $foreground, card: $card, cardForeground: $cardForeground, popover: $popover, popoverForeground: $popoverForeground, primary: $primary, primaryForeground: $primaryForeground, secondary: $secondary, secondaryForeground: $secondaryForeground, muted: $muted, mutedForeground: $mutedForeground, accent: $accent, accentForeground: $accentForeground, destructive: $destructive, destructiveForeground: $destructiveForeground, border: $border, input: $input, ring: $ring, chart1: $chart1, chart2: $chart2, chart3: $chart3, chart4: $chart4, chart5: $chart5}';
  }
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
