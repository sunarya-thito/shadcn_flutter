---
title: "Class: ListSwapChange"
description: "Reference for ListSwapChange"
---

```dart
class ListSwapChange<T> extends ListChange<T> {
  final int from;
  final int to;
  const ListSwapChange(this.from, this.to);
  void apply(List<T> list);
}
```
