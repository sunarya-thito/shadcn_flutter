---
title: "Class: ListRemoveChange"
description: "Reference for ListRemoveChange"
---

```dart
class ListRemoveChange<T> extends ListChange<T> {
  final int index;
  const ListRemoveChange(this.index);
  void apply(List<T> list);
}
```
