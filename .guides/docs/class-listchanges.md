---
title: "Class: ListChanges"
description: "Reference for ListChanges"
---

```dart
class ListChanges<T> {
  final List<ListChange<T>> changes;
  const ListChanges(this.changes);
  void apply(List<T> list);
}
```
