---
title: "Class: ItemPickerData"
description: "Data provided by [ItemPickerDialog] to its descendants."
---

```dart
/// Data provided by [ItemPickerDialog] to its descendants.
///
/// Contains the current selection value, change callback, and layout strategy.
/// Used internally for coordinating state across the item picker tree.
class ItemPickerData {
  /// The currently selected value.
  final Object? value;
  /// Callback invoked when the selection changes.
  final ValueChanged<Object?>? onChanged;
  /// The layout strategy being used.
  final ItemPickerLayout layout;
  /// Creates an [ItemPickerData].
  ///
  /// Parameters:
  /// - [value] (`Object?`, optional): Current selection.
  /// - [onChanged] (`ValueChanged<Object?>?`, optional): Change callback.
  /// - [layout] (`ItemPickerLayout`, required): Layout strategy.
  const ItemPickerData({this.value, this.onChanged, required this.layout});
  bool operator ==(Object other);
  int get hashCode;
}
```
