---
title: "Class: OTPSeparator"
description: "A visual separator for OTP input groups."
---

```dart
/// A visual separator for OTP input groups.
///
/// Displays a dash "-" character between groups of OTP input fields.
/// Automatically applies theming and spacing based on the current theme.
///
/// Example:
/// ```dart
/// InputOTP(
///   children: [
///     InputOTPChild.input(),
///     OTPSeparator(),
///     InputOTPChild.input(),
///   ],
/// )
/// ```
class OTPSeparator extends StatelessWidget {
  /// Creates an [OTPSeparator].
  const OTPSeparator({super.key});
  Widget build(BuildContext context);
}
```
