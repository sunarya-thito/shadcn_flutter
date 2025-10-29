import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

String colorToHex(Color color,
    [bool showAlpha = false, bool hashPrefix = true]) {
  String r = ((color.r * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
  String g = ((color.g * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
  String b = ((color.b * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
  if (showAlpha) {
    String a =
        ((color.a * 255).round() & 0xFF).toRadixString(16).padLeft(2, '0');
    return hashPrefix ? '#$a$r$g$b' : '$a$r$g$b';
  } else {
    return hashPrefix ? '#$r$g$b' : '$r$g$b';
  }
}

abstract base class ColorDerivative {
  static ColorDerivative fromColor(Color color) {
    return _HSVColor(HSVColor.fromColor(color));
  }

  const factory ColorDerivative.fromHSV(HSVColor color) = _HSVColor;
  const factory ColorDerivative.fromHSL(HSLColor color) = _HSLColor;

  const ColorDerivative();
  Color toColor();
  HSVColor toHSVColor();
  HSLColor toHSLColor();
  double get opacity;
  double get hslHue;
  double get hslSat;
  double get hslVal;
  double get hsvHue;
  double get hsvSat;
  double get hsvVal;
  int get red;
  int get green;
  int get blue;
  ColorDerivative transform(ColorDerivative old);
  ColorDerivative changeToOpacity(double alpha);
  ColorDerivative changeToColor(Color color) {
    ColorDerivative newColor = ColorDerivative.fromColor(color);
    return newColor.transform(this);
  }

  ColorDerivative changeToHSV(HSVColor color) {
    ColorDerivative newColor = ColorDerivative.fromHSV(color);
    return newColor.transform(this);
  }

  ColorDerivative changeToHSL(HSLColor color) {
    ColorDerivative newColor = ColorDerivative.fromHSL(color);
    return newColor.transform(this);
  }

  ColorDerivative changeToColorRed(double red) {
    return changeToColor(toColor().withRed(red.toInt()));
  }

  ColorDerivative changeToColorGreen(double green) {
    return changeToColor(toColor().withGreen(green.toInt()));
  }

  ColorDerivative changeToColorBlue(double blue) {
    return changeToColor(toColor().withBlue(blue.toInt()));
  }

  ColorDerivative changeToHSVHue(double hue) {
    return changeToHSV(toHSVColor().withHue(hue));
  }

  ColorDerivative changeToHSVSaturation(double saturation) {
    return changeToHSV(toHSVColor().withSaturation(saturation));
  }

  ColorDerivative changeToHSVValue(double value) {
    return changeToHSV(toHSVColor().withValue(value));
  }

  ColorDerivative changeToHSVAlpha(double alpha) {
    return changeToHSV(toHSVColor().withAlpha(alpha));
  }

  ColorDerivative changeToHSLHue(double hue) {
    return changeToHSL(toHSLColor().withHue(hue));
  }

  ColorDerivative changeToHSLSaturation(double saturation) {
    return changeToHSL(toHSLColor().withSaturation(saturation));
  }

  ColorDerivative changeToHSLLightness(double lightness) {
    return changeToHSL(toHSLColor().withLightness(lightness));
  }
}

final class _HSVColor extends ColorDerivative {
  final HSVColor color;
  const _HSVColor(this.color);

  @override
  Color toColor() {
    return color.toColor();
  }

  @override
  HSVColor toHSVColor() {
    return color;
  }

  @override
  HSLColor toHSLColor() {
    return color.toHSL();
  }

  @override
  double get opacity => color.alpha;

  @override
  ColorDerivative changeToOpacity(double alpha) {
    return _HSVColor(color.withAlpha(alpha));
  }

  @override
  ColorDerivative changeToHSVHue(double hue) {
    return _HSVColor(color.withHue(hue));
  }

  @override
  ColorDerivative changeToHSVSaturation(double saturation) {
    return _HSVColor(color.withSaturation(saturation));
  }

  @override
  ColorDerivative changeToHSVValue(double value) {
    return _HSVColor(color.withValue(value));
  }

  @override
  ColorDerivative transform(ColorDerivative old) {
    if (old is _HSVColor) {
      return _HSVColor(color);
    } else if (old is _HSLColor) {
      return _HSLColor(color.toHSL());
    } else {
      throw FlutterError('Invalid color type');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is _HSLColor) {
      return color == other.toHSVColor();
    }

    return other is _HSVColor && other.color == color;
  }

  @override
  int get hashCode => color.hashCode;

  @override
  double get hslHue => color.toHSL().hue;

  @override
  double get hslSat => color.toHSL().saturation;

  @override
  double get hslVal => color.toHSL().lightness;

  @override
  double get hsvHue => color.hue;

  @override
  double get hsvSat => color.saturation;

  @override
  double get hsvVal => color.value;

  @override
  int get red => (color.toColor().r * 255).round() & 0xFF;

  @override
  int get green => (color.toColor().g * 255).round() & 0xFF;

  @override
  int get blue => (color.toColor().b * 255).round() & 0xFF;
}

final class _HSLColor extends ColorDerivative {
  final HSLColor color;
  const _HSLColor(this.color);

  @override
  Color toColor() {
    return color.toColor();
  }

  @override
  HSVColor toHSVColor() {
    return color.toHSV();
  }

  @override
  HSLColor toHSLColor() {
    return color;
  }

  @override
  double get opacity => color.alpha;

  @override
  ColorDerivative changeToOpacity(double alpha) {
    return _HSLColor(color.withAlpha(alpha));
  }

  @override
  ColorDerivative changeToHSLHue(double hue) {
    return _HSLColor(color.withHue(hue));
  }

  @override
  ColorDerivative changeToHSLSaturation(double saturation) {
    return _HSLColor(color.withSaturation(saturation));
  }

  @override
  ColorDerivative changeToHSLLightness(double lightness) {
    return _HSLColor(color.withLightness(lightness));
  }

  @override
  ColorDerivative changeToHSVHue(double hue) {
    // should be the same as changing HSL hue
    return _HSLColor(color.withHue(hue));
  }

  @override
  ColorDerivative transform(ColorDerivative old) {
    if (old is _HSVColor) {
      return _HSVColor(color.toHSV());
    } else if (old is _HSLColor) {
      return _HSLColor(color);
    } else {
      throw FlutterError('Invalid color type');
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is _HSVColor) {
      return color == other.toHSLColor();
    }

    return other is _HSLColor && other.color == color;
  }

  @override
  int get hashCode => color.hashCode;

  @override
  double get hslHue => color.hue;

  @override
  double get hslSat => color.saturation;

  @override
  double get hslVal => color.lightness;

  @override
  double get hsvHue => color.toHSV().hue;

  @override
  double get hsvSat => color.toHSV().saturation;

  @override
  double get hsvVal => color.toHSV().value;

  @override
  int get red => (color.toColor().r * 255).toInt() & 0xFF;

  @override
  int get green => (color.toColor().g * 255).toInt() & 0xFF;

  @override
  int get blue => (color.toColor().b * 255).toInt() & 0xFF;
}

abstract class ColorGradient {
  const ColorGradient();

  ColorGradient copyWith();
  ColorGradient changeColorAt(int index, ColorDerivative color);
  ColorGradient changePositionAt(int index, double position);
  ColorGradient changeColorAndPositionAt(
      int index, ColorDerivative color, double position);
  ({ColorGradient gradient, int index}) insertColorAt(ColorDerivative color,
      Offset position, Size size, TextDirection textDirection);

  Gradient toGradient();
}

class ColorStop {
  final ColorDerivative color;
  final double position;
  const ColorStop({
    required this.color,
    required this.position,
  });
}

abstract class GradientAngleGeometry {
  const GradientAngleGeometry();
  double get angle;
  AlignmentGeometry get begin;
  AlignmentGeometry get end;

  DirectionalGradientAngle toDirectional() {
    return DirectionalGradientAngle(angle);
  }

  GradientAngle toNonDirectional() {
    return GradientAngle(angle);
  }
}

class DirectionalGradientAngle extends GradientAngleGeometry {
  @override
  final double angle;
  const DirectionalGradientAngle(this.angle);

  @override
  AlignmentGeometry get begin {
    final x = 0.5 + 0.5 * cos(angle);
    final y = 0.5 + 0.5 * sin(angle);
    return AlignmentDirectional(x * 2 - 1, y * 2 - 1);
  }

  @override
  AlignmentGeometry get end {
    final x = 0.5 + 0.5 * cos(angle + pi);
    final y = 0.5 + 0.5 * sin(angle + pi);
    return AlignmentDirectional(x * 2 - 1, y * 2 - 1);
  }
}

class GradientAngle extends GradientAngleGeometry {
  @override
  final double angle;
  const GradientAngle(this.angle);

  @override
  AlignmentGeometry get begin {
    final x = 0.5 + 0.5 * cos(angle);
    final y = 0.5 + 0.5 * sin(angle);
    return Alignment(x * 2 - 1, y * 2 - 1);
  }

  @override
  AlignmentGeometry get end {
    final x = 0.5 + 0.5 * cos(angle + pi);
    final y = 0.5 + 0.5 * sin(angle + pi);
    return Alignment(x * 2 - 1, y * 2 - 1);
  }
}

class LinearColorGradient extends ColorGradient {
  final List<ColorStop> colors;
  final GradientAngleGeometry angle;
  final TileMode tileMode;
  const LinearColorGradient({
    required this.colors,
    this.angle = const DirectionalGradientAngle(0),
    this.tileMode = TileMode.clamp,
  });

  @override
  LinearColorGradient copyWith({
    List<ColorStop>? colors,
    GradientAngleGeometry? angle,
    TileMode? tileMode,
  }) {
    return LinearColorGradient(
      colors: colors ?? this.colors,
      angle: angle ?? this.angle,
      tileMode: tileMode ?? this.tileMode,
    );
  }

  @override
  LinearColorGradient changeColorAt(int index, ColorDerivative color) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: color,
      position: newColors[index].position,
    );
    return copyWith(colors: newColors);
  }

  @override
  LinearColorGradient changePositionAt(int index, double position) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: newColors[index].color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  LinearColorGradient changeColorAndPositionAt(
      int index, ColorDerivative color, double position) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  ({LinearColorGradient gradient, int index}) insertColorAt(
      ColorDerivative color,
      Offset position,
      Size size,
      TextDirection textDirection) {
    Alignment alignBegin = angle.begin.resolve(textDirection);
    Alignment alignEnd = angle.end.resolve(textDirection);
    final dx = alignEnd.x - alignBegin.x;
    final dy = alignEnd.y - alignBegin.y;
    final lengthSquared = dx * dx + dy * dy;
    final px = (position.dx / size.width) * 2 - 1;
    final py = (position.dy / size.height) * 2 - 1;
    final t =
        ((px - alignBegin.x) * dx + (py - alignBegin.y) * dy) / lengthSquared;
    final pos = t.clamp(0.0, 1.0);
    List<ColorStop> newColors = List.from(colors);
    int insertIndex = 0;
    for (int i = 0; i < newColors.length; i++) {
      if (newColors[i].position < pos) {
        insertIndex = i + 1;
      }
    }
    newColors.insert(
      insertIndex,
      ColorStop(color: color, position: pos),
    );
    return (
      gradient: copyWith(colors: newColors),
      index: insertIndex,
    );
  }

  @override
  LinearGradient toGradient() {
    return LinearGradient(
      colors: colors.map((e) => e.color.toColor()).toList(),
      stops: colors.map((e) => e.position).toList(),
      tileMode: tileMode,
      begin: angle.begin,
      end: angle.end,
    );
  }
}

class RadialColorGradient extends ColorGradient {
  final List<ColorStop> colors;
  final TileMode tileMode;
  final AlignmentGeometry center;
  final AlignmentGeometry? focal;
  final double radius;
  final double focalRadius;
  const RadialColorGradient({
    required this.colors,
    this.tileMode = TileMode.clamp,
    this.center = Alignment.center,
    this.focal,
    this.radius = 0.5,
    this.focalRadius = 0.0,
  });

  @override
  RadialColorGradient copyWith({
    List<ColorStop>? colors,
    TileMode? tileMode,
    AlignmentGeometry? center,
    AlignmentGeometry? focal,
    double? radius,
    double? focalRadius,
  }) {
    return RadialColorGradient(
      colors: colors ?? this.colors,
      tileMode: tileMode ?? this.tileMode,
      center: center ?? this.center,
      focal: focal ?? this.focal,
      radius: radius ?? this.radius,
      focalRadius: focalRadius ?? this.focalRadius,
    );
  }

  @override
  RadialColorGradient changeColorAt(int index, ColorDerivative color) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: color,
      position: newColors[index].position,
    );
    return copyWith(colors: newColors);
  }

  @override
  RadialColorGradient changePositionAt(int index, double position) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: newColors[index].color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  RadialColorGradient changeColorAndPositionAt(
      int index, ColorDerivative color, double position) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  ({RadialColorGradient gradient, int index}) insertColorAt(
      ColorDerivative color,
      Offset position,
      Size size,
      TextDirection textDirection) {
    Alignment alignCenter = center.resolve(textDirection);
    final px = (position.dx / size.width) * 2 - 1;
    final py = (position.dy / size.height) * 2 - 1;
    final dx = px - alignCenter.x;
    final dy = py - alignCenter.y;
    final dist =
        sqrt(dx * dx + dy * dy) / sqrt(2); // max distance in square is sqrt(2)
    final pos = dist.clamp(0.0, 1.0);
    List<ColorStop> newColors = List.from(colors);
    int insertIndex = 0;
    for (int i = 0; i < newColors.length; i++) {
      if (newColors[i].position < pos) {
        insertIndex = i + 1;
      }
    }
    newColors.insert(
      insertIndex,
      ColorStop(color: color, position: pos),
    );
    return (
      gradient: copyWith(colors: newColors),
      index: insertIndex,
    );
  }

  @override
  RadialGradient toGradient() {
    return RadialGradient(
      colors: colors.map((e) => e.color.toColor()).toList(),
      stops: colors.map((e) => e.position).toList(),
      center: center,
      focal: focal,
      radius: radius,
      focalRadius: focalRadius,
      tileMode: tileMode,
    );
  }
}

class SweepColorGradient extends ColorGradient {
  final List<ColorStop> colors;
  final TileMode tileMode;
  final AlignmentGeometry center;
  final double startAngle;
  final double endAngle;
  const SweepColorGradient({
    required this.colors,
    this.tileMode = TileMode.clamp,
    this.center = Alignment.center,
    this.startAngle = 0.0,
    this.endAngle = pi * 2,
  });

  @override
  SweepColorGradient copyWith({
    List<ColorStop>? colors,
    TileMode? tileMode,
    AlignmentGeometry? center,
    double? startAngle,
    double? endAngle,
  }) {
    return SweepColorGradient(
      colors: colors ?? this.colors,
      tileMode: tileMode ?? this.tileMode,
      center: center ?? this.center,
      startAngle: startAngle ?? this.startAngle,
      endAngle: endAngle ?? this.endAngle,
    );
  }

  @override
  SweepColorGradient changeColorAt(int index, ColorDerivative color) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: color,
      position: newColors[index].position,
    );
    return copyWith(colors: newColors);
  }

  @override
  SweepColorGradient changePositionAt(int index, double position) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: newColors[index].color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  SweepColorGradient changeColorAndPositionAt(
      int index, ColorDerivative color, double position) {
    List<ColorStop> newColors = List.from(colors);
    newColors[index] = ColorStop(
      color: color,
      position: position,
    );
    return copyWith(colors: newColors);
  }

  @override
  ({SweepColorGradient gradient, int index}) insertColorAt(
      ColorDerivative color,
      Offset position,
      Size size,
      TextDirection textDirection) {
    Alignment alignCenter = center.resolve(textDirection);
    final px = (position.dx / size.width) * 2 - 1;
    final py = (position.dy / size.height) * 2 - 1;
    final dx = px - alignCenter.x;
    final dy = py - alignCenter.y;
    final angle = atan2(dy, dx);
    double normalizedAngle = angle;
    if (normalizedAngle < startAngle) {
      normalizedAngle += pi * 2;
    }
    final totalAngle = endAngle - startAngle;
    final pos = ((normalizedAngle - startAngle) / totalAngle).clamp(0.0, 1.0);
    List<ColorStop> newColors = List.from(colors);
    int insertIndex = 0;
    for (int i = 0; i < newColors.length; i++) {
      if (newColors[i].position < pos) {
        insertIndex = i + 1;
      }
    }
    newColors.insert(
      insertIndex,
      ColorStop(color: color, position: pos),
    );
    return (
      gradient: copyWith(colors: newColors),
      index: insertIndex,
    );
  }

  @override
  SweepGradient toGradient() {
    return SweepGradient(
      colors: colors.map((e) => e.color.toColor()).toList(),
      stops: colors.map((e) => e.position).toList(),
      center: center,
      startAngle: startAngle,
      endAngle: endAngle,
      tileMode: tileMode,
    );
  }
}
