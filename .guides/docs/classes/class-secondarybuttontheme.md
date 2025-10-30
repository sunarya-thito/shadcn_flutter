---
title: "Class: SecondaryButtonTheme"
description: "Theme configuration for secondary button styling."
---

```dart
/// Theme configuration for secondary button styling.
///
/// Provides theme-level customization for secondary buttons through the component
/// theme system. Secondary buttons have muted styling suitable for supporting actions.
class SecondaryButtonTheme extends ButtonTheme {
  /// Creates a [SecondaryButtonTheme] with optional style property delegates.
  const SecondaryButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  SecondaryButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
