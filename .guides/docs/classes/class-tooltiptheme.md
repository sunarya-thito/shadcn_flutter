---
title: "Class: TooltipTheme"
description: "Theme data for customizing [TooltipContainer] widget appearance."
---

```dart
/// Theme data for customizing [TooltipContainer] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// tooltip containers, including surface effects, padding, colors,
/// and border styling. These properties can be set at the theme level
/// to provide consistent styling across the application.
class TooltipTheme {
  /// Opacity applied to the tooltip surface color.
  final double? surfaceOpacity;
  /// Blur amount for the tooltip surface.
  final double? surfaceBlur;
  /// Padding around the tooltip content.
  final EdgeInsetsGeometry? padding;
  /// Background color of the tooltip.
  final Color? backgroundColor;
  /// Border radius of the tooltip container.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [TooltipTheme].
  const TooltipTheme({this.surfaceOpacity, this.surfaceBlur, this.padding, this.backgroundColor, this.borderRadius});
  /// Creates a copy of this theme but with the given fields replaced.
  TooltipTheme copyWith({ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Color?>? backgroundColor, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
