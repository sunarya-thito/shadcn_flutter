---
title: "Class: PhoneNumberValid"
description: "[Validator] for validating a [PhoneNumber] input value.   Provides customizable error messages for invalid and empty phone numbers, and can be used with the form validation system to ensure that user input meets the required phone number format and completeness criteria."
---

```dart
/// [Validator] for validating a [PhoneNumber] input value.
///
/// Provides customizable error messages for invalid and empty phone numbers, and can be used with the form validation system to ensure that user input meets the required phone number format and completeness criteria.
class PhoneNumberValid extends Validator<PhoneNumber> {
  /// Custom error message for invalid phone numbers.
  final String? invalidMessage;
  /// Custom error message for empty phone number input.
  final String? emptyMessage;
  /// Creates a [PhoneNumberValid] validator with optional custom error messages.
  const PhoneNumberValid({this.invalidMessage, this.emptyMessage});
  FutureOr<ValidationResult?> validate(BuildContext context, PhoneNumber? value, FormValidationMode lifecycle);
  bool operator ==(Object other);
  int get hashCode;
}
```
