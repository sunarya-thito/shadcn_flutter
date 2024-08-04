import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AdaptiveScaling {
  final double radiusScaling;
  final double sizeScaling;
  final double textScaling;

  // factory AdaptiveScaling({
  //   double scaling = 1,
  // }) {
  //   return AdaptiveScaling.only(
  //     radiusScaling: scaling,
  //     densityScaling: scaling,
  //     textScaling: scaling,
  //   );
  // }

  const AdaptiveScaling({
    double scaling = 1,
  }) : this.only(
          radiusScaling: scaling,
          sizeScaling: scaling,
          textScaling: scaling,
        );

  const AdaptiveScaling.only({
    this.radiusScaling = 1,
    this.sizeScaling = 1,
    this.textScaling = 1,
  });
}

typedef AdaptiveScalingBuilder = AdaptiveScaling Function(BuildContext context);

class AdaptiveScaler extends StatelessWidget {
  static AdaptiveScaling defaultScaling(BuildContext context) {
    final theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.android:
        return const AdaptiveScaling.only(
            radiusScaling: 1.25, sizeScaling: 1.25, textScaling: 1.25);
      default:
        return const AdaptiveScaling.only();
    }
  }

  final AdaptiveScalingBuilder builder;
  final Widget child;
  final ThemeData? theme;

  const AdaptiveScaler({
    Key? key,
    required this.builder,
    required this.child,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaling = builder(context);
    final theme = this.theme ?? Theme.of(context);
    var textScaling = scaling.textScaling;
    return Theme(
      data: theme.copyWith(
        radius: scaling.radiusScaling == 1
            ? null
            : theme.radius * scaling.radiusScaling,
        scaling: scaling.sizeScaling == 1
            ? null
            : theme.scaling * scaling.sizeScaling,
        iconTheme: scaling.textScaling == 1
            ? null
            : theme.iconTheme.scale(textScaling),
        typography: scaling.textScaling == 1
            ? null
            : theme.typography.scale(textScaling),
      ),
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

  ThemeData({
    required this.colorScheme,
    required this.radius,
    this.scaling = 1,
    this.typography = const Typography.geist(),
    this.iconTheme = const IconThemeProperties(),
    TargetPlatform? platform,
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
  }) {
    return ThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      radius: radius ?? this.radius,
      typography: typography ?? this.typography,
      platform: platform ?? _platform,
      scaling: scaling ?? this.scaling,
      iconTheme: iconTheme ?? this.iconTheme,
    );
  }
}

class Theme extends InheritedTheme {
  final ThemeData data;

  const Theme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

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

class IconThemeProperties {
  final IconThemeData xSmall;
  final IconThemeData small;
  final IconThemeData medium;
  final IconThemeData large;
  final IconThemeData xLarge;

  const IconThemeProperties({
    this.xSmall = const IconThemeData(size: 12),
    this.small = const IconThemeData(size: 16),
    this.medium = const IconThemeData(size: 20),
    this.large = const IconThemeData(size: 24),
    this.xLarge = const IconThemeData(size: 32),
  });

  IconThemeProperties copyWith({
    IconThemeData? xSmall,
    IconThemeData? small,
    IconThemeData? medium,
    IconThemeData? large,
    IconThemeData? xLarge,
  }) {
    return IconThemeProperties(
      xSmall: xSmall ?? this.xSmall,
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      xLarge: xLarge ?? this.xLarge,
    );
  }

  IconThemeProperties scale(double factor) {
    return IconThemeProperties(
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
    );
  }
}

class ComponentTheme<T> extends InheritedTheme {
  final T data;

  const ComponentTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

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
    assert(data != null, 'No Data<$T> found in context');
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
