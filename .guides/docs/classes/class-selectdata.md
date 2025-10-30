---
title: "Class: SelectData"
description: "Data class holding select dropdown state and configuration."
---

```dart
/// Data class holding select dropdown state and configuration.
///
/// Contains selection state, callbacks, and display options for select popups.
class SelectData {
  /// Whether to automatically close the popup after selection.
  final bool? autoClose;
  /// Predicate to check if a value is currently selected.
  final Predicate<Object?> isSelected;
  /// Callback invoked when selection changes.
  final SelectValueChanged<Object?> onChanged;
  /// Whether any items are currently selected.
  final bool hasSelection;
  /// Whether the select is enabled for interaction.
  final bool enabled;
  /// Creates select data.
  const SelectData({required this.autoClose, required this.isSelected, required this.onChanged, required this.hasSelection, required this.enabled});
  bool operator ==(Object other);
  int get hashCode;
}
```
