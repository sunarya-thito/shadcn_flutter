---
title: "Class: SortableChildListDelegate"
description: "Reference for SortableChildListDelegate"
---

```dart
class SortableChildListDelegate<T> extends SortableListDelegate<T> {
  final List<T> items;
  final SortableWidgetBuilder<T> builder;
  const SortableChildListDelegate(this.items, this.builder);
  int get itemCount;
  T getItem(BuildContext context, int index);
}
```
