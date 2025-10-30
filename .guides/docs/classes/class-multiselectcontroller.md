---
title: "Class: MultiSelectController"
description: "Controller for managing [ControlledMultiSelect] state programmatically."
---

```dart
/// Controller for managing [ControlledMultiSelect] state programmatically.
///
/// Extends [SelectController] to provide reactive state management for multi-selection
/// components. Manages a collection of selected items with methods for adding,
/// removing, and bulk operations.
///
/// Example:
/// ```dart
/// final controller = MultiSelectController<String>(['apple', 'banana']);
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Selection changed to: ${controller.value}');
/// });
///
/// // Update selection
/// controller.value = ['apple', 'cherry'];
/// ```
class MultiSelectController<T> extends SelectController<Iterable<T>> {
  /// Creates a [MultiSelectController] with an optional initial selection.
  ///
  /// The [value] parameter sets the initial selected items collection.
  /// Can be null or empty to start with no selections.
  ///
  /// Parameters:
  /// - [value] (`Iterable<T>?`, optional): Initial selected items
  MultiSelectController([super.value]);
}
```
