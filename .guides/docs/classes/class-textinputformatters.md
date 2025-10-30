---
title: "Class: TextInputFormatters"
description: "Provides factory methods for common text input formatters."
---

```dart
/// Provides factory methods for common text input formatters.
///
/// [TextInputFormatters] is a utility class that creates various pre-configured
/// [TextInputFormatter] instances for common formatting needs like uppercase/lowercase
/// conversion, numeric input, time formatting, and more.
///
/// Example:
/// ```dart
/// TextField(
///   inputFormatters: [
///     TextInputFormatters.toUpperCase,
///     TextInputFormatters.integerOnly(min: 0, max: 100),
///   ],
/// )
/// ```
class TextInputFormatters {
  /// Converts all input text to uppercase.
  static const TextInputFormatter toUpperCase = _ToUpperCaseTextFormatter();
  /// Converts all input text to lowercase.
  static const TextInputFormatter toLowerCase = _ToLowerCaseTextFormatter();
  /// Creates a formatter for time input with leading zeros.
  ///
  /// Parameters:
  /// - [length]: The fixed length of the time string.
  static TextInputFormatter time({required int length});
  /// Creates a formatter that only allows integer input with optional min/max bounds.
  ///
  /// Parameters:
  /// - [min]: Optional minimum value.
  /// - [max]: Optional maximum value.
  static TextInputFormatter integerOnly({int? min, int? max});
  /// Creates a formatter that only allows decimal numeric input.
  ///
  /// Parameters:
  /// - [min]: Optional minimum value.
  /// - [max]: Optional maximum value.
  /// - [decimalDigits]: Optional fixed number of decimal places.
  static TextInputFormatter digitsOnly({double? min, double? max, int? decimalDigits});
  /// Creates a formatter that evaluates mathematical expressions.
  ///
  /// Parameters:
  /// - [context]: Optional context variables for expression evaluation.
  static TextInputFormatter mathExpression({Map<String, dynamic>? context});
  /// Creates a formatter for hexadecimal input.
  ///
  /// Parameters:
  /// - [hashPrefix]: Whether to require/add a '#' prefix.
  static TextInputFormatter hex({bool hashPrefix = false});
}
```
