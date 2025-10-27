---
title: "Class: MenuPopupTheme"
description: "A theme for [MenuPopup]."
---

```dart
/// A theme for [MenuPopup].
class MenuPopupTheme {
  /// The opacity of the surface.
  final double? surfaceOpacity;
  /// The blur applied to the surface.
  final double? surfaceBlur;
  /// The padding inside the popup.
  final EdgeInsetsGeometry? padding;
  /// The background color of the popup.
  final Color? fillColor;
  /// The border color of the popup.
  final Color? borderColor;
  /// The border radius of the popup.
  final BorderRadiusGeometry? borderRadius;
  /// Creates a [MenuPopupTheme].
  const MenuPopupTheme({this.surfaceOpacity, this.surfaceBlur, this.padding, this.fillColor, this.borderColor, this.borderRadius});
  /// Returns a copy of this theme with the given fields replaced.
  MenuPopupTheme copyWith({ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<Color?>? fillColor, ValueGetter<Color?>? borderColor, ValueGetter<BorderRadiusGeometry?>? borderRadius});
  bool operator ==(Object other);
  int get hashCode;
}
```
