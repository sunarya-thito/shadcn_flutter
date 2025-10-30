---
title: "Class: FocusOutlineTheme"
description: "Theme configuration for focus outline appearance."
---

```dart
/// Theme configuration for focus outline appearance.
///
/// Defines styling properties for focus outlines that indicate which element
/// has keyboard focus. Used by [FocusOutline] to apply consistent focus
/// visualization across the application.
class FocusOutlineTheme {
  /// The alignment offset of the outline relative to the widget bounds.
  ///
  /// Positive values expand the outline outward, negative values contract it.
  final double? align;
  /// Border radius for rounded corners on the focus outline.
  final BorderRadiusGeometry? borderRadius;
  /// The border style for the focus outline.
  final Border? border;
  /// Creates a [FocusOutlineTheme].
  ///
  /// Parameters:
  /// - [align] (`double?`, optional): Outline alignment offset.
  /// - [border] (`Border?`, optional): Outline border style.
  /// - [borderRadius] (`BorderRadiusGeometry?`, optional): Corner rounding.
  const FocusOutlineTheme({this.align, this.border, this.borderRadius});
  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [border] (`ValueGetter<Border?>?`, optional): New border.
  /// - [align] (`ValueGetter<double?>?`, optional): New alignment offset.
  /// - [borderRadius] (`ValueGetter<BorderRadiusGeometry?>?`, optional): New border radius.
  ///
  /// Returns: A new [FocusOutlineTheme] with updated properties.
  FocusOutlineTheme copyWith({ValueGetter<Border?>? border, ValueGetter<double?>? align, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
