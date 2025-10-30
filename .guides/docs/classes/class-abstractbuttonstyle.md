---
title: "Class: AbstractButtonStyle"
description: "Abstract interface defining the style properties for button components."
---

```dart
/// Abstract interface defining the style properties for button components.
///
/// [AbstractButtonStyle] specifies the contract for button styling, requiring
/// implementations to provide state-dependent values for decoration, cursor,
/// padding, text style, icon theme, and margin. This abstraction allows for
/// flexible button theming while maintaining a consistent API.
///
/// All properties return [ButtonStateProperty] functions that resolve values
/// based on the button's current interactive state (hovered, pressed, focused, etc.).
///
/// Implementations include [ButtonStyle] and [ButtonVariance], which provide
/// concrete styling configurations for different button types.
abstract class AbstractButtonStyle {
  /// Returns the decoration (background, border, shadows) based on button state.
  ButtonStateProperty<Decoration> get decoration;
  /// Returns the mouse cursor appearance based on button state.
  ButtonStateProperty<MouseCursor> get mouseCursor;
  /// Returns the internal padding based on button state.
  ButtonStateProperty<EdgeInsetsGeometry> get padding;
  /// Returns the text style based on button state.
  ButtonStateProperty<TextStyle> get textStyle;
  /// Returns the icon theme based on button state.
  ButtonStateProperty<IconThemeData> get iconTheme;
  /// Returns the external margin based on button state.
  ButtonStateProperty<EdgeInsetsGeometry> get margin;
}
```
