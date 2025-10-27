---
title: "Class: ItemList"
description: "Reference for ItemList"
---

```dart
class ItemList<T> extends ItemChildDelegate<T> {
  final List<T> items;
  const ItemList(this.items);
  int get itemCount;
  T operator [](int index);
}
```
