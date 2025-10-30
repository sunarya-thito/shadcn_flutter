---
title: "Class: RenderRawSortableStack"
description: "Render object for managing sortable item stacking and positioning."
---

```dart
/// Render object for managing sortable item stacking and positioning.
///
/// Handles layout, painting, and hit testing for sortable items arranged
/// in a stack. Clamps child positions to widget bounds to prevent items
/// from escaping during drag operations.
class RenderRawSortableStack extends RenderBox with ContainerRenderObjectMixin<RenderBox, RawSortableParentData>, RenderBoxContainerDefaultsMixin<RenderBox, RawSortableParentData> {
  /// Whether drag-and-drop interactions are enabled.
  bool enabled;
  void setupParentData(RenderBox child);
  void performLayout();
  void paint(PaintingContext context, Offset offset);
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
}
```
