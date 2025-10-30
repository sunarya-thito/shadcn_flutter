---
title: "Class: NonNullValidator"
description: "A validator that ensures a value is not null."
---

```dart
/// A validator that ensures a value is not null.
///
/// [NonNullValidator] is a simple validator that fails if the value is null.
/// Commonly used to mark fields as required.
///
/// Example:
/// ```dart
/// NonNullValidator<String>(
///   message: 'This field is required',
/// )
/// ```
class NonNullValidator<T> extends Validator<T> {
  /// Custom error message, or null to use default localized message.
  final String? message;
  /// Creates a [NonNullValidator] with an optional custom message.
  const NonNullValidator({this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
