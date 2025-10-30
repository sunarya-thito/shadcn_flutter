---
title: "Class: RawSortableParentData"
description: "Parent data for sortable items within a [RawSortableStack]."
---

```dart
/// Parent data for sortable items within a [RawSortableStack].
///
/// Extends [ContainerBoxParentData] to include positioning information
/// for items in a sortable layout.
class RawSortableParentData extends ContainerBoxParentData<RenderBox> {
  /// The current position offset of this sortable item.
  Offset? position;
}
```
