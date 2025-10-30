---
title: "Class: SelectController"
description: "Controller for managing [ControlledSelect] state programmatically."
---

```dart
/// Controller for managing [ControlledSelect] state programmatically.
///
/// Extends [ValueNotifier] to provide reactive state management for select
/// components. Can be used to programmatically change selection, listen to
/// state changes, and integrate with forms and other reactive systems.
///
/// Example:
/// ```dart
/// final controller = SelectController<String>('initial');
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Selection changed to: ${controller.value}');
/// });
///
/// // Update selection
/// controller.value = 'new_value';
/// ```
class SelectController<T> extends ValueNotifier<T?> with ComponentController<T?> {
  /// Creates a [SelectController] with an optional initial value.
  ///
  /// The [value] parameter sets the initial selected item. Can be null
  /// to start with no selection.
  ///
  /// Parameters:
  /// - [value] (T?, optional): Initial selected value
  SelectController([super.value]);
}
```
