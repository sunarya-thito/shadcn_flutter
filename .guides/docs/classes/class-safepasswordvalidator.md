---
title: "Class: SafePasswordValidator"
description: "Reference for SafePasswordValidator"
---

```dart
class SafePasswordValidator extends Validator<String> {
  final String? message;
  final bool requireDigit;
  final bool requireLowercase;
  final bool requireUppercase;
  final bool requireSpecialChar;
  const SafePasswordValidator({this.requireDigit = true, this.requireLowercase = true, this.requireUppercase = true, this.requireSpecialChar = true, this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
