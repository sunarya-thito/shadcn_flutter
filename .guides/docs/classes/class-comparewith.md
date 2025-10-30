---
title: "Class: CompareWith"
description: "A validator that compares a field's value with another form field's value."
---

```dart
/// A validator that compares a field's value with another form field's value.
///
/// [CompareWith] validates by comparing the current field's value against
/// another field identified by a [FormKey]. Supports various comparison types
/// including equality, greater than, less than, etc.
///
/// Example:
/// ```dart
/// CompareWith.greaterOrEqual(
///   FormKey<int>('minAge'),
///   message: 'Must be at least the minimum age',
/// )
/// ```
class CompareWith<T extends Comparable<T>> extends Validator<T> {
  /// The form field key to compare against.
  final FormKey<T> key;
  /// The type of comparison to perform.
  final CompareType type;
  /// Custom error message, or null to use default localized message.
  final String? message;
  /// Creates a [CompareWith] validator with the specified comparison type.
  const CompareWith(this.key, this.type, {this.message});
  /// Creates a validator that checks for equality with another field.
  const CompareWith.equal(this.key, {this.message});
  /// Creates a validator that checks if value is greater than another field.
  const CompareWith.greater(this.key, {this.message});
  /// Creates a validator that checks if value is greater than or equal to another field.
  const CompareWith.greaterOrEqual(this.key, {this.message});
  /// Creates a validator that checks if value is less than another field.
  const CompareWith.less(this.key, {this.message});
  /// Creates a validator that checks if value is less than or equal to another field.
  const CompareWith.lessOrEqual(this.key, {this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode state);
  bool shouldRevalidate(FormKey<dynamic> source);
  bool operator ==(Object other);
  int get hashCode;
}
```
