---
title: "Class: MenuButtonTheme"
description: "Theme configuration for menu button styling."
---

```dart
/// Theme configuration for menu button styling.
///
/// Provides theme-level customization for menu buttons. Menu buttons are designed
/// for triggering dropdown menus with appropriate spacing and styling.
class MenuButtonTheme extends ButtonTheme {
  /// Creates a [MenuButtonTheme] with optional style property delegates.
  const MenuButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  MenuButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
