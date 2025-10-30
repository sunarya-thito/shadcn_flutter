---
title: "Class: LinkButtonTheme"
description: "Theme configuration for link button styling."
---

```dart
/// Theme configuration for link button styling.
///
/// Provides theme-level customization for link buttons. Link buttons appear as
/// inline hyperlinks with underline decoration.
class LinkButtonTheme extends ButtonTheme {
  /// Creates a [LinkButtonTheme] with optional style property delegates.
  const LinkButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  LinkButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
