---
title: "Class: RenderGroup"
description: "Render object for [GroupWidget] that handles absolute positioning of children."
---

```dart
/// Render object for [GroupWidget] that handles absolute positioning of children.
///
/// Manages layout and painting of children positioned using [GroupParentData].
class RenderGroup extends RenderBox with ContainerRenderObjectMixin<RenderBox, GroupParentData>, RenderBoxContainerDefaultsMixin<RenderBox, GroupParentData> {
  /// Creates a [RenderGroup].
  ///
  /// Parameters:
  /// - [children] (`List<RenderBox>?`, optional): Initial list of child render objects.
  RenderGroup({List<RenderBox>? children});
  void setupParentData(RenderBox child);
  void performLayout();
  void paint(PaintingContext context, Offset offset);
  bool hitTest(BoxHitTestResult result, {required Offset position});
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
}
```
