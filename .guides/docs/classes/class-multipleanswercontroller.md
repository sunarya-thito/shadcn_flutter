---
title: "Class: MultipleAnswerController"
description: "A controller for managing [ControlledMultipleAnswer] selections programmatically."
---

```dart
/// A controller for managing [ControlledMultipleAnswer] selections programmatically.
///
/// This controller extends `ValueNotifier<Iterable<T>?>` to provide reactive
/// state management for multiple selection components. It implements [ComponentController]
/// to integrate with the controlled component system, allowing external control
/// and listening to selection changes.
///
/// Example:
/// ```dart
/// final controller = MultipleAnswerController<String>(['option1', 'option2']);
/// controller.addListener(() {
///   print('Selected items: ${controller.value}');
/// });
/// ```
class MultipleAnswerController<T> extends ValueNotifier<Iterable<T>?> with ComponentController<Iterable<T>?> {
  /// Creates a [MultipleAnswerController] with an optional initial selection.
  ///
  /// Parameters:
  /// - [value] (`Iterable<T>?`, optional): Initial selection of items
  MultipleAnswerController([super.value]);
}
```
