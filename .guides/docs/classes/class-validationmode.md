---
title: "Class: ValidationMode"
description: "Reference for ValidationMode"
---

```dart
class ValidationMode<T> extends Validator<T> {
  final Validator<T> validator;
  final Set<FormValidationMode> mode;
  const ValidationMode(this.validator, {this.mode = const {FormValidationMode.changed, FormValidationMode.submitted, FormValidationMode.initial}});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  void operator ==(Object other);
  int get hashCode;
}
```
