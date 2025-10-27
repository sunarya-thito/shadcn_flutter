---
title: "Class: RegexValidator"
description: "Reference for RegexValidator"
---

```dart
class RegexValidator extends Validator<String> {
  final RegExp pattern;
  final String? message;
  const RegexValidator(this.pattern, {this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
