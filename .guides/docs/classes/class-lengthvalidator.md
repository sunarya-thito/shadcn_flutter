---
title: "Class: LengthValidator"
description: "A validator that checks if a string's length is within specified bounds."
---

```dart
/// A validator that checks if a string's length is within specified bounds.
///
/// [LengthValidator] validates that a string's length falls within the minimum
/// and/or maximum bounds. Either bound can be null to check only one direction.
///
/// Example:
/// ```dart
/// LengthValidator(
///   min: 3,
///   max: 20,
///   message: 'Must be between 3 and 20 characters',
/// )
/// ```
class LengthValidator extends Validator<String> {
  /// Minimum length requirement (inclusive), or null for no minimum.
  final int? min;
  /// Maximum length requirement (inclusive), or null for no maximum.
  final int? max;
  /// Custom error message, or null to use default localized message.
  final String? message;
  /// Creates a [LengthValidator] with optional min/max bounds.
  const LengthValidator({this.min, this.max, this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
