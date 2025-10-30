---
title: "Class: GhostButtonTheme"
description: "Theme configuration for ghost button styling."
---

```dart
/// Theme configuration for ghost button styling.
///
/// Provides theme-level customization for ghost buttons. Ghost buttons have minimal
/// visual presence with no background or border by default.
class GhostButtonTheme extends ButtonTheme {
  /// Creates a [GhostButtonTheme] with optional style property delegates.
  const GhostButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  GhostButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
