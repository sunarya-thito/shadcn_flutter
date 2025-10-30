---
title: "Class: OutlineButtonTheme"
description: "Theme configuration for outline button styling."
---

```dart
/// Theme configuration for outline button styling.
///
/// Provides theme-level customization for outline buttons through the component
/// theme system. Outline buttons feature borders with transparent backgrounds.
class OutlineButtonTheme extends ButtonTheme {
  /// Creates an [OutlineButtonTheme] with optional style property delegates.
  const OutlineButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  OutlineButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
