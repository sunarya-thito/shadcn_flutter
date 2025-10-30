---
title: "Class: MutedButtonTheme"
description: "Theme configuration for muted button styling."
---

```dart
/// Theme configuration for muted button styling.
///
/// Provides theme-level customization for muted buttons. Muted buttons use
/// low-contrast colors for minimal visual impact while remaining functional.
class MutedButtonTheme extends ButtonTheme {
  /// Creates a [MutedButtonTheme] with optional style property delegates.
  const MutedButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  MutedButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
