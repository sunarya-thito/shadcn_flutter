---
title: "Mixin: PaintOrderParentDataMixin"
description: "Mixin for parent data that supports paint ordering."
---

```dart
/// Mixin for parent data that supports paint ordering.
mixin PaintOrderParentDataMixin on rendering.ContainerBoxParentData<rendering.RenderBox> {
  /// The paint order of this child. Higher values are painted on top.
  /// If null, uses the default order (0).
  int? paintOrder;
  /// Next sibling in the sorted paint order linked list.
  rendering.RenderBox? nextSortedSibling;
  /// Previous sibling in the sorted paint order linked list.
  rendering.RenderBox? previousSortedSibling;
  /// Internal index used for sorting.
  int paintIndex;
}
```
