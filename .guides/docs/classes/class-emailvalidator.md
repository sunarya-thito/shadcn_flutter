---
title: "Class: EmailValidator"
description: "A validator that checks if a string is a valid email address."
---

```dart
/// A validator that checks if a string is a valid email address.
///
/// [EmailValidator] uses the email_validator package to validate email
/// addresses according to standard email format rules.
///
/// Example:
/// ```dart
/// EmailValidator(
///   message: 'Please enter a valid email address',
/// )
/// ```
class EmailValidator extends Validator<String> {
  /// Custom error message, or null to use default localized message.
  final String? message;
  /// Creates an [EmailValidator] with an optional custom message.
  const EmailValidator({this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
