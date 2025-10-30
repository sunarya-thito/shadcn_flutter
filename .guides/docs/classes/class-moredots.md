---
title: "Class: MoreDots"
description: "A widget that displays multiple dots, commonly used for loading indicators or menus."
---

```dart
/// A widget that displays multiple dots, commonly used for loading indicators or menus.
///
/// Creates a customizable row or column of circular dots that can be used as a
/// "more" indicator, loading animation, or menu icon. The number, size, color,
/// and spacing of dots can be configured.
///
/// Example:
/// ```dart
/// // Horizontal three-dot menu icon
/// MoreDots(
///   count: 3,
///   direction: Axis.horizontal,
///   spacing: 4,
/// )
///
/// // Vertical loading indicator
/// MoreDots(
///   count: 5,
///   direction: Axis.vertical,
///   color: Colors.blue,
/// )
/// ```
class MoreDots extends StatelessWidget {
  /// The layout direction of the dots.
  ///
  /// Can be [Axis.horizontal] for a row or [Axis.vertical] for a column.
  /// Defaults to horizontal.
  final Axis direction;
  /// The number of dots to display.
  ///
  /// Defaults to `3`.
  final int count;
  /// The size (diameter) of each dot.
  ///
  /// If `null`, calculates size based on the text style font size (20% of font size).
  final double? size;
  /// The color of the dots.
  ///
  /// If `null`, uses the current text color from the theme.
  final Color? color;
  /// The spacing between dots.
  ///
  /// Defaults to `2`.
  final double spacing;
  /// Padding around the entire dots group.
  ///
  /// If `null`, no padding is applied.
  final EdgeInsetsGeometry? padding;
  /// Creates a [MoreDots].
  ///
  /// Parameters:
  /// - [direction] (`Axis`, default: `Axis.horizontal`): Layout direction.
  /// - [count] (`int`, default: `3`): Number of dots.
  /// - [size] (`double?`, optional): Dot diameter.
  /// - [color] (`Color?`, optional): Dot color.
  /// - [spacing] (`double`, default: `2`): Space between dots.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Outer padding.
  const MoreDots({super.key, this.direction = Axis.horizontal, this.count = 3, this.size, this.color, this.spacing = 2, this.padding});
  Widget build(BuildContext context);
}
```
