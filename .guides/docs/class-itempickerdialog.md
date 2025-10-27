---
title: "Class: ItemPickerDialog"
description: "Reference for ItemPickerDialog"
---

```dart
class ItemPickerDialog<T> extends StatefulWidget {
  final ItemChildDelegate<T> items;
  final ItemPickerBuilder<T> builder;
  final ItemPickerLayout layout;
  final T? value;
  final ValueChanged<T?>? onChanged;
  const ItemPickerDialog({super.key, required this.items, required this.builder, this.value, this.onChanged, this.layout = const GridItemPickerLayout()});
  State<ItemPickerDialog<T>> createState();
}
```
