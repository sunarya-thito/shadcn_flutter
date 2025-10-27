---
title: "Class: MaxValidator"
description: "Reference for MaxValidator"
---

```dart
class MaxValidator<T extends num> extends Validator<T> {
  final T max;
  final bool inclusive;
  final String? message;
  const MaxValidator(this.max, {this.inclusive = true, this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
