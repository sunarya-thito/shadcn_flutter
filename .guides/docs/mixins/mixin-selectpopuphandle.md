---
title: "Mixin: SelectPopupHandle"
description: "Mixin providing select popup interaction methods."
---

```dart
/// Mixin providing select popup interaction methods.
///
/// Allows widgets to check selection state and update selections.
mixin SelectPopupHandle {
  /// Checks if the given value is currently selected.
  bool isSelected(Object? value);
  /// Updates the selection state for the given value.
  void selectItem(Object? value, bool selected);
  /// Whether any items are currently selected.
  bool get hasSelection;
  /// Retrieves the nearest SelectPopupHandle from the widget tree.
  static SelectPopupHandle of(BuildContext context);
}
```
