---
title: "Class: GridItemPickerLayout"
description: "A grid-based layout for item pickers."
---

```dart
/// A grid-based layout for item pickers.
///
/// Displays items in a scrollable grid using [GridView.builder]. The number
/// of columns can be configured via [crossAxisCount].
///
/// Example:
/// ```dart
/// GridItemPickerLayout(crossAxisCount: 3)
/// ```
class GridItemPickerLayout extends ItemPickerLayout {
  /// Number of columns in the grid.
  final int crossAxisCount;
  /// Creates a [GridItemPickerLayout].
  ///
  /// Parameters:
  /// - [crossAxisCount] (`int`, default: `4`): The number of grid columns.
  const GridItemPickerLayout({this.crossAxisCount = 4});
  /// Creates a copy of this layout with a different column count.
  ///
  /// Parameters:
  /// - [crossAxisCount] (`int`, default: `4`): The new column count.
  ///
  /// Returns: A new [GridItemPickerLayout] with the specified columns.
  ItemPickerLayout call({int crossAxisCount = 4});
  Widget build(BuildContext context, ItemChildDelegate items, ItemPickerBuilder builder);
}
```
