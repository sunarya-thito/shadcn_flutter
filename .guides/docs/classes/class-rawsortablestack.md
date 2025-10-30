---
title: "Class: RawSortableStack"
description: "RawSortableStack prevents the stacking children from going outside the bounds of this widget."
---

```dart
/// RawSortableStack prevents the stacking children from going outside the bounds of this widget.
/// A raw sortable stack widget for managing layered sortable items.
///
/// Provides basic stacking functionality for sortable components without
/// additional layout or styling. Clamps child positions to widget bounds.
class RawSortableStack extends MultiChildRenderObjectWidget {
  /// Creates a raw sortable stack.
  const RawSortableStack({super.key, required super.children});
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderRawSortableStack renderObject);
}
```
