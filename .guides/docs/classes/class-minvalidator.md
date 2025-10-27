---
title: "Class: MinValidator"
description: "Reference for MinValidator"
---

```dart
class MinValidator<T extends num> extends Validator<T> {
  final T min;
  final bool inclusive;
  final String? message;
  const MinValidator(this.min, {this.inclusive = true, this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
