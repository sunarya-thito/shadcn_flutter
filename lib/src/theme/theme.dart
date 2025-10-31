import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Defines scaling behavior for adaptive layouts.
///
/// Provides different scaling strategies for text and icons.
class AdaptiveScaling {
  /// Default scaling for desktop layouts (1.0).
  static const AdaptiveScaling desktop = AdaptiveScaling();

  /// Default scaling for mobile layouts (1.25x).
  static const AdaptiveScaling mobile = AdaptiveScaling(1.25);

  /// Scaling factor for border radius.
  final double radiusScaling;

  /// Scaling factor for component sizes.
  final double sizeScaling;

  /// Scaling factor for text.
  final double textScaling;

  /// Creates uniform [AdaptiveScaling] with the same factor for all properties.
  ///
  /// Parameters:
  /// - [scaling] (`double`, default: 1): Scaling factor for radius, size, and text.
  const AdaptiveScaling([double scaling = 1])
      : this.only(
          radiusScaling: scaling,
          sizeScaling: scaling,
          textScaling: scaling,
        );

  /// Creates [AdaptiveScaling] with individual scaling factors.
  ///
  /// Parameters:
  /// - [radiusScaling] (`double`, default: 1): Border radius scaling factor.
  /// - [sizeScaling] (`double`, default: 1): Size and spacing scaling factor.
  /// - [textScaling] (`double`, default: 1): Text and icon scaling factor.
  const AdaptiveScaling.only({
    this.radiusScaling = 1,
    this.sizeScaling = 1,
    this.textScaling = 1,
  });

  /// Applies this scaling to a theme.
  ///
  /// Returns a new ThemeData with radius, sizing, typography, and icon theme
  /// scaled according to this AdaptiveScaling's factors.
  ///
  /// Parameters:
  /// - [theme] (ThemeData, required): Theme to scale
  ///
  /// Returns scaled ThemeData.
  ThemeData scale(ThemeData theme) {
    return theme.copyWith(
      radius: radiusScaling == 1 ? null : () => theme.radius * radiusScaling,
      scaling: sizeScaling == 1 ? null : () => theme.scaling * sizeScaling,
      typography:
          textScaling == 1 ? null : () => theme.typography.scale(textScaling),
      iconTheme:
          textScaling == 1 ? null : () => theme.iconTheme.scale(textScaling),
    );
  }

  /// Linearly interpolates between two AdaptiveScaling instances.
  ///
  /// Creates a new AdaptiveScaling that represents a transition between [a] and [b]
  /// at position [t]. When t=0, returns [a]; when t=1, returns [b].
  ///
  /// Parameters:
  /// - [a] (AdaptiveScaling, required): Start scaling
  /// - [b] (AdaptiveScaling, required): End scaling
  /// - [t] (double, required): Interpolation position (0.0 to 1.0)
  ///
  /// Returns interpolated AdaptiveScaling.
  static AdaptiveScaling lerp(
    AdaptiveScaling a,
    AdaptiveScaling b,
    double t,
  ) {
    return AdaptiveScaling.only(
      radiusScaling: lerpDouble(a.radiusScaling, b.radiusScaling, t)!,
      sizeScaling: lerpDouble(a.sizeScaling, b.sizeScaling, t)!,
      textScaling: lerpDouble(a.textScaling, b.textScaling, t)!,
    );
  }
}

/// A widget that applies adaptive scaling to its descendants.
class AdaptiveScaler extends StatelessWidget {
  /// Gets the default adaptive scaling for the current context.
  ///
  /// Returns [AdaptiveScaling.mobile] for iOS/Android platforms,
  /// [AdaptiveScaling.desktop] for other platforms.
  static AdaptiveScaling defaultScalingOf(BuildContext context) {
    final theme = Theme.of(context);
    return defaultScaling(theme);
  }

