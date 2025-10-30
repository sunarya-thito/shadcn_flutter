---
title: "Class: FormattedValuePart"
description: "Represents a part of a formatted value with its associated input part and value."
---

```dart
/// Represents a part of a formatted value with its associated input part and value.
///
/// A [FormattedValuePart] pairs an [InputPart] definition with an optional
/// string value, used to represent user input or parsed data within a
/// formatted input field.
///
/// Example:
/// ```dart
/// final part = FormattedValuePart(DigitPart(), '5');
/// final updated = part.withValue('7');
/// ```
class FormattedValuePart {
  /// The input part definition that this value belongs to.
  final InputPart part;
  /// The actual string value for this part, or null if not set.
  final String? value;
  /// Creates a [FormattedValuePart].
  ///
  /// Parameters:
  /// - [part] (`InputPart`, required): The input part definition.
  /// - [value] (`String?`, optional): The value for this part.
  const FormattedValuePart(this.part, [this.value]);
  /// Creates a copy of this part with a new value.
  ///
  /// Parameters:
  /// - [value] (`String`, required): The new value to associate with this part.
  ///
  /// Returns: A new [FormattedValuePart] with the updated value.
  ///
  /// Example:
  /// ```dart
  /// final original = FormattedValuePart(DigitPart(), '1');
  /// final updated = original.withValue('2');
  /// ```
  FormattedValuePart withValue(String value);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
