---
title: "Class: ButtonTheme"
description: "Abstract base class for button theme customization."
---

```dart
/// Abstract base class for button theme customization.
///
/// [ButtonTheme] provides optional style property delegates that can override
/// or modify the default button styling. Subclasses implement specific button
/// variants (primary, secondary, outline, etc.) allowing theme-level customization
/// of button appearances throughout an application.
///
/// Each property is a [ButtonStatePropertyDelegate] that receives the context,
/// current states, and the default value, allowing for context-aware and
/// state-dependent style modifications.
///
/// Implementations include [PrimaryButtonTheme], [SecondaryButtonTheme],
/// [OutlineButtonTheme], and others for each button variant.
abstract class ButtonTheme {
  /// Optional decoration override (background, border, shadows).
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  /// Optional mouse cursor override.
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  /// Optional padding override.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  /// Optional text style override.
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  /// Optional icon theme override.
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  /// Optional margin override.
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;
  /// Creates a [ButtonTheme] with optional style property delegates.
  ///
  /// All parameters are optional, allowing selective override of specific
  /// style properties while leaving others to use default values.
  const ButtonTheme({this.decoration, this.mouseCursor, this.padding, this.textStyle, this.iconTheme, this.margin});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
