---
title: "Class: RadioCardTheme"
description: "Theme data for the [RadioCard] widget."
---

```dart
/// Theme data for the [RadioCard] widget.
class RadioCardTheme {
  /// The cursor to use when the radio card is enabled.
  final MouseCursor? enabledCursor;
  /// The cursor to use when the radio card is disabled.
  final MouseCursor? disabledCursor;
  /// The color to use when the radio card is hovered over.
  final Color? hoverColor;
  /// The default color to use.
  final Color? color;
  /// The width of the border of the radio card.
  final double? borderWidth;
  /// The width of the border of the radio card when selected.
  final double? selectedBorderWidth;
  /// The radius of the border of the radio card.
  final BorderRadiusGeometry? borderRadius;
  /// The padding of the radio card.
  final EdgeInsetsGeometry? padding;
  /// The color of the border.
  final Color? borderColor;
  /// The color of the border when selected.
  final Color? selectedBorderColor;
  /// Theme data for the [RadioCard] widget.
  const RadioCardTheme({this.enabledCursor, this.disabledCursor, this.hoverColor, this.color, this.borderWidth, this.selectedBorderWidth, this.borderRadius, this.padding, this.borderColor, this.selectedBorderColor});
  String toString();
  /// Creates a copy of this [RadioCardTheme] but with the given fields replaced with the new values.
  RadioCardTheme copyWith({ValueGetter<MouseCursor?>? enabledCursor, ValueGetter<MouseCursor?>? disabledCursor, ValueGetter<Color?>? hoverColor, ValueGetter<Color?>? color, ValueGetter<double?>? borderWidth, ValueGetter<double?>? selectedBorderWidth, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Color?>? borderColor, ValueGetter<Color?>? selectedBorderColor});
  bool operator ==(Object other);
  int get hashCode;
}
```
