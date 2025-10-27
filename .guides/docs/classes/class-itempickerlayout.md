---
title: "Class: ItemPickerLayout"
description: "Reference for ItemPickerLayout"
---

```dart
abstract class ItemPickerLayout {
  static const ListItemPickerLayout list = ListItemPickerLayout();
  static const GridItemPickerLayout grid = GridItemPickerLayout();
  const ItemPickerLayout();
  Widget build(BuildContext context, ItemChildDelegate items, ItemPickerBuilder builder);
}
```