  /// Gets the default adaptive scaling for the given theme.
  ///
  /// Returns [AdaptiveScaling.mobile] for iOS/Android platforms,
  /// [AdaptiveScaling.desktop] for other platforms.
  static AdaptiveScaling defaultScaling(ThemeData theme) {
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.android:
        return AdaptiveScaling.mobile;
      default:
        return AdaptiveScaling.desktop;
    }
  }

  /// The scaling to apply.
  final AdaptiveScaling scaling;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates an [AdaptiveScaler].
  ///
  /// Parameters:
  /// - [scaling] (`AdaptiveScaling`, required): Scaling factors to apply.
  /// - [child] (`Widget`, required): Child widget.
  const AdaptiveScaler({
    super.key,
    required this.scaling,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      data: scaling.scale(theme),
      child: child,
    );
  }
}

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

  final TargetPlatform? _platform;

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
  const ThemeData({
    this.colorScheme = ColorSchemes.lightDefaultColor,
    this.radius = 0.5,
    this.scaling = 1,
    this.typography = const Typography.geist(),
    this.iconTheme = const IconThemeProperties(),
    TargetPlatform? platform,
    this.surfaceOpacity,
    this.surfaceBlur,
  }) : _platform = platform;

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
  const ThemeData.dark({
    this.colorScheme = ColorSchemes.darkDefaultColor,
    this.radius = 0.5,
    this.scaling = 1,
    this.typography = const Typography.geist(),
    this.iconTheme = const IconThemeProperties(),
    TargetPlatform? platform,
    this.surfaceOpacity,
    this.surfaceBlur,
  }) : _platform = platform;

  /// The current platform.
  TargetPlatform get platform => _platform ?? defaultTargetPlatform;

  /// The specified platform, or null if not overridden.
  TargetPlatform? get specifiedPlatform => _platform;

  /// At normal radius, the scaled radius is 24
  double get radiusXxl => radius * 24;

  /// At normal radius, the scaled radius is 20
  double get radiusXl => radius * 20;

  /// At normal radius, the scaled radius is 16
  double get radiusLg => radius * 16;

  /// At normal radius, the scaled radius is 12
  double get radiusMd => radius * 12;

  /// At normal radius, the scaled radius is 8
  double get radiusSm => radius * 8;

  /// At normal radius, the scaled radius is 4
  double get radiusXs => radius * 4;

  /// Creates a circular border radius using [radiusXxl].
  BorderRadius get borderRadiusXxl => BorderRadius.circular(radiusXxl);

  /// Creates a circular border radius using [radiusXl].
  BorderRadius get borderRadiusXl => BorderRadius.circular(radiusXl);

  /// Creates a circular border radius using [radiusLg].
  BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);

  /// Creates a circular border radius using [radiusMd].
  BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);

  /// Creates a circular border radius using [radiusSm].
  BorderRadius get borderRadiusSm => BorderRadius.circular(radiusSm);

  /// Creates a circular border radius using [radiusXs].
  BorderRadius get borderRadiusXs => BorderRadius.circular(radiusXs);

  /// Creates a circular radius using [radiusXxl].
  Radius get radiusXxlRadius => Radius.circular(radiusXxl);

  /// Creates a circular radius using [radiusXl].
  Radius get radiusXlRadius => Radius.circular(radiusXl);

  /// Creates a circular radius using [radiusLg].
  Radius get radiusLgRadius => Radius.circular(radiusLg);

  /// Creates a circular radius using [radiusMd].
  Radius get radiusMdRadius => Radius.circular(radiusMd);

  /// Creates a circular radius using [radiusSm].
  Radius get radiusSmRadius => Radius.circular(radiusSm);

  /// Creates a circular radius using [radiusXs].
  Radius get radiusXsRadius => Radius.circular(radiusXs);

  /// Gets the brightness (light or dark) from the color scheme.
  Brightness get brightness => colorScheme.brightness;

  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// All parameters are optional getters that provide new values when present.
  ///
  /// Returns: `ThemeData` — a new theme with updated values.
  ThemeData copyWith({
    ValueGetter<ColorScheme>? colorScheme,
    ValueGetter<double>? radius,
    ValueGetter<Typography>? typography,
    ValueGetter<TargetPlatform>? platform,
    ValueGetter<double>? scaling,
    ValueGetter<IconThemeProperties>? iconTheme,
    ValueGetter<double>? surfaceOpacity,
    ValueGetter<double>? surfaceBlur,
  }) {
    return ThemeData(
      colorScheme: colorScheme == null ? this.colorScheme : colorScheme(),
      radius: radius == null ? this.radius : radius(),
      typography: typography == null ? this.typography : typography(),
      platform: platform == null ? _platform : platform(),
      scaling: scaling == null ? this.scaling : scaling(),
      iconTheme: iconTheme == null ? this.iconTheme : iconTheme(),
      surfaceOpacity:
          surfaceOpacity == null ? this.surfaceOpacity : surfaceOpacity(),
      surfaceBlur: surfaceBlur == null ? this.surfaceBlur : surfaceBlur(),
    );
  }

  /// Linearly interpolates between two theme datas.
  ///
  /// Parameters:
  /// - [a] (`ThemeData`, required): Start theme.
  /// - [b] (`ThemeData`, required): End theme.
  /// - [t] (`double`, required): Interpolation position (0.0 to 1.0).
  ///
  /// Returns: `ThemeData` — interpolated theme.
  static ThemeData lerp(
    ThemeData a,
    ThemeData b,
    double t,
  ) {
    return ThemeData(
      colorScheme: ColorScheme.lerp(a.colorScheme, b.colorScheme, t),
      radius: lerpDouble(a.radius, b.radius, t)!,
      typography: Typography.lerp(a.typography, b.typography, t),
      platform: t < 0.5 ? a.platform : b.platform,
      scaling: lerpDouble(a.scaling, b.scaling, t)!,
      iconTheme: IconThemeProperties.lerp(a.iconTheme, b.iconTheme, t),
      surfaceOpacity: lerpDouble(a.surfaceOpacity, b.surfaceOpacity, t),
      surfaceBlur: lerpDouble(a.surfaceBlur, b.surfaceBlur, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThemeData &&
        other.colorScheme == colorScheme &&
        other.typography == typography &&
        other.radius == radius &&
        other.scaling == scaling &&
        other.iconTheme == iconTheme &&
        other.surfaceOpacity == surfaceOpacity &&
        other.surfaceBlur == surfaceBlur;
  }

  @override
  int get hashCode {
    return Object.hash(
      colorScheme,
      typography,
      radius,
      scaling,
      iconTheme,
      surfaceOpacity,
      surfaceBlur,
    );
  }

  @override
  String toString() {
    return 'ThemeData(colorScheme: $colorScheme, typography: $typography, radius: $radius, scaling: $scaling, iconTheme: $iconTheme, surfaceOpacity: $surfaceOpacity, surfaceBlur: $surfaceBlur)';
  }
}

/// An inherited widget that provides theme data to its descendants.
class Theme extends InheritedTheme {
  /// The theme data to provide to descendants.
  final ThemeData data;

  /// Creates a [Theme].
  ///
  /// Parameters:
  /// - [data] (`ThemeData`, required): Theme data to provide.
  /// - [child] (`Widget`, required): Child widget.
  const Theme({
    super.key,
    required this.data,
    required super.child,
  });

  /// Gets the [ThemeData] from the closest [Theme] ancestor.
  ///
  /// Throws if no [Theme] is found in the widget tree.
  ///
  /// Returns: `ThemeData` — the theme data.
  static ThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<Theme>();
    assert(theme != null, 'No Theme found in context');
    return theme!.data;
  }

  @override
  bool updateShouldNotify(covariant Theme oldWidget) {
    return oldWidget.data != data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    final Theme? ancestorTheme = context.findAncestorWidgetOfExactType<Theme>();
    return identical(this, ancestorTheme)
        ? child
        : Theme(data: data, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeData>('data', data));
  }
}

