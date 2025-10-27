---
title: "Class: ThemeData"
description: "Reference for ThemeData"
---

```dart
class ThemeData {
  final ColorScheme colorScheme;
  final Typography typography;
  final double radius;
  final double scaling;
  final IconThemeProperties iconTheme;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  const ThemeData({this.colorScheme = ColorSchemes.lightDefaultColor, this.radius = 0.5, this.scaling = 1, this.typography = const Typography.geist(), this.iconTheme = const IconThemeProperties(), TargetPlatform? platform, this.surfaceOpacity, this.surfaceBlur});
  const ThemeData.dark({this.colorScheme = ColorSchemes.darkDefaultColor, this.radius = 0.5, this.scaling = 1, this.typography = const Typography.geist(), this.iconTheme = const IconThemeProperties(), TargetPlatform? platform, this.surfaceOpacity, this.surfaceBlur});
  /// The current platform.
  TargetPlatform get platform;
  /// At normal radius, the scaled radius is 24
  double get radiusXxl;
  /// At normal radius, the scaled radius is 20
  double get radiusXl;
  /// At normal radius, the scaled radius is 16
  double get radiusLg;
  /// At normal radius, the scaled radius is 12
  double get radiusMd;
  /// At normal radius, the scaled radius is 8
  double get radiusSm;
  /// At normal radius, the scaled radius is 4
  double get radiusXs;
  BorderRadius get borderRadiusXxl;
  BorderRadius get borderRadiusXl;
  BorderRadius get borderRadiusLg;
  BorderRadius get borderRadiusMd;
  BorderRadius get borderRadiusSm;
  BorderRadius get borderRadiusXs;
  Radius get radiusXxlRadius;
  Radius get radiusXlRadius;
  Radius get radiusLgRadius;
  Radius get radiusMdRadius;
  Radius get radiusSmRadius;
  Radius get radiusXsRadius;
  Brightness get brightness;
  ThemeData copyWith({ValueGetter<ColorScheme>? colorScheme, ValueGetter<double>? radius, ValueGetter<Typography>? typography, ValueGetter<TargetPlatform>? platform, ValueGetter<double>? scaling, ValueGetter<IconThemeProperties>? iconTheme, ValueGetter<double>? surfaceOpacity, ValueGetter<double>? surfaceBlur});
  static ThemeData lerp(ThemeData a, ThemeData b, double t);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
