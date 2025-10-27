---
title: "Class: RawSortableStack"
description: "RawSortableStack prevents the stacking children from going outside the bounds of this widget."
---

```dart
/// RawSortableStack prevents the stacking children from going outside the bounds of this widget.
/// It will clamp the position of the children to the bounds of this widget.
class RawSortableStack extends MultiChildRenderObjectWidget {
  const RawSortableStack({super.key, required super.children});
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderRawSortableStack renderObject);
}
```
