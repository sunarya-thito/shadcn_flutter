---
title: "Class: FixedButtonTheme"
description: "Theme configuration for fixed button styling."
---

```dart
/// Theme configuration for fixed button styling.
///
/// Provides theme-level customization for fixed buttons. Fixed buttons maintain
/// consistent dimensions regardless of content.
class FixedButtonTheme extends ButtonTheme {
  /// Creates a [FixedButtonTheme] with optional style property delegates.
  const FixedButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  FixedButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
