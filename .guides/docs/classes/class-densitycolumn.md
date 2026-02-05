---
title: "Class: DensityColumn"
description: "A column widget with density-aware spacing between children."
---

```dart
/// A column widget with density-aware spacing between children.
///
/// Use instead of [Column] when you want the spacing to adapt to density.
/// The [spacing] value is a multiplier applied to [Density.baseGap].
///
/// Example:
/// ```dart
/// DensityColumn(
///   spacing: padMd,
///   children: [
///     Text('Title'),
///     Text('Subtitle'),
///   ],
/// )
/// ```
class DensityColumn extends StatelessWidget {
  /// The spacing multiplier between children.
  final double spacing;
  /// The children widgets.
  final List<Widget> children;
  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;
  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;
  /// How much space should be occupied in the main axis.
  final MainAxisSize mainAxisSize;
  /// The text direction to use for rendering.
  final TextDirection? textDirection;
  /// The vertical direction to use for layout.
  final VerticalDirection verticalDirection;
  /// The baseline to use for aligning children.
  final TextBaseline? textBaseline;
  /// Creates a [DensityColumn].
  ///
  /// Parameters:
  /// - [spacing] (`double`, default: 0): Gap multiplier between children.
  /// - [children] (`List<Widget>`, required): The column's children.
  const DensityColumn({super.key, this.spacing = 0, required this.children, this.mainAxisAlignment = MainAxisAlignment.start, this.crossAxisAlignment = CrossAxisAlignment.center, this.mainAxisSize = MainAxisSize.max, this.textDirection, this.verticalDirection = VerticalDirection.down, this.textBaseline});
  Widget build(BuildContext context);
}
```
