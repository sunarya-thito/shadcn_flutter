---
title: "Class: CompareTo"
description: "A validator that compares a value against a static comparison value."
---

```dart
/// A validator that compares a value against a static comparison value.
///
/// [CompareTo] validates by comparing the field value against a fixed value
/// (unlike [CompareWith] which compares against another field). Supports
/// various comparison types.
///
/// Example:
/// ```dart
/// CompareTo.greaterOrEqual(
///   18,
///   message: 'Must be at least 18',
/// )
/// ```
class CompareTo<T extends Comparable<T>> extends Validator<T> {
  /// The value to compare against.
  final T? value;
  /// The type of comparison to perform.
  final CompareType type;
  /// Custom error message, or null to use default localized message.
  final String? message;
  /// Creates a [CompareTo] validator with the specified comparison type.
  const CompareTo(this.value, this.type, {this.message});
  /// Creates a validator that checks for equality with a value.
  const CompareTo.equal(this.value, {this.message});
  /// Creates a validator that checks if field value is greater than the specified value.
  const CompareTo.greater(this.value, {this.message});
  /// Creates a validator that checks if field value is greater than or equal to the specified value.
  const CompareTo.greaterOrEqual(this.value, {this.message});
  /// Creates a validator that checks if field value is less than the specified value.
  const CompareTo.less(this.value, {this.message});
  /// Creates a validator that checks if field value is less than or equal to the specified value.
  const CompareTo.lessOrEqual(this.value, {this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
