import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ThemeData {
  final ColorScheme colorScheme;
  final double radius;

  ThemeData({
    required this.colorScheme,
    required this.radius,
  });

  double get radiusXxl => radius * 24;
  double get radiusXl => radius * 20;
  double get radiusLg => radius * 16;
  double get radiusMd => radius * 12;
  double get radiusSm => radius * 8;
  double get radiusXs => radius * 4;

  Brightness get brightness => colorScheme.brightness;

  ThemeData copyWith({
    ColorScheme? colorScheme,
    double? radius,
  }) {
    return ThemeData(
      colorScheme: colorScheme ?? this.colorScheme,
      radius: radius ?? this.radius,
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
    if (theme == null) {
      throw Exception('No Theme found in context');
    }
    return theme.data;
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
