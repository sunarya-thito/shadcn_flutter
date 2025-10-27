---
title: "Class: ListInsertChange"
description: "Reference for ListInsertChange"
---

```dart
class ListInsertChange<T> extends ListChange<T> {
  final int index;
  final T item;
  const ListInsertChange(this.index, this.item);
  void apply(List<T> list);
}
```