/// A tween for animating between two [ThemeData] values.
class ThemeDataTween extends Tween<ThemeData> {
  /// Creates a [ThemeDataTween].
  ///
  /// Parameters:
  /// - [begin] (`ThemeData`, required): Starting theme.
  /// - [end] (`ThemeData`, required): Ending theme.
  ThemeDataTween({required ThemeData super.begin, required super.end});

  @override
  ThemeData lerp(double t) {
    if (end == null) {
      return begin!;
    }
    return ThemeData.lerp(begin!, end!, t);
  }
}

/// A widget that animates theme changes over time.
class AnimatedTheme extends ImplicitlyAnimatedWidget {
  /// The target theme data to animate to.
  final ThemeData data;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates an [AnimatedTheme].
  ///
  /// Parameters:
  /// - [data] (`ThemeData`, required): Target theme.
  /// - [duration] (`Duration`, required): Animation duration.
  /// - [curve] (`Curve`, optional): Animation curve.
  /// - [child] (`Widget`, required): Child widget.
  const AnimatedTheme({
    super.key,
    required this.data,
    required super.duration,
    super.curve,
    required this.child,
  });

  @override
  AnimatedWidgetBaseState<AnimatedTheme> createState() => _AnimatedThemeState();
}

class _AnimatedThemeState extends AnimatedWidgetBaseState<AnimatedTheme> {
  ThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
      _data,
      widget.data,
      (dynamic value) => ThemeDataTween(begin: value as ThemeData, end: null),
    ) as ThemeDataTween?;
  }

  @override
  Widget build(BuildContext context) {
    final theme = _data!.evaluate(animation);
    return Theme(data: theme, child: widget.child);
  }
}

