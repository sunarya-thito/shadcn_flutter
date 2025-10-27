---
title: "Class: NavigationBarTheme"
description: "Theme data for customizing [NavigationBar] widget appearance."
---

```dart
/// Theme data for customizing [NavigationBar] widget appearance.
///
/// This class defines the visual and behavioral properties that can be applied to
/// [NavigationBar] widgets, including background colors, alignment, spacing,
/// label presentation, and padding. These properties can be set at the theme level
/// to provide consistent styling across the application.
class NavigationBarTheme {
  final Color? backgroundColor;
  final NavigationBarAlignment? alignment;
  final Axis? direction;
  final double? spacing;
  final NavigationLabelType? labelType;
  final NavigationLabelPosition? labelPosition;
  final NavigationLabelSize? labelSize;
  final EdgeInsetsGeometry? padding;
  const NavigationBarTheme({this.backgroundColor, this.alignment, this.direction, this.spacing, this.labelType, this.labelPosition, this.labelSize, this.padding});
  NavigationBarTheme copyWith({ValueGetter<Color?>? backgroundColor, ValueGetter<NavigationBarAlignment?>? alignment, ValueGetter<Axis?>? direction, ValueGetter<double?>? spacing, ValueGetter<NavigationLabelType?>? labelType, ValueGetter<NavigationLabelPosition?>? labelPosition, ValueGetter<NavigationLabelSize?>? labelSize, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
