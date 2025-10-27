---
title: "Class: RenderRawSortableStack"
description: "Reference for RenderRawSortableStack"
---

```dart
class RenderRawSortableStack extends RenderBox with ContainerRenderObjectMixin<RenderBox, RawSortableParentData>, RenderBoxContainerDefaultsMixin<RenderBox, RawSortableParentData> {
  bool enabled;
  void setupParentData(RenderBox child);
  void performLayout();
  void paint(PaintingContext context, Offset offset);
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
}
```
