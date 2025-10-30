---
title: "Class: MultipleChoiceController"
description: "A controller for managing [ControlledMultipleChoice] selection programmatically."
---

```dart
/// A controller for managing [ControlledMultipleChoice] selection programmatically.
///
/// This controller extends `ValueNotifier<T?>` to provide reactive state
/// management for single-choice components. It implements [ComponentController]
/// to integrate with the controlled component system, allowing external control
/// and listening to selection changes.
///
/// Example:
/// ```dart
/// final controller = MultipleChoiceController<String>('option1');
/// controller.addListener(() {
///   print('Selected item: ${controller.value}');
/// });
/// ```
class MultipleChoiceController<T> extends ValueNotifier<T?> with ComponentController<T?> {
  /// Creates a [MultipleChoiceController] with an optional initial selection.
  ///
  /// Parameters:
  /// - [value] (T?, optional): Initial selected item
  MultipleChoiceController([super.value]);
}
```
