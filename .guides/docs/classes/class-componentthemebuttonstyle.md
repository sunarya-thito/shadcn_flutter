---
title: "Class: ComponentThemeButtonStyle"
description: "Theme-aware button style that integrates with the component theme system."
---

```dart
/// Theme-aware button style that integrates with the component theme system.
///
/// [ComponentThemeButtonStyle] implements [AbstractButtonStyle] and provides
/// automatic theme integration by looking up theme overrides from the widget tree's
/// [ComponentTheme]. If a theme override is found, it's applied; otherwise, the
/// fallback style is used.
///
/// This enables global button style customization through the theme system while
/// maintaining type-safe access to specific button theme types.
///
/// Example:
/// ```dart
/// const ComponentThemeButtonStyle<PrimaryButtonTheme>(
///   fallback: ButtonVariance.primary,
/// )
/// ```
class ComponentThemeButtonStyle<T extends ButtonTheme> implements AbstractButtonStyle {
  /// The fallback style used when no theme override is found.
  final AbstractButtonStyle fallback;
  /// Creates a [ComponentThemeButtonStyle] with the specified fallback style.
  ///
  /// Parameters:
  /// - [fallback] (required): The default style used when theme override is not available.
  const ComponentThemeButtonStyle({required this.fallback});
  /// Looks up the button theme of type [T] from the component theme.
  ///
  /// Returns the theme instance if found in the widget tree, or `null` if not present.
  T? find(BuildContext context);
  ButtonStateProperty<Decoration> get decoration;
  ButtonStateProperty<IconThemeData> get iconTheme;
  ButtonStateProperty<EdgeInsetsGeometry> get margin;
  ButtonStateProperty<MouseCursor> get mouseCursor;
  ButtonStateProperty<EdgeInsetsGeometry> get padding;
  ButtonStateProperty<TextStyle> get textStyle;
}
```
