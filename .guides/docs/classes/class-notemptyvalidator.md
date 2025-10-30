---
title: "Class: NotEmptyValidator"
description: "A validator that ensures a string is not null or empty."
---

```dart
/// A validator that ensures a string is not null or empty.
///
/// [NotEmptyValidator] extends [NonNullValidator] to also check for empty strings.
/// Commonly used for text field validation.
///
/// Example:
/// ```dart
/// NotEmptyValidator(
///   message: 'Please enter a value',
/// )
/// ```
class NotEmptyValidator extends NonNullValidator<String> {
  /// Creates a [NotEmptyValidator] with an optional custom message.
  const NotEmptyValidator({super.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
