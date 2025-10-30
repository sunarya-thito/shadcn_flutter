---
title: "Mixin: Choice"
description: "A mixin that provides choice selection functionality."
---

```dart
/// A mixin that provides choice selection functionality.
///
/// [Choice] defines the interface for widgets that support item selection,
/// typically used in multiple choice or single choice scenarios. It provides
/// static methods to interact with choice widgets in the widget tree.
mixin Choice<T> {
  /// Selects an item in the nearest [Choice] ancestor.
  ///
  /// Parameters:
  /// - [context]: The build context to search for Choice widget.
  /// - [item]: The item to select.
  static void choose<T>(BuildContext context, T item);
  /// Gets the current selected value(s) from the nearest [Choice] ancestor.
  ///
  /// Returns: The currently selected items, or null if none selected.
  static Iterable<T>? getValue<T>(BuildContext context);
  /// Selects the specified item.
  void selectItem(T item);
  /// Gets the currently selected items.
  Iterable<T>? get value;
}
```
