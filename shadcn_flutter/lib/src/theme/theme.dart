import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ThemeData {
  final ColorScheme colorScheme;
  final Typography typography;
  final double radius;
  final TargetPlatform? _platform;

  ThemeData({
    required this.colorScheme,
    required this.radius,
    this.typography = const Typography.geist(),
    TargetPlatform? platform,
  }) : _platform = platform;

  TargetPlatform get platform => _platform ?? defaultTargetPlatform;

  double get radiusXxl => radius * 24;
  double get radiusXl => radius * 20;
  double get radiusLg => radius * 16;
  double get radiusMd => radius * 12;
  double get radiusSm => radius * 8;
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
  }) {
    return ThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      radius: radius ?? this.radius,
      typography: typography ?? this.typography,
      platform: platform ?? _platform,
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
