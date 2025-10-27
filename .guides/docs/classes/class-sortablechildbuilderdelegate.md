---
title: "Class: SortableChildBuilderDelegate"
description: "Reference for SortableChildBuilderDelegate"
---

```dart
class SortableChildBuilderDelegate<T> extends SortableListDelegate<T> {
  final int? itemCount;
  final SortableItemBuilder<T> builder;
  const SortableChildBuilderDelegate({this.itemCount, required this.builder});
  T getItem(BuildContext context, int index);
}
```
