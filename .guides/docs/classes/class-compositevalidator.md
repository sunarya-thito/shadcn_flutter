---
title: "Class: CompositeValidator"
description: "Reference for CompositeValidator"
---

```dart
class CompositeValidator<T> extends Validator<T> {
  final List<Validator<T>> validators;
  const CompositeValidator(this.validators);
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  Validator<T> combine(Validator<T> other);
  bool shouldRevalidate(FormKey<dynamic> source);
  bool operator ==(Object other);
  int get hashCode;
}
```
