---
title: "Class: GroupPositioned"
description: "Positions a child widget within a [GroupWidget]."
---

```dart
/// Positions a child widget within a [GroupWidget].
///
/// Controls the position and optionally the size of a child using absolute
/// coordinates. At least one positioning parameter should be provided.
///
/// Example:
/// ```dart
/// GroupPositioned(
///   top: 20,
///   left: 20,
///   width: 100,
///   height: 50,
///   child: Container(color: Colors.blue),
/// )
/// ```
class GroupPositioned extends ParentDataWidget<GroupParentData> {
  /// Creates a [GroupPositioned].
  ///
  /// Parameters:
  /// - [top] (`double?`, optional): Distance from top edge.
  /// - [left] (`double?`, optional): Distance from left edge.
  /// - [right] (`double?`, optional): Distance from right edge.
  /// - [bottom] (`double?`, optional): Distance from bottom edge.
  /// - [width] (`double?`, optional): Explicit width.
  /// - [height] (`double?`, optional): Explicit height.
  /// - [child] (`Widget`, required): The child to position.
  const GroupPositioned({super.key, this.top, this.left, this.right, this.bottom, this.width, this.height, required super.child});
  /// Creates a [GroupPositioned] that fills the entire group bounds.
  ///
  /// Sets all edges to 0, making the child fill the available space.
  const GroupPositioned.fill({super.key, this.top = 0, this.left = 0, this.right = 0, this.bottom = 0, this.width, this.height, required super.child});
  /// Creates a [GroupPositioned] from a [Rect].
  ///
  /// Positions and sizes the child according to the given rectangle.
  GroupPositioned.fromRect({super.key, required Rect rect, required super.child});
  /// Distance from the top edge of the group.
  final double? top;
  /// Distance from the left edge of the group.
  final double? left;
  /// Distance from the right edge of the group.
  final double? right;
  /// Distance from the bottom edge of the group.
  final double? bottom;
  /// Explicit width of the child.
  final double? width;
  /// Explicit height of the child.
  final double? height;
  void applyParentData(RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
}
```
