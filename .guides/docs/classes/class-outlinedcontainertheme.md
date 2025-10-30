---
title: "Class: OutlinedContainerTheme"
description: "Theme configuration for [OutlinedContainer] appearance."
---

```dart
/// Theme configuration for [OutlinedContainer] appearance.
///
/// Defines styling properties including background color, border styles,
/// shadows, padding, and surface effects for outlined containers.
class OutlinedContainerTheme {
  /// Background color for the container.
  final Color? backgroundColor;
  /// Color of the container's border.
  final Color? borderColor;
  /// Border radius for rounded corners.
  final BorderRadiusGeometry? borderRadius;
  /// Style of the border (solid, dotted, etc).
  final BorderStyle? borderStyle;
  /// Width of the border in logical pixels.
  final double? borderWidth;
  /// Box shadows to apply for depth/elevation effects.
  final List<BoxShadow>? boxShadow;
  /// Padding inside the container.
  final EdgeInsetsGeometry? padding;
  /// Opacity for surface overlay effects.
  final double? surfaceOpacity;
  /// Blur amount for surface backdrop effects.
  final double? surfaceBlur;
  /// Creates an [OutlinedContainerTheme].
  const OutlinedContainerTheme({this.backgroundColor, this.borderColor, this.borderRadius, this.borderStyle, this.borderWidth, this.boxShadow, this.padding, this.surfaceOpacity, this.surfaceBlur});
  /// Creates a copy of this theme with the given fields replaced.
  OutlinedContainerTheme copyWith({ValueGetter<Color?>? backgroundColor, ValueGetter<Color?>? borderColor, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<BorderStyle?>? borderStyle, ValueGetter<double?>? borderWidth, ValueGetter<List<BoxShadow>?>? boxShadow, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<double?>? surfaceOpacity, ValueGetter<double?>? surfaceBlur});
  bool operator ==(Object other);
  int get hashCode;
}
```
