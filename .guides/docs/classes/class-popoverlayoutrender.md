---
title: "Class: PopoverLayoutRender"
description: "Reference for PopoverLayoutRender"
---

```dart
class PopoverLayoutRender extends RenderShiftedBox {
  PopoverLayoutRender({RenderBox? child, required Alignment alignment, required Offset? position, required Alignment anchorAlignment, required PopoverConstraint widthConstraint, required PopoverConstraint heightConstraint, Size? anchorSize, Offset? offset, EdgeInsets margin = const EdgeInsets.all(8), required double scale, required Alignment scaleAlignment, FilterQuality? filterQuality, bool allowInvertHorizontal = true, bool allowInvertVertical = true});
  Size computeDryLayout(covariant BoxConstraints constraints);
  bool hitTest(BoxHitTestResult result, {required Offset position});
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
  void applyPaintTransform(RenderBox child, Matrix4 transform);
  bool get alwaysNeedsCompositing;
  void paint(PaintingContext context, Offset offset);
  BoxConstraints getConstraintsForChild(BoxConstraints constraints);
  void performLayout();
}
```
