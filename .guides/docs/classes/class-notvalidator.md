---
title: "Class: NotValidator"
description: "Reference for NotValidator"
---

```dart
class NotValidator<T> extends Validator<T> {
  final Validator<T> validator;
  final String? message;
  const NotValidator(this.validator, {this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  void operator ==(Object other);
  int get hashCode;
}
```
