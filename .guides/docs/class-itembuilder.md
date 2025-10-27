---
title: "Class: ItemBuilder"
description: "Reference for ItemBuilder"
---

```dart
class ItemBuilder<T> extends ItemChildDelegate<T> {
  final int? itemCount;
  final T? Function(int index) itemBuilder;
  const ItemBuilder({this.itemCount, required this.itemBuilder});
  T? operator [](int index);
}
```