/// Properties for icon theming.
///
/// Defines size and color for different icon sizes across the theme.
class IconThemeProperties {
  /// Icon theme for 4x-small icons (6px).
  final IconThemeData x4Small;

  /// Icon theme for 3x-small icons (8px).
  final IconThemeData x3Small;

  /// Icon theme for 2x-small icons (10px).
  final IconThemeData x2Small;

  /// Icon theme for extra-small icons (12px).
  final IconThemeData xSmall;

  /// Icon theme for small icons (16px).
  final IconThemeData small;

  /// Icon theme for medium icons (20px).
  final IconThemeData medium;

  /// Icon theme for large icons (24px).
  final IconThemeData large;

  /// Icon theme for extra-large icons (32px).
  final IconThemeData xLarge;

  /// Icon theme for 2x-large icons (40px).
  final IconThemeData x2Large;

  /// Icon theme for 3x-large icons (48px).
  final IconThemeData x3Large;

  /// Icon theme for 4x-large icons (56px).
  final IconThemeData x4Large;

  /// Creates [IconThemeProperties] with default icon sizes.
  ///
  /// All parameters are optional and default to predefined sizes.
  const IconThemeProperties({
    this.x4Small = const IconThemeData(size: 6),
    this.x3Small = const IconThemeData(size: 8),
    this.x2Small = const IconThemeData(size: 10),
    this.xSmall = const IconThemeData(size: 12),
    this.small = const IconThemeData(size: 16),
    this.medium = const IconThemeData(size: 20),
    this.large = const IconThemeData(size: 24),
    this.xLarge = const IconThemeData(size: 32),
    this.x2Large = const IconThemeData(size: 40),
    this.x3Large = const IconThemeData(size: 48),
    this.x4Large = const IconThemeData(size: 56),
  });

