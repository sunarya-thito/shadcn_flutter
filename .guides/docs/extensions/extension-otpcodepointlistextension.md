---
title: "Extension: OTPCodepointListExtension"
description: "Extension methods for [OTPCodepointList]."
---

```dart
/// Extension methods for [OTPCodepointList].
extension OTPCodepointListExtension on OTPCodepointList {
  /// Converts the codepoint list to a string.
  ///
  /// Null values are converted to empty strings.
  ///
  /// Returns: A string representation of the OTP code.
  ///
  /// Example:
  /// ```dart
  /// final codes = [49, 50, 51]; // '1', '2', '3'
  /// print(codes.otpToString()); // '123'
  /// ```
  String otpToString();
}
```
