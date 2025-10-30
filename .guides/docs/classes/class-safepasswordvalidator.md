---
title: "Class: SafePasswordValidator"
description: "A validator for ensuring password strength and security requirements."
---

```dart
/// A validator for ensuring password strength and security requirements.
///
/// [SafePasswordValidator] checks passwords against common security criteria:
/// digits, lowercase letters, uppercase letters, and special characters.
/// Each requirement can be individually enabled or disabled.
///
/// Example:
/// ```dart
/// SafePasswordValidator(
///   requireDigit: true,
///   requireLowercase: true,
///   requireUppercase: true,
///   requireSpecialChar: true,
///   message: 'Password must meet security requirements',
/// )
/// ```
class SafePasswordValidator extends Validator<String> {
  /// Custom error message, or null to use default localized messages.
  final String? message;
  /// Whether password must contain at least one digit.
  final bool requireDigit;
  /// Whether password must contain at least one lowercase letter.
  final bool requireLowercase;
  /// Whether password must contain at least one uppercase letter.
  final bool requireUppercase;
  /// Whether password must contain at least one special character.
  final bool requireSpecialChar;
  /// Creates a [SafePasswordValidator] with configurable requirements.
  const SafePasswordValidator({this.requireDigit = true, this.requireLowercase = true, this.requireUppercase = true, this.requireSpecialChar = true, this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
