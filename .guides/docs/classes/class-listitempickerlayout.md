---
title: "Class: ListItemPickerLayout"
description: "A list-based layout for item pickers."
---

```dart
/// A list-based layout for item pickers.
///
/// Displays items in a vertical scrolling list using [ListView.builder].
///
/// Example:
/// ```dart
/// const ListItemPickerLayout()
/// ```
class ListItemPickerLayout extends ItemPickerLayout {
  /// Creates a [ListItemPickerLayout].
  const ListItemPickerLayout();
  Widget build(BuildContext context, ItemChildDelegate items, ItemPickerBuilder builder);
}
```
