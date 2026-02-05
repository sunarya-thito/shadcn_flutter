---
title: "Class: Stack"
description: "A widget that positions its children relative to the edges of its box."
---

```dart
/// A widget that positions its children relative to the edges of its box.
///
/// This class is useful if you want to overlap several children in a simple
/// way, for example having some text and an image, overlaid with a gradient
/// and a button attached to the bottom.
///
/// Each child of a [Stack] widget is either _positioned_ or _non-positioned_.
/// Positioned children are those wrapped in a [Positioned] widget that has at
/// least one non-null property. The stack sizes itself to contain all the
/// non-positioned children, which are positioned according to [alignment]
/// (which defaults to the top-left corner in left-to-right environments and
/// the top-right corner in right-to-left environments). The positioned
/// children are then placed relative to the stack according to their top,
/// right, bottom, and left properties.
///
/// This patched version supports custom paint ordering via [Positioned.paintOrder].
///
/// See also:
///
///  * [Positioned], for positioning children within this stack.
///  * [Align], which sizes itself based on its child's size and positions
///    the child according to an [Alignment] value.
class Stack extends widgets.Stack {
  /// Creates a stack with paint order support.
  const Stack({super.key, super.alignment, super.textDirection, super.fit, super.clipBehavior, super.children});
  RenderStack createRenderObject(widgets.BuildContext context);
  void updateRenderObject(widgets.BuildContext context, covariant RenderStack renderObject);
}
```
