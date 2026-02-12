---
title: "Class: Positioned"
description: "A widget that controls where a child of a [Stack] is positioned.   A [Positioned] widget must be a descendant of a [Stack], and the path from  the [Positioned] widget to its enclosing [Stack] must contain only  [StatelessWidget]s or [StatefulWidget]s (not other kinds of widgets, like  [RenderObjectWidget]s).   If a widget is wrapped in a [Positioned], then it is a _positioned_ widget  in its [Stack]. If the [top] property is non-null, the top edge of this child  will be positioned [top] layout units from the top of the stack widget. The  [right], [bottom], and [left] properties work analogously.   If both the [top] and [bottom] properties are non-null, then the child will  be forced to have exactly the height required to satisfy both constraints.  Similarly, setting the [right] and [left] properties to non-null values will  force the child to have a particular width.   This patched version also supports [paintOrder] to control the painting  order of children.   See also:    * [Stack], which uses positioned children."
---

```dart
/// A widget that controls where a child of a [Stack] is positioned.
///
/// A [Positioned] widget must be a descendant of a [Stack], and the path from
/// the [Positioned] widget to its enclosing [Stack] must contain only
/// [StatelessWidget]s or [StatefulWidget]s (not other kinds of widgets, like
/// [RenderObjectWidget]s).
///
/// If a widget is wrapped in a [Positioned], then it is a _positioned_ widget
/// in its [Stack]. If the [top] property is non-null, the top edge of this child
/// will be positioned [top] layout units from the top of the stack widget. The
/// [right], [bottom], and [left] properties work analogously.
///
/// If both the [top] and [bottom] properties are non-null, then the child will
/// be forced to have exactly the height required to satisfy both constraints.
/// Similarly, setting the [right] and [left] properties to non-null values will
/// force the child to have a particular width.
///
/// This patched version also supports [paintOrder] to control the painting
/// order of children.
///
/// See also:
///
///  * [Stack], which uses positioned children.
class Positioned extends widgets.ParentDataWidget<StackParentData> {
  /// Creates a positioned widget with paint order support.
  const Positioned({super.key, this.left, this.top, this.right, this.bottom, this.width, this.height, this.paintOrder, required super.child});
  /// Creates a Positioned with all edges set to 0.0 unless specified.
  const Positioned.fill({super.key, this.left = 0.0, this.top = 0.0, this.right = 0.0, this.bottom = 0.0, this.paintOrder, required super.child});
  /// The distance that the child's left edge is inset from the left of the stack.
  final double? left;
  /// The distance that the child's top edge is inset from the top of the stack.
  final double? top;
  /// The distance that the child's right edge is inset from the right of the stack.
  final double? right;
  /// The distance that the child's bottom edge is inset from the bottom of the stack.
  final double? bottom;
  /// The child's width.
  final double? width;
  /// The child's height.
  final double? height;
  /// The paint order of this child. Higher values are painted on top.
  final int? paintOrder;
  void applyParentData(rendering.RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
  void debugFillProperties(foundation.DiagnosticPropertiesBuilder properties);
}
```
