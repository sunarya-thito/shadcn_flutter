---
title: "Class: FormattedInputController"
description: "A controller for managing [FormattedInput] values programmatically."
---

```dart
/// A controller for managing [FormattedInput] values programmatically.
///
/// This controller extends `ValueNotifier<FormattedValue>` to provide reactive
/// state management for formatted input components. It implements [ComponentController]
/// to integrate with the controlled component system, allowing external control
/// and listening to formatted input changes.
///
/// Example:
/// ```dart
/// final controller = FormattedInputController(
///   FormattedValue([
///     FormattedValuePart.static('('),
///     FormattedValuePart.editable('', length: 3),
///     FormattedValuePart.static(') '),
///     FormattedValuePart.editable('', length: 3),
///     FormattedValuePart.static('-'),
///     FormattedValuePart.editable('', length: 4),
///   ])
/// );
/// ```
class FormattedInputController extends ValueNotifier<FormattedValue> with ComponentController<FormattedValue> {
  /// Creates a [FormattedInputController] with an optional initial value.
  ///
  /// Parameters:
  /// - [value] (FormattedValue, default: empty): Initial formatted value
  FormattedInputController([super.value = const FormattedValue()]);
}
```
