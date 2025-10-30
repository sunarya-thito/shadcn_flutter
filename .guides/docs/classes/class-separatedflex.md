---
title: "Class: SeparatedFlex"
description: "A flex widget that adds separators between children."
---

```dart
/// A flex widget that adds separators between children.
///
/// Used internally by [ColumnExtension] and [RowExtension] to insert
/// separators between flex children while maintaining flex properties.
class SeparatedFlex extends StatefulWidget {
  /// Main axis alignment for flex children.
  final MainAxisAlignment mainAxisAlignment;
  /// Main axis size constraint for the flex.
  final MainAxisSize mainAxisSize;
  /// Cross axis alignment for flex children.
  final CrossAxisAlignment crossAxisAlignment;
  /// Text direction for the flex.
  final TextDirection? textDirection;
  /// Vertical direction for laying out children.
  final VerticalDirection verticalDirection;
  /// Text baseline for aligning text children.
  final TextBaseline? textBaseline;
  /// Children widgets to display with separators.
  final List<Widget> children;
  /// Flex direction (horizontal or vertical).
  final Axis direction;
  /// Separator widget to insert between children.
  final Widget separator;
  /// Clipping behavior for the flex.
  final Clip clipBehavior;
  /// Creates a [SeparatedFlex].
  ///
  /// All flex-related parameters match [Flex] widget parameters.
  const SeparatedFlex({super.key, required this.mainAxisAlignment, required this.mainAxisSize, required this.crossAxisAlignment, this.textDirection, required this.verticalDirection, this.textBaseline, required this.children, required this.separator, required this.direction, this.clipBehavior = Clip.none});
  State<SeparatedFlex> createState();
}
```
