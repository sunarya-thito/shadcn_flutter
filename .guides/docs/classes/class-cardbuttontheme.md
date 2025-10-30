---
title: "Class: CardButtonTheme"
description: "Theme configuration for card button styling."
---

```dart
/// Theme configuration for card button styling.
///
/// Provides theme-level customization for card buttons. Card buttons feature
/// subtle shadows and borders creating an elevated, card-like appearance.
class CardButtonTheme extends ButtonTheme {
  /// Creates a [CardButtonTheme] with optional style property delegates.
  const CardButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  CardButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
