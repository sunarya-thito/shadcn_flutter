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
  /// Closes the popup, completing it with [value].
  ///
  /// Unlike [selectItem] this does not change the selection, so a widget
  /// inside the popup that is not an item — a "create new item" action, say —
  /// can run its own work and dismiss the popup on its own terms rather than
  /// waiting for `autoClose` to fire as a side effect of a selection:
  ///
  /// ```dart
  /// Button.ghost(
  ///   onPressed: () async {
  ///     final handle = SelectPopupHandle.of(context);
  ///     handle.close();
  ///     await createNewItem(context);
  ///   },
  ///   child: const Text('Create new'),
  /// )
  /// ```
  void close([Object? value]);
  /// Retrieves the nearest SelectPopupHandle from the widget tree.
  static SelectPopupHandle of(BuildContext context);
}
```
