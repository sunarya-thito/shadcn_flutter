---
title: "Class: DatePickerController"
description: "A controller for managing the selected date in a [DatePicker]."
---

```dart
/// A controller for managing the selected date in a [DatePicker].
///
/// [DatePickerController] extends [ValueNotifier] to hold the currently selected
/// date and notify listeners when it changes. Use this to programmatically control
/// the date picker or react to date selection changes.
///
/// Example:
/// ```dart
/// final controller = DatePickerController(DateTime.now());
/// controller.addListener(() {
///   print('Selected date: ${controller.value}');
/// });
/// ```
class DatePickerController extends ValueNotifier<DateTime?> with ComponentController<DateTime?> {
  /// Creates a [DatePickerController] with the specified initial date.
  DatePickerController(super.value);
}
```
