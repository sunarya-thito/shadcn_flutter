import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AdaptiveScaling {
  static const AdaptiveScaling desktop = AdaptiveScaling();
  static const AdaptiveScaling mobile = AdaptiveScaling(1.25);
  final double radiusScaling;
  final double sizeScaling;
  final double textScaling;

  const AdaptiveScaling([double scaling = 1])
      : this.only(
          radiusScaling: scaling,
          sizeScaling: scaling,
          textScaling: scaling,
        );

  const AdaptiveScaling.only({
    this.radiusScaling = 1,
    this.sizeScaling = 1,
    this.textScaling = 1,
  });

  ThemeData scale(ThemeData theme) {
    return theme.copyWith(
      radius: radiusScaling == 1 ? null : theme.radius * radiusScaling,
      scaling: sizeScaling == 1 ? null : theme.scaling * sizeScaling,
      typography: textScaling == 1 ? null : theme.typography.scale(textScaling),
      iconTheme: textScaling == 1 ? null : theme.iconTheme.scale(textScaling),
    );
  }

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

class AdaptiveScaler extends StatelessWidget {
  static AdaptiveScaling defaultScalingOf(BuildContext context) {
    final theme = Theme.of(context);
    return defaultScaling(theme);
  }

  static AdaptiveScaling defaultScaling(ThemeData theme) {
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.android:
        return AdaptiveScaling.mobile;
      default:
        return AdaptiveScaling.desktop;
    }
  }

  final AdaptiveScaling scaling;
  final Widget child;

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

class ThemeData {
  final ColorScheme colorScheme;
  final Typography typography;
  final double radius;
  final double scaling;
  final TargetPlatform? _platform;
  final IconThemeProperties iconTheme;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  ThemeData({
    required this.colorScheme,
    required this.radius,
    this.scaling = 1,
    this.typography = const Typography.geist(),
    this.iconTheme = const IconThemeProperties(),
    TargetPlatform? platform,
    this.surfaceOpacity,
    this.surfaceBlur,
  }) : _platform = platform;

  TargetPlatform get platform => _platform ?? defaultTargetPlatform;

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

  BorderRadius get borderRadiusXxl => BorderRadius.circular(radiusXxl);
  BorderRadius get borderRadiusXl => BorderRadius.circular(radiusXl);
  BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);
  BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);
  BorderRadius get borderRadiusSm => BorderRadius.circular(radiusSm);
  BorderRadius get borderRadiusXs => BorderRadius.circular(radiusXs);

  Radius get radiusXxlRadius => Radius.circular(radiusXxl);
  Radius get radiusXlRadius => Radius.circular(radiusXl);
  Radius get radiusLgRadius => Radius.circular(radiusLg);
  Radius get radiusMdRadius => Radius.circular(radiusMd);
  Radius get radiusSmRadius => Radius.circular(radiusSm);
  Radius get radiusXsRadius => Radius.circular(radiusXs);

  Brightness get brightness => colorScheme.brightness;

  ThemeData copyWith({
    ColorScheme? colorScheme,
    double? radius,
    Typography? typography,
    TargetPlatform? platform,
    double? scaling,
    IconThemeProperties? iconTheme,
    double? surfaceOpacity,
    double? surfaceBlur,
  }) {
    return ThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      radius: radius ?? this.radius,
      typography: typography ?? this.typography,
      platform: platform ?? _platform,
      scaling: scaling ?? this.scaling,
      iconTheme: iconTheme ?? this.iconTheme,
      surfaceOpacity: surfaceOpacity ?? this.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? this.surfaceBlur,
    );
  }

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
}

class Theme extends InheritedTheme {
  final ThemeData data;

  const Theme({
    super.key,
    required this.data,
    required super.child,
  });

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

class ThemeDataTween extends Tween<ThemeData> {
  ThemeDataTween({required ThemeData super.begin, required super.end});

  @override
  ThemeData lerp(double t) {
    if (end == null) {
      return begin!;
    }
    return ThemeData.lerp(begin!, end!, t);
  }
}

class AnimatedTheme extends ImplicitlyAnimatedWidget {
  final ThemeData data;
  final Widget child;

  const AnimatedTheme({
    super.key,
    required this.data,
    required super.duration,
    super.curve,
    required this.child,
  });

  @override
  _AnimatedThemeState createState() => _AnimatedThemeState();
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

class IconThemeProperties {
  final IconThemeData x4Small;
  final IconThemeData x3Small;
  final IconThemeData x2Small;
  final IconThemeData xSmall;
  final IconThemeData small;
  final IconThemeData medium;
  final IconThemeData large;
  final IconThemeData xLarge;
  final IconThemeData x2Large;
  final IconThemeData x3Large;
  final IconThemeData x4Large;

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

  IconThemeProperties copyWith({
    IconThemeData? x4Small,
    IconThemeData? x3Small,
    IconThemeData? x2Small,
    IconThemeData? xSmall,
    IconThemeData? small,
    IconThemeData? medium,
    IconThemeData? large,
    IconThemeData? xLarge,
    IconThemeData? x2Large,
    IconThemeData? x3Large,
    IconThemeData? x4Large,
  }) {
    return IconThemeProperties(
      x4Small: x4Small ?? this.x4Small,
      x3Small: x3Small ?? this.x3Small,
      x2Small: x2Small ?? this.x2Small,
      xSmall: xSmall ?? this.xSmall,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      xLarge: xLarge ?? this.xLarge,
      x2Large: x2Large ?? this.x2Large,
      x3Large: x3Large ?? this.x3Large,
      x4Large: x4Large ?? this.x4Large,
    );
  }

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
}

class ComponentTheme<T> extends InheritedTheme {
  final T data;

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

  static T of<T>(BuildContext context) {
    final data = maybeOf<T>(context);
    assert(data != null, 'No ComponentTheme<$T> found in context');
    return data!;
  }

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

enum ThemeMode {
  system,
  light,
  dark,
}
