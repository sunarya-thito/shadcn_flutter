---
title: "Class: ObjectFormFieldDialogResult"
description: "Holds the result value from an object form field dialog."
---

```dart
/// Holds the result value from an object form field dialog.
///
/// Used to pass the selected or edited value back from a dialog prompt.
///
/// Example:
/// ```dart
/// final result = ObjectFormFieldDialogResult<DateTime>(DateTime.now());
/// Navigator.of(context).pop(result);
/// ```
class ObjectFormFieldDialogResult<T> {
  /// The value selected or edited by the user.
  final T? value;
  /// Creates an [ObjectFormFieldDialogResult].
  ///
  /// Parameters:
  /// - [value] (`T?`, required): The result value.
  ObjectFormFieldDialogResult(this.value);
}
```
