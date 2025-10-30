---
title: "Class: ListRemoveChange"
description: "A list change that removes an item."
---

```dart
/// A list change that removes an item.
///
/// Removes the item at the specified [index] from the list.
class ListRemoveChange<T> extends ListChange<T> {
  /// The index of the item to remove.
  final int index;
  /// Creates a [ListRemoveChange] that removes the item at [index].
  const ListRemoveChange(this.index);
  void apply(List<T> list);
}
```
