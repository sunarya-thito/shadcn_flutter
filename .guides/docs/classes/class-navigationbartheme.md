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
  /// Background color of the navigation bar.
  final Color? backgroundColor;
  /// Alignment of navigation items.
  final NavigationBarAlignment? alignment;
  /// Layout direction (horizontal or vertical).
  final Axis? direction;
  /// Spacing between navigation items.
  final double? spacing;
  /// Type of label display (e.g., always show, hide, etc.).
  final NavigationLabelType? labelType;
  /// Position of labels relative to icons.
  final NavigationLabelPosition? labelPosition;
  /// Size variant for labels.
  final NavigationLabelSize? labelSize;
  /// Internal padding of the navigation bar.
  final EdgeInsetsGeometry? padding;
  /// Creates a [NavigationBarTheme].
  ///
  /// Parameters:
  /// - [backgroundColor] (`Color?`, optional): Background color.
  /// - [alignment] (`NavigationBarAlignment?`, optional): Item alignment.
  /// - [direction] (`Axis?`, optional): Layout direction.
  /// - [spacing] (`double?`, optional): Item spacing.
  /// - [labelType] (`NavigationLabelType?`, optional): Label display type.
  /// - [labelPosition] (`NavigationLabelPosition?`, optional): Label position.
  /// - [labelSize] (`NavigationLabelSize?`, optional): Label size.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Internal padding.
  const NavigationBarTheme({this.backgroundColor, this.alignment, this.direction, this.spacing, this.labelType, this.labelPosition, this.labelSize, this.padding});
  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [backgroundColor] (`ValueGetter<Color?>?`, optional): New background color.
  /// - [alignment] (`ValueGetter<NavigationBarAlignment?>?`, optional): New alignment.
  /// - [direction] (`ValueGetter<Axis?>?`, optional): New direction.
  /// - [spacing] (`ValueGetter<double?>?`, optional): New spacing.
  /// - [labelType] (`ValueGetter<NavigationLabelType?>?`, optional): New label type.
  /// - [labelPosition] (`ValueGetter<NavigationLabelPosition?>?`, optional): New label position.
  /// - [labelSize] (`ValueGetter<NavigationLabelSize?>?`, optional): New label size.
  /// - [padding] (`ValueGetter<EdgeInsetsGeometry?>?`, optional): New padding.
  ///
  /// Returns: A new [NavigationBarTheme] with updated properties.
  NavigationBarTheme copyWith({ValueGetter<Color?>? backgroundColor, ValueGetter<NavigationBarAlignment?>? alignment, ValueGetter<Axis?>? direction, ValueGetter<double?>? spacing, ValueGetter<NavigationLabelType?>? labelType, ValueGetter<NavigationLabelPosition?>? labelPosition, ValueGetter<NavigationLabelSize?>? labelSize, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
