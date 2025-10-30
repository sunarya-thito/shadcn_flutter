---
title: "Class: TextFieldTheme"
description: "Theme data for customizing [TextField] appearance."
---

```dart
/// Theme data for customizing [TextField] appearance.
///
/// This class defines the visual properties that can be applied to
/// [TextField] widgets, including border styling, fill state, padding,
/// and border radius. These properties can be set at the theme level
/// to provide consistent styling across the application.
class TextFieldTheme {
  /// Border radius for text field corners.
  ///
  /// If `null`, uses default border radius from the theme.
  final BorderRadiusGeometry? borderRadius;
  /// Whether the text field has a filled background.
  ///
  /// When `true`, applies a background fill color.
  final bool? filled;
  /// Padding inside the text field.
  ///
  /// If `null`, uses default padding from the theme.
  final EdgeInsetsGeometry? padding;
  /// Border style for the text field.
  ///
  /// If `null`, uses default border from the theme.
  final Border? border;
  /// Creates a [TextFieldTheme].
  ///
  /// Parameters:
  /// - [border] (`Border?`, optional): Border style.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): Corner rounding.
  /// - [filled] (`bool?`, optional): Whether background is filled.
  /// - [padding] (`EdgeInsetsGeometry?`, optional): Internal padding.
  const TextFieldTheme({this.border, this.borderRadius, this.filled, this.padding});
  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters use value getters to allow `null` values to be explicitly set.
  TextFieldTheme copyWith({ValueGetter<Border?>? border, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<bool?>? filled, ValueGetter<EdgeInsetsGeometry?>? padding});
  bool operator ==(Object other);
  int get hashCode;
}
```
