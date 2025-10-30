---
title: "Class: PhoneNumber"
description: "Represents a phone number with country code information."
---

```dart
/// Represents a phone number with country code information.
///
/// [PhoneNumber] combines a country (with dial code) and a phone number
/// string to create a complete international phone number.
///
/// Example:
/// ```dart
/// final phone = PhoneNumber(
///   Country(dialCode: '+1', code: 'US'),
///   '5551234567',
/// );
/// print(phone.fullNumber); // +15551234567
/// ```
class PhoneNumber {
  /// The country associated with this phone number.
  final Country country;
  /// The phone number without the country code.
  final String number;
  /// Creates a [PhoneNumber] with the specified country and number.
  const PhoneNumber(this.country, this.number);
  /// Gets the complete phone number including country code.
  String get fullNumber;
  /// Gets the full number or null if the number is empty.
  String? get value;
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
