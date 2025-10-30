---
title: "Class: DestructiveButtonTheme"
description: "Theme configuration for destructive button styling."
---

```dart
/// Theme configuration for destructive button styling.
///
/// Provides theme-level customization for destructive buttons. Destructive buttons
/// use warning colors (typically red) for actions that delete or remove data.
class DestructiveButtonTheme extends ButtonTheme {
  /// Creates a [DestructiveButtonTheme] with optional style property delegates.
  const DestructiveButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  DestructiveButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
