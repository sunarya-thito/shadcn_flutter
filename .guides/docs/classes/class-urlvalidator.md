---
title: "Class: URLValidator"
description: "A validator that checks if a string is a valid URL."
---

```dart
/// A validator that checks if a string is a valid URL.
///
/// [URLValidator] validates URLs using Dart's Uri parsing capabilities
/// to ensure the string represents a valid web address.
///
/// Example:
/// ```dart
/// URLValidator(
///   message: 'Please enter a valid URL',
/// )
/// ```
class URLValidator extends Validator<String> {
  /// Custom error message, or null to use default localized message.
  final String? message;
  /// Creates a [URLValidator] with an optional custom message.
  const URLValidator({this.message});
  FutureOr<ValidationResult?> validate(BuildContext context, String? value, FormValidationMode state);
  bool operator ==(Object other);
  int get hashCode;
}
```
