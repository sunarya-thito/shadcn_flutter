---
title: "Class: NonNullValidator"
description: "Reference for NonNullValidator"
---

```dart
class NonNullValidator<T> extends Validator<T> {
  final String? message;
  const NonNullValidator({this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
