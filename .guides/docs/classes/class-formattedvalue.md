---
title: "Class: FormattedValue"
description: "Represents a complete formatted value composed of multiple parts."
---

```dart
/// Represents a complete formatted value composed of multiple parts.
///
/// A [FormattedValue] holds a list of [FormattedValuePart] instances, where
/// each part represents either static text or editable fields. It provides
/// methods to access value parts (excluding static parts) and retrieve
/// individual parts by index.
///
/// Example:
/// ```dart
/// final value = FormattedValue([
///   FormattedValuePart(DigitPart(), '1'),
///   FormattedValuePart(StaticPart('/'), null),
///   FormattedValuePart(DigitPart(), '2'),
/// ]);
/// print(value.values.length); // 2 (only value parts)
/// ```
class FormattedValue {
  /// The list of parts that make up this formatted value.
  final List<FormattedValuePart> parts;
  /// Creates a [FormattedValue].
  ///
  /// Parameters:
  /// - [parts] (`List<FormattedValuePart>`, default: `const []`): The parts
  ///   composing this value.
  const FormattedValue([this.parts = const []]);
  /// Returns an iterable of only the parts that can hold values.
  ///
  /// This excludes static parts like separators or fixed text.
  Iterable<FormattedValuePart> get values;
  /// Retrieves the value part at the specified index.
  ///
  /// This indexes only the parts that can hold values (excluding static parts).
  ///
  /// Parameters:
  /// - [index] (`int`, required): The zero-based index into value parts.
  ///
  /// Returns: The [FormattedValuePart] at the index, or null if out of bounds.
  ///
  /// Example:
  /// ```dart
  /// final value = FormattedValue([
  ///   FormattedValuePart(DigitPart(), '1'),
  ///   FormattedValuePart(StaticPart('/'), null),
  ///   FormattedValuePart(DigitPart(), '2'),
  /// ]);
  /// print(value[0]?.value); // '1'
  /// print(value[1]?.value); // '2'
  /// ```
  FormattedValuePart? operator [](int index);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
