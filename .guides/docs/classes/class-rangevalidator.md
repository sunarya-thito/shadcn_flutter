---
title: "Class: RangeValidator"
description: "Reference for RangeValidator"
---

```dart
class RangeValidator<T extends num> extends Validator<T> {
  final T min;
  final T max;
  final bool inclusive;
  final String? message;
  const RangeValidator(this.min, this.max, {this.inclusive = true, this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool operator ==(Object other);
}
```
