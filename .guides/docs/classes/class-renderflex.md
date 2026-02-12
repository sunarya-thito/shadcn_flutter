---
title: "Class: RenderFlex"
description: "A patched version of [rendering.RenderFlex] that supports custom paint ordering."
---

```dart
/// A patched version of [rendering.RenderFlex] that supports custom paint ordering.
class RenderFlex extends rendering.RenderFlex with PaintOrderMixin {
  /// Creates a flex render object with paint order support.
  RenderFlex({super.children, super.direction, super.mainAxisSize, super.mainAxisAlignment, super.crossAxisAlignment, super.textDirection, super.verticalDirection, super.textBaseline, super.clipBehavior, super.spacing});
  rendering.RenderBox? get paintOrderFirstChild;
  void setupParentData(rendering.RenderBox child);
  void performLayout();
  void paint(rendering.PaintingContext context, Offset offset);
  bool hitTestChildren(rendering.BoxHitTestResult result, {required Offset position});
}
```
