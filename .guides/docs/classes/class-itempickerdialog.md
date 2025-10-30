---
title: "Class: ItemPickerDialog"
description: "A dialog widget for picking an item from a list or grid."
---

```dart
/// A dialog widget for picking an item from a list or grid.
///
/// Internally used by [showItemPicker] and [showItemPickerDialog] to display
/// items and handle selection. Manages the selected value state and notifies
/// listeners when the selection changes.
///
/// Example:
/// ```dart
/// ItemPickerDialog<Color>(
///   items: ItemList([Colors.red, Colors.green]),
///   builder: (context, color) => ColorTile(color),
///   layout: ItemPickerLayout.grid,
///   onChanged: (color) => print(color),
/// )
/// ```
class ItemPickerDialog<T> extends StatefulWidget {
  /// Delegate providing the items to display.
  final ItemChildDelegate<T> items;
  /// Builder function for rendering each item.
  final ItemPickerBuilder<T> builder;
  /// Layout strategy for displaying items.
  final ItemPickerLayout layout;
  /// Currently selected value.
  final T? value;
  /// Called when the selection changes.
  final ValueChanged<T?>? onChanged;
  /// Creates an [ItemPickerDialog].
  ///
  /// Parameters:
  /// - [items] (`ItemChildDelegate<T>`, required): Items to display.
  /// - [builder] (`ItemPickerBuilder<T>`, required): Item widget builder.
  /// - [layout] (`ItemPickerLayout`, default: `GridItemPickerLayout()`): Layout strategy.
  /// - [value] (`T?`, optional): Selected value.
  /// - [onChanged] (`ValueChanged<T?>?`, optional): Selection callback.
  const ItemPickerDialog({super.key, required this.items, required this.builder, this.value, this.onChanged, this.layout = const GridItemPickerLayout()});
  State<ItemPickerDialog<T>> createState();
}
```
