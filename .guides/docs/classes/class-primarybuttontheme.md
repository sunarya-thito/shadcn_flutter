---
title: "Class: PrimaryButtonTheme"
description: "Theme configuration for primary button styling."
---

```dart
/// Theme configuration for primary button styling.
///
/// [PrimaryButtonTheme] extends [ButtonTheme] to provide theme-level customization
/// for primary buttons. It can be registered in the component theme system to
/// override default primary button styles throughout the application.
///
/// Example:
/// ```dart
/// PrimaryButtonTheme(
///   decoration: (context, states, defaultValue) {
///     // Customize primary button decoration
///     return customDecoration;
///   },
/// )
/// ```
class PrimaryButtonTheme extends ButtonTheme {
  /// Creates a [PrimaryButtonTheme] with optional style property delegates.
  const PrimaryButtonTheme({super.decoration, super.mouseCursor, super.padding, super.textStyle, super.iconTheme, super.margin});
  /// Creates a copy of this theme with selectively replaced properties.
  PrimaryButtonTheme copyWith({ValueGetter<ButtonStatePropertyDelegate<Decoration>?>? decoration, ValueGetter<ButtonStatePropertyDelegate<MouseCursor>?>? mouseCursor, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? padding, ValueGetter<ButtonStatePropertyDelegate<TextStyle>?>? textStyle, ValueGetter<ButtonStatePropertyDelegate<IconThemeData>?>? iconTheme, ValueGetter<ButtonStatePropertyDelegate<EdgeInsetsGeometry>?>? margin});
}
```
