---
title: "Class: RenderGroup"
description: "Reference for RenderGroup"
---

```dart
class RenderGroup extends RenderBox with ContainerRenderObjectMixin<RenderBox, GroupParentData>, RenderBoxContainerDefaultsMixin<RenderBox, GroupParentData> {
  RenderGroup({List<RenderBox>? children});
  void setupParentData(RenderBox child);
  void performLayout();
  void paint(PaintingContext context, Offset offset);
  bool hitTest(BoxHitTestResult result, {required Offset position});
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
}
```
