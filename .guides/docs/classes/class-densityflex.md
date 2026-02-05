---
title: "Class: DensityFlex"
description: "A flex widget with density-aware spacing between children."
---

```dart
/// A flex widget with density-aware spacing between children.
///
/// Use instead of [Flex] when you want the spacing to adapt to density.
/// The [spacing] value is a multiplier applied to [Density.baseGap].
///
/// Example:
/// ```dart
/// DensityFlex(
///   direction: Axis.horizontal,
///   spacing: padSm,
///   children: [
///     Chip(label: Text('Tag 1')),
///     Chip(label: Text('Tag 2')),
///   ],
/// )
/// ```
class DensityFlex extends StatelessWidget {
  /// The direction to use as the main axis.
  final Axis direction;
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
  /// The clip behavior of the flex widget.
  final Clip clipBehavior;
  /// Creates a [DensityFlex].
  ///
  /// Parameters:
  /// - [direction] (`Axis`, required): The main axis direction.
  /// - [spacing] (`double`, default: 0): Gap multiplier between children.
  /// - [children] (`List<Widget>`, required): The flex's children.
  const DensityFlex({super.key, required this.direction, this.spacing = 0, required this.children, this.mainAxisAlignment = MainAxisAlignment.start, this.crossAxisAlignment = CrossAxisAlignment.center, this.mainAxisSize = MainAxisSize.max, this.textDirection, this.verticalDirection = VerticalDirection.down, this.textBaseline, this.clipBehavior = Clip.none});
  Widget build(BuildContext context);
}
```
