---
title: "Class: FormValueState"
description: "Holds the current value and validator for a form field."
---

```dart
/// Holds the current value and validator for a form field.
///
/// Immutable snapshot of a form field's state used internally by form controllers
/// to track field values and their associated validation rules.
class FormValueState<T> {
  /// The current field value.
  final T? value;
  /// The validator function for this field.
  final Validator<T>? validator;
  /// Creates a [FormValueState].
  ///
  /// Parameters:
  /// - [value] (`T?`, optional): Current field value.
  /// - [validator] (`Validator<T>?`, optional): Validation function.
  FormValueState({this.value, this.validator});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