  /// Creates a copy with updated icon themes.
  ///
  /// All parameters are optional getters. Omitted values retain their current value.
  ///
  /// Returns: `IconThemeProperties` — a new instance with updated values.
  IconThemeProperties copyWith({
    ValueGetter<IconThemeData>? x4Small,
    ValueGetter<IconThemeData>? x3Small,
    ValueGetter<IconThemeData>? x2Small,
    ValueGetter<IconThemeData>? xSmall,
    ValueGetter<IconThemeData>? small,
    ValueGetter<IconThemeData>? medium,
    ValueGetter<IconThemeData>? large,
    ValueGetter<IconThemeData>? xLarge,
    ValueGetter<IconThemeData>? x2Large,
    ValueGetter<IconThemeData>? x3Large,
    ValueGetter<IconThemeData>? x4Large,
  }) {
    return IconThemeProperties(
      x4Small: x4Small == null ? this.x4Small : x4Small(),
      x3Small: x3Small == null ? this.x3Small : x3Small(),
      x2Small: x2Small == null ? this.x2Small : x2Small(),
      xSmall: xSmall == null ? this.xSmall : xSmall(),
      small: small == null ? this.small : small(),
      medium: medium == null ? this.medium : medium(),
      large: large == null ? this.large : large(),
      xLarge: xLarge == null ? this.xLarge : xLarge(),
      x2Large: x2Large == null ? this.x2Large : x2Large(),
      x3Large: x3Large == null ? this.x3Large : x3Large(),
      x4Large: x4Large == null ? this.x4Large : x4Large(),
    );
  }

  /// Scales all icon sizes by the given factor.
  ///
  /// Parameters:
  /// - [factor] (`double`, required): Scaling factor to apply.
  ///
  /// Returns: `IconThemeProperties` — scaled icon theme properties.
  IconThemeProperties scale(double factor) {
    return IconThemeProperties(
      x4Small: x4Small.size == null
          ? x4Small
          : x4Small.copyWith(size: x4Small.size! * factor),
      x3Small: x3Small.size == null
          ? x3Small
          : x3Small.copyWith(size: x3Small.size! * factor),
      x2Small: x2Small.size == null
          ? x2Small
          : x2Small.copyWith(size: x2Small.size! * factor),
      xSmall: xSmall.size == null
          ? xSmall
          : xSmall.copyWith(size: xSmall.size! * factor),
      small: small.size == null
          ? small
          : small.copyWith(size: small.size! * factor),
      medium: medium.size == null
          ? medium
          : medium.copyWith(size: medium.size! * factor),
      large: large.size == null
          ? large
          : large.copyWith(size: large.size! * factor),
      xLarge: xLarge.size == null
          ? xLarge
          : xLarge.copyWith(size: xLarge.size! * factor),
      x2Large: x2Large.size == null
          ? x2Large
          : x2Large.copyWith(size: x2Large.size! * factor),
      x3Large: x3Large.size == null
          ? x3Large
          : x3Large.copyWith(size: x3Large.size! * factor),
      x4Large: x4Large.size == null
          ? x4Large
          : x4Large.copyWith(size: x4Large.size! * factor),
    );
  }

