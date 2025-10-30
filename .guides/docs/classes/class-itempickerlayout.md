---
title: "Class: ItemPickerLayout"
description: "Abstract base class for item picker layout strategies."
---

```dart
/// Abstract base class for item picker layout strategies.
///
/// Defines how items are displayed in an item picker, such as in a list
/// or grid. Provides factory constants for common layouts.
///
/// See also:
/// - [ListItemPickerLayout], which displays items in a vertical list.
/// - [GridItemPickerLayout], which displays items in a grid.
abstract class ItemPickerLayout {
  /// A list layout for item pickers.
  static const ListItemPickerLayout list = ListItemPickerLayout();
  /// A grid layout for item pickers (4 columns by default).
  static const GridItemPickerLayout grid = GridItemPickerLayout();
  /// Creates an [ItemPickerLayout].
  const ItemPickerLayout();
  /// Builds the widget for displaying items.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): The build context.
  /// - [items] (`ItemChildDelegate`, required): Delegate providing items.
  /// - [builder] (`ItemPickerBuilder`, required): Function to build each item.
  ///
  /// Returns: A widget displaying the items in this layout.
  Widget build(BuildContext context, ItemChildDelegate items, ItemPickerBuilder builder);
}
```
