---
title: "Class: LengthValidator"
description: "Reference for LengthValidator"
---

```dart
class LengthValidator extends Validator<String> {
  final int? min;
  final int? max;
  final String? message;
  const LengthValidator({this.min, this.max, this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
