---
title: "Class: InputOTPTheme"
description: "Theme data for customizing [InputOTP] widget appearance."
---

```dart
/// Theme data for customizing [InputOTP] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [InputOTP] widgets, including spacing between OTP input fields
/// and the height of the input containers. These properties can be
/// set at the theme level to provide consistent styling across the application.
class InputOTPTheme {
  final double? spacing;
  final double? height;
  const InputOTPTheme({this.spacing, this.height});
  InputOTPTheme copyWith({ValueGetter<double?>? spacing, ValueGetter<double?>? height});
  bool operator ==(Object other);
  int get hashCode;
}
```
