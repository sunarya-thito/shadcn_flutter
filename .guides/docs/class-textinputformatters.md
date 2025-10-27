---
title: "Class: TextInputFormatters"
description: "Reference for TextInputFormatters"
---

```dart
class TextInputFormatters {
  static const TextInputFormatter toUpperCase = _ToUpperCaseTextFormatter();
  static const TextInputFormatter toLowerCase = _ToLowerCaseTextFormatter();
  static TextInputFormatter time({required int length});
  static TextInputFormatter integerOnly({int? min, int? max});
  static TextInputFormatter digitsOnly({double? min, double? max, int? decimalDigits});
  static TextInputFormatter mathExpression({Map<String, dynamic>? context});
}
```
