---
title: "Class: WidgetInputOTPChild"
description: "A widget-based OTP child that doesn't accept input."
---

```dart
/// A widget-based OTP child that doesn't accept input.
///
/// Used for displaying static content like separators or spacers within
/// an [InputOTP] widget. This child does not hold any value.
///
/// Example:
/// ```dart
/// WidgetInputOTPChild(
///   Icon(Icons.arrow_forward),
/// )
/// ```
class WidgetInputOTPChild extends InputOTPChild {
  /// The widget to display.
  final Widget child;
  /// Creates a [WidgetInputOTPChild].
  ///
  /// Parameters:
  /// - [child] (`Widget`, required): The widget to display.
  const WidgetInputOTPChild(this.child);
  Widget build(BuildContext context, InputOTPChildData data);
  bool get hasValue;
}
```
