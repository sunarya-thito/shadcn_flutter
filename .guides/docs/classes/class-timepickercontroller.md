---
title: "Class: TimePickerController"
description: "A controller for managing [ControlledTimePicker] values programmatically."
---

```dart
/// A controller for managing [ControlledTimePicker] values programmatically.
///
/// This controller extends `ValueNotifier<TimeOfDay?>` to provide reactive
/// state management for time picker components. It implements [ComponentController]
/// to integrate with the controlled component system, allowing external control
/// and listening to time selection changes.
///
/// Example:
/// ```dart
/// final controller = TimePickerController(TimeOfDay(hour: 12, minute: 30));
/// controller.addListener(() {
///   print('Selected time: ${controller.value}');
/// });
/// ```
class TimePickerController extends ValueNotifier<TimeOfDay?> with ComponentController<TimeOfDay?> {
  /// Creates a [TimePickerController] with an optional initial value.
  ///
  /// Parameters:
  /// - [value] (TimeOfDay?, optional): Initial time value for the controller
  TimePickerController([super.value]);
}
```
