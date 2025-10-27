---
title: "Class: OrValidator"
description: "Reference for OrValidator"
---

```dart
class OrValidator<T> extends Validator<T> {
  final List<Validator<T>> validators;
  const OrValidator(this.validators);
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  Validator<T> operator |(Validator<T> other);
  bool shouldRevalidate(FormKey<dynamic> source);
  void operator ==(Object other);
  int get hashCode;
}
```
