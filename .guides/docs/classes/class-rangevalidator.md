---
title: "Class: RangeValidator"
description: "A validator that checks if a numeric value falls within a specified range."
---

```dart
/// A validator that checks if a numeric value falls within a specified range.
///
/// [RangeValidator] ensures values are between minimum and maximum bounds.
/// Both bounds can be inclusive or exclusive depending on configuration.
///
/// Example:
/// ```dart
/// RangeValidator<double>(
///   0.0,
///   100.0,
///   inclusive: true,
///   message: 'Must be between 0 and 100',
/// )
/// ```
class RangeValidator<T extends num> extends Validator<T> {
  /// The minimum acceptable value.
  final T min;
  /// The maximum acceptable value.
  final T max;
  /// Whether the bounds are inclusive (true) or exclusive (false).
  final bool inclusive;
  /// Custom error message, or null to use default localized message.
  final String? message;
  /// Creates a [RangeValidator] with the specified min and max bounds.
  const RangeValidator(this.min, this.max, {this.inclusive = true, this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
