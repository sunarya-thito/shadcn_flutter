---
title: "Class: MinValidator"
description: "A validator that checks if a numeric value meets a minimum threshold."
---

```dart
/// A validator that checks if a numeric value meets a minimum threshold.
///
/// [MinValidator] ensures that numeric values are greater than (or equal to)
/// a specified minimum value. Useful for enforcing minimum quantities, ages, etc.
///
/// Example:
/// ```dart
/// MinValidator<int>(
///   18,
///   inclusive: true,
///   message: 'Must be at least 18 years old',
/// )
/// ```
class MinValidator<T extends num> extends Validator<T> {
  /// The minimum acceptable value.
  final T min;
  /// Whether the minimum value itself is acceptable (true) or must be exceeded (false).
  final bool inclusive;
  /// Custom error message, or null to use default localized message.
  final String? message;
  /// Creates a [MinValidator] with the specified minimum value.
  const MinValidator(this.min, {this.inclusive = true, this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
