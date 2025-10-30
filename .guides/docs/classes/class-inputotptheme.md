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
  /// Horizontal spacing between OTP input fields.
  final double? spacing;
  /// Height of each OTP input container.
  final double? height;
  /// Creates an [InputOTPTheme].
  ///
  /// Parameters:
  /// - [spacing] (`double?`, optional): Space between input fields.
  /// - [height] (`double?`, optional): Height of input containers.
  const InputOTPTheme({this.spacing, this.height});
  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Parameters:
  /// - [spacing] (`ValueGetter<double?>?`, optional): New spacing value.
  /// - [height] (`ValueGetter<double?>?`, optional): New height value.
  ///
  /// Returns: A new [InputOTPTheme] with updated properties.
  InputOTPTheme copyWith({ValueGetter<double?>? spacing, ValueGetter<double?>? height});
  bool operator ==(Object other);
  int get hashCode;
}
```
