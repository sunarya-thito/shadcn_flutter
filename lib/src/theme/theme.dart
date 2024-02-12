import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ThemeData {
  final ColorScheme colorScheme;
  final double radius;
  final Typography typography;

  ThemeData({
    required this.colorScheme,
    required this.radius,
    required this.typography,
  });

  double get radiusXl => radius * 20;
  double get radiusLg => radius * 16;
  double get radiusMd => radius * 12;
  double get radiusSm => radius * 8;
  double get radiusXs => radius * 4;
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
