---
title: "Class: ValidationResult"
description: "Reference for ValidationResult"
---

```dart
abstract class ValidationResult {
  final FormValidationMode state;
  const ValidationResult({required this.state});
  FormKey get key;
  ValidationResult attach(FormKey key);
}
```
