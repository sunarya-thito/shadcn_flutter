---
title: "Class: MenubarButtonTheme"
description: "Theme configuration for menubar button styling."
---

```dart
/// Theme configuration for menubar button styling.
///
/// Provides theme-level customization for menubar buttons. Menubar buttons are
/// optimized for horizontal menu bars with appropriate padding and hover effects.
class MenubarButtonTheme extends ButtonTheme {
  /// Creates a [MenubarButtonTheme] with optional style property delegates.
  const MenubarButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  MenubarButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
