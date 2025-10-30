---
title: "Class: RegexValidator"
description: "A validator that checks if a string matches a regular expression pattern."
---

```dart
/// A validator that checks if a string matches a regular expression pattern.
///
/// [RegexValidator] provides flexible pattern-based validation using regular
/// expressions. Useful for validating formats like phone numbers, postal codes, etc.
///
/// Example:
/// ```dart
/// RegexValidator(
///   RegExp(r'^\d{3}-\d{3}-\d{4}$'),
///   message: 'Must be in format: XXX-XXX-XXXX',
/// )
/// ```
class RegexValidator extends Validator<String> {
  /// The regular expression pattern to match against.
  final RegExp pattern;
  /// Custom error message, or null to use default localized message.
  final String? message;
  /// Creates a [RegexValidator] with the specified pattern.
  const RegexValidator(this.pattern, {this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
