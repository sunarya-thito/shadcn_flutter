---
title: "Class: ButtonStyleOverrideData"
description: "Data class holding button style override delegates."
---

```dart
/// Data class holding button style override delegates.
///
/// [ButtonStyleOverrideData] is used internally by [ButtonStyleOverride] to pass
/// style override delegates through the widget tree via the [Data] inherited widget
/// system. It stores optional delegates for each button style property.
///
/// This class is typically not used directly by application code; instead, use
/// [ButtonStyleOverride] widget to apply style overrides.
class ButtonStyleOverrideData {
  /// Optional decoration override delegate.
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  /// Optional mouse cursor override delegate.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  /// Optional padding override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  /// Optional text style override delegate.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  /// Optional icon theme override delegate.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  /// Optional margin override delegate.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;
  /// Creates button style override data with the specified delegates.
  const ButtonStyleOverrideData({this.decoration, this.mouseCursor, this.padding, this.textStyle, this.iconTheme, this.margin});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
