---
title: "Class: NotEmptyValidator"
description: "Reference for NotEmptyValidator"
---

```dart
class NotEmptyValidator extends NonNullValidator<String> {
  const NotEmptyValidator({super.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
