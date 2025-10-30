---
title: "Class: DurationPickerController"
description: "Controller for managing [DurationPicker] values programmatically."
---

```dart
/// Controller for managing [DurationPicker] values programmatically.
///
/// Extends `ValueNotifier<Duration?>` to provide reactive state management
/// for duration picker components. Integrates with the controlled component
/// system for external control and change notifications.
///
/// Example:
/// ```dart
/// final controller = DurationPickerController(Duration(hours: 2, minutes: 30));
/// controller.addListener(() {
///   print('Selected duration: ${controller.value}');
/// });
/// ```
class DurationPickerController extends ValueNotifier<Duration?> with ComponentController<Duration?> {
  /// Creates a [DurationPickerController] with an initial value.
  DurationPickerController(super.value);
}
```
