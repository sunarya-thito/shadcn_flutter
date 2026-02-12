---
title: "Class: RenderStack"
description: "A patched version of [rendering.RenderStack] that supports custom paint ordering."
---

```dart
/// A patched version of [rendering.RenderStack] that supports custom paint ordering.
class RenderStack extends rendering.RenderStack with PaintOrderMixin {
  /// Creates a stack render object with paint order support.
  RenderStack({super.children, super.alignment, super.textDirection, super.fit, super.clipBehavior});
  rendering.RenderBox? get paintOrderFirstChild;
  void setupParentData(rendering.RenderBox child);
  void performLayout();
  void paintStack(rendering.PaintingContext context, Offset offset);
  bool hitTestChildren(rendering.BoxHitTestResult result, {required Offset position});
}
```
