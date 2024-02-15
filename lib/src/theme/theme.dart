import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ThemeData {
  final Brightness brightness;
  final ColorScheme colorScheme;
  final double radius;

  ThemeData({
    required this.brightness,
    required this.colorScheme,
    required this.radius,
  });

  double get radiusXxl => radius * 24;
  double get radiusXl => radius * 20;
  double get radiusLg => radius * 16;
  double get radiusMd => radius * 12;
  double get radiusSm => radius * 8;
  double get radiusXs => radius * 4;

  ThemeData copyWith({
    Brightness? brightness,
    ColorScheme? colorScheme,
    double? radius,
  }) {
    return ThemeData(
      brightness: brightness ?? this.brightness,
      colorScheme: colorScheme ?? this.colorScheme,
      radius: radius ?? this.radius,
    );
  }
}

class Theme extends InheritedWidget {
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
}
