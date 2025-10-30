---
title: "Class: NotValidator"
description: "A validator that negates the result of another validator."
---

```dart
/// A validator that negates the result of another validator.
///
/// [NotValidator] inverts the validation logic - it passes when the wrapped
/// validator fails and fails when the wrapped validator passes. Useful for
/// creating exclusion rules.
///
/// Example:
/// ```dart
/// NotValidator(
///   EmailValidator(),
///   message: 'Must not be an email address',
/// )
/// ```
class NotValidator<T> extends Validator<T> {
  /// The validator whose result will be negated.
  final Validator<T> validator;
  /// Custom error message, or null to use default localized message.
  final String? message;
  /// Creates a [NotValidator] that negates the result of another validator.
  const NotValidator(this.validator, {this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  void operator ==(Object other);
  int get hashCode;
}
```
