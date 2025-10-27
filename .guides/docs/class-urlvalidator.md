---
title: "Class: URLValidator"
description: "Reference for URLValidator"
---

```dart
class URLValidator extends Validator<String> {
  final String? message;
  const URLValidator({this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
