---
title: "Class: Flex"
description: "A widget that displays its children in a one-dimensional array."
---

```dart
/// A widget that displays its children in a one-dimensional array.
///
/// The [Flex] widget allows you to control the axis along which the children are
/// placed (horizontal or vertical). This is referred to as the _main axis_. If
/// you know the main axis in advance, then consider using a [Row] (if it's
/// horizontal) or [Column] (if it's vertical) instead, because that will be less
/// verbose.
///
/// To cause a child to expand to fill the available space in the [direction]
/// of this widget's main axis, wrap the child in an [Expanded] widget.
///
/// The [Flex] widget does not scroll (and in general it is considered an error
/// to have more children in a [Flex] than will fit in the available room). If
/// you have some widgets and want them to be able to scroll if there is
/// insufficient room, consider using a [ListView].
///
/// This patched version supports custom paint ordering via [PaintOrder] or
/// [Flexible.paintOrder].
///
/// See also:
///
///  * [Row], for a horizontal arrangement of children.
///  * [Column], for a vertical arrangement of children.
///  * [Expanded], to indicate children that should take all remaining room.
///  * [Flexible], to indicate children that should share remaining room.
///  * [PaintOrder], to control the paint order of children.
class Flex extends widgets.Flex {
  /// Creates a flex layout with paint order support.
  const Flex({super.key, required super.direction, super.mainAxisAlignment, super.mainAxisSize, super.crossAxisAlignment, super.textDirection, super.verticalDirection, super.textBaseline, super.clipBehavior, super.spacing, super.children});
  RenderFlex createRenderObject(widgets.BuildContext context);
  void updateRenderObject(widgets.BuildContext context, covariant RenderFlex renderObject);
}
```
