---
title: "Class: ListInsertChange"
description: "A list change that inserts an item."
---

```dart
/// A list change that inserts an item.
///
/// Inserts [item] at the specified [index] in the list.
class ListInsertChange<T> extends ListChange<T> {
  /// The index where the item will be inserted.
  final int index;
  /// The item to insert.
  final T item;
  /// Creates a [ListInsertChange] that inserts [item] at [index].
  const ListInsertChange(this.index, this.item);
  void apply(List<T> list);
}
```
