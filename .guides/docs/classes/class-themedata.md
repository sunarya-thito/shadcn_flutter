---
title: "Class: ThemeData"
description: "The theme data for shadcn_flutter."
---

```dart
/// The theme data for shadcn_flutter.
///
/// Contains all theming information including colors, typography,
/// scaling, and platform-specific settings.
class ThemeData {
  /// The color scheme for this theme.
  final ColorScheme colorScheme;
  /// The typography settings for this theme.
  final Typography typography;
  /// Base radius multiplier for border radius calculations.
  final double radius;
  /// Scale factor for sizes and spacing.
  final double scaling;
  /// Icon theme properties defining icon sizes across different scales.
  final IconThemeProperties iconTheme;
  /// Default opacity for surface overlays (0.0 to 1.0).
  final double? surfaceOpacity;
  /// Default blur radius for surface effects.
  final double? surfaceBlur;
  /// Creates a [ThemeData] with light color scheme.
  ///
  /// Parameters:
  /// - [colorScheme] (`ColorScheme`, default: light colors): Color palette.
  /// - [radius] (`double`, default: 0.5): Base radius multiplier.
  /// - [scaling] (`double`, default: 1): Size scaling factor.
  /// - [typography] (`Typography`, default: Geist): Typography settings.
  /// - [iconTheme] (`IconThemeProperties`, default: standard sizes): Icon theme.
  /// - [platform] (`TargetPlatform?`, optional): Target platform override.
  /// - [surfaceOpacity] (`double?`, optional): Surface overlay opacity.
  /// - [surfaceBlur] (`double?`, optional): Surface blur radius.
  const ThemeData({this.colorScheme = ColorSchemes.lightDefaultColor, this.radius = 0.5, this.scaling = 1, this.typography = const Typography.geist(), this.iconTheme = const IconThemeProperties(), TargetPlatform? platform, this.surfaceOpacity, this.surfaceBlur});
  /// Creates a [ThemeData] with dark color scheme.
  ///
  /// Parameters:
  /// - [colorScheme] (`ColorScheme`, default: dark colors): Color palette.
  /// - [radius] (`double`, default: 0.5): Base radius multiplier.
  /// - [scaling] (`double`, default: 1): Size scaling factor.
  /// - [typography] (`Typography`, default: Geist): Typography settings.
  /// - [iconTheme] (`IconThemeProperties`, default: standard sizes): Icon theme.
  /// - [platform] (`TargetPlatform?`, optional): Target platform override.
  /// - [surfaceOpacity] (`double?`, optional): Surface overlay opacity.
  /// - [surfaceBlur] (`double?`, optional): Surface blur radius.
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
  /// Creates a circular border radius using [radiusXxl].
  BorderRadius get borderRadiusXxl;
  /// Creates a circular border radius using [radiusXl].
  BorderRadius get borderRadiusXl;
  /// Creates a circular border radius using [radiusLg].
  BorderRadius get borderRadiusLg;
  /// Creates a circular border radius using [radiusMd].
  BorderRadius get borderRadiusMd;
  /// Creates a circular border radius using [radiusSm].
  BorderRadius get borderRadiusSm;
  /// Creates a circular border radius using [radiusXs].
  BorderRadius get borderRadiusXs;
  /// Creates a circular radius using [radiusXxl].
  Radius get radiusXxlRadius;
  /// Creates a circular radius using [radiusXl].
  Radius get radiusXlRadius;
  /// Creates a circular radius using [radiusLg].
  Radius get radiusLgRadius;
  /// Creates a circular radius using [radiusMd].
  Radius get radiusMdRadius;
  /// Creates a circular radius using [radiusSm].
  Radius get radiusSmRadius;
  /// Creates a circular radius using [radiusXs].
  Radius get radiusXsRadius;
  /// Gets the brightness (light or dark) from the color scheme.
  Brightness get brightness;
  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// All parameters are optional getters that provide new values when present.
  ///
  /// Returns: `ThemeData` — a new theme with updated values.
  ThemeData copyWith({ValueGetter<ColorScheme>? colorScheme, ValueGetter<double>? radius, ValueGetter<Typography>? typography, ValueGetter<TargetPlatform>? platform, ValueGetter<double>? scaling, ValueGetter<IconThemeProperties>? iconTheme, ValueGetter<double>? surfaceOpacity, ValueGetter<double>? surfaceBlur});
  /// Linearly interpolates between two theme datas.
  ///
  /// Parameters:
  /// - [a] (`ThemeData`, required): Start theme.
  /// - [b] (`ThemeData`, required): End theme.
  /// - [t] (`double`, required): Interpolation position (0.0 to 1.0).
  ///
  /// Returns: `ThemeData` — interpolated theme.
  static ThemeData lerp(ThemeData a, ThemeData b, double t);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