  /// Linearly interpolates between two icon theme properties.
  ///
  /// Parameters:
  /// - [a] (`IconThemeProperties`, required): Start properties.
  /// - [b] (`IconThemeProperties`, required): End properties.
  /// - [t] (`double`, required): Interpolation position (0.0 to 1.0).
  ///
  /// Returns: `IconThemeProperties` — interpolated properties.
  static IconThemeProperties lerp(
    IconThemeProperties a,
    IconThemeProperties b,
    double t,
  ) {
    return IconThemeProperties(
      x4Small: IconThemeData.lerp(a.x4Small, b.x4Small, t),
      x3Small: IconThemeData.lerp(a.x3Small, b.x3Small, t),
      x2Small: IconThemeData.lerp(a.x2Small, b.x2Small, t),
      xSmall: IconThemeData.lerp(a.xSmall, b.xSmall, t),
      small: IconThemeData.lerp(a.small, b.small, t),
      medium: IconThemeData.lerp(a.medium, b.medium, t),
      large: IconThemeData.lerp(a.large, b.large, t),
      xLarge: IconThemeData.lerp(a.xLarge, b.xLarge, t),
      x2Large: IconThemeData.lerp(a.x2Large, b.x2Large, t),
      x3Large: IconThemeData.lerp(a.x3Large, b.x3Large, t),
      x4Large: IconThemeData.lerp(a.x4Large, b.x4Large, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IconThemeProperties &&
        other.x4Small == x4Small &&
        other.x3Small == x3Small &&
        other.x2Small == x2Small &&
        other.xSmall == xSmall &&
        other.small == small &&
        other.medium == medium &&
        other.large == large &&
        other.xLarge == xLarge &&
        other.x2Large == x2Large &&
        other.x3Large == x3Large &&
        other.x4Large == x4Large;
  }

  @override
  int get hashCode {
    return Object.hash(
      x4Small,
      x3Small,
      x2Small,
      xSmall,
      small,
      medium,
      large,
      xLarge,
      x2Large,
      x3Large,
      x4Large,
    );
  }

  @override
  String toString() {
    return 'IconThemeProperties(x4Small: $x4Small, x3Small: $x3Small, x2Small: $x2Small, xSmall: $xSmall, small: $small, medium: $medium, large: $large, xLarge: $xLarge, x2Large: $x2Large, x3Large: $x3Large, x4Large: $x4Large)';
  }
}

/// An inherited widget that provides component-specific theme data.
///
/// Allows components to provide custom theme data that overrides or extends
/// the global theme. The type parameter `T` specifies the theme data type.
///
/// Example:
/// ```dart
/// ComponentTheme<ButtonTheme>(
///   data: ButtonTheme(backgroundColor: Colors.blue),
///   child: MyButton(),
/// )
/// ```
class ComponentTheme<T> extends InheritedTheme {
  /// The component theme data to provide to descendants.
  final T data;

  /// Creates a [ComponentTheme].
  ///
  /// Parameters:
  /// - [data] (`T`, required): Theme data for this component type.
  /// - [child] (`Widget`, required): Child widget.
  const ComponentTheme({
    super.key,
    required this.data,
    required super.child,
  });

  @override
  Widget wrap(BuildContext context, Widget child) {
    ComponentTheme<T>? ancestorTheme =
        context.findAncestorWidgetOfExactType<ComponentTheme<T>>();
    // if it's the same type, we don't need to wrap it
    if (identical(this, ancestorTheme)) {
      return child;
    }
    return ComponentTheme<T>(
      data: data,
      child: child,
    );
  }

  /// Gets the component theme data of type `T` from the closest ancestor.
  ///
  /// Throws if no [ComponentTheme] of type `T` is found.
  ///
  /// Returns: `T` — the component theme data.
  static T of<T>(BuildContext context) {
    final data = maybeOf<T>(context);
    assert(data != null, 'No ComponentTheme<$T> found in context');
    return data!;
  }

  /// Gets the component theme data of type `T` from the closest ancestor.
  ///
  /// Returns `null` if no [ComponentTheme] of type `T` is found.
  ///
  /// Returns: `T?` — the component theme data, or null.
  static T? maybeOf<T>(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<ComponentTheme<T>>();
    if (widget == null) {
      return null;
    }
    return widget.data;
  }

  @override
  bool updateShouldNotify(covariant ComponentTheme<T> oldWidget) {
    return oldWidget.data != data;
  }
}

/// Determines which theme mode to use.
///
/// - `system`: Follow system theme preference
/// - `light`: Always use light theme
/// - `dark`: Always use dark theme
enum ThemeMode {
  /// Follow the system theme (light or dark based on device settings).
  system,

  /// Always use light theme.
  light,

  /// Always use dark theme.
  dark,
}
