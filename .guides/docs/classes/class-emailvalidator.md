---
title: "Class: EmailValidator"
description: "Reference for EmailValidator"
---

```dart
class EmailValidator extends Validator<String> {
  final String? message;
  const EmailValidator({this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
