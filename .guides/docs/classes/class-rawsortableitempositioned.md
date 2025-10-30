---
title: "Class: RawSortableItemPositioned"
description: "Widget that positions a sortable item at a specific offset."
---

```dart
/// Widget that positions a sortable item at a specific offset.
///
/// Used internally by sortable lists to position items during drag
/// operations. Wraps a child widget and updates its parent data with
/// the specified [offset].
class RawSortableItemPositioned extends ParentDataWidget<RawSortableParentData> {
  /// The offset where the item should be positioned.
  final Offset offset;
  /// Creates a [RawSortableItemPositioned].
  ///
  /// Parameters:
  /// - [offset] (`Offset`, required): Position offset for the child.
  /// - [child] (`Widget`, required): The child widget to position.
  const RawSortableItemPositioned({super.key, required this.offset, required super.child});
  void applyParentData(RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
}
```
