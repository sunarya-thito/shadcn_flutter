---
title: "Class: DotIndicatorTheme"
description: "Theme configuration for [DotIndicator] and its dot items."
---

```dart
/// Theme configuration for [DotIndicator] and its dot items.
class DotIndicatorTheme {
  /// Spacing between dots.
  final double? spacing;
  /// Padding around the dots container.
  final EdgeInsetsGeometry? padding;
  /// Builder for individual dots.
  final DotBuilder? dotBuilder;
  /// Size of each dot.
  final double? size;
  /// Border radius of dots.
  final double? borderRadius;
  /// Color of the active dot.
  final Color? activeColor;
  /// Color of the inactive dot.
  final Color? inactiveColor;
  /// Border color of the inactive dot.
  final Color? inactiveBorderColor;
  /// Border width of the inactive dot.
  final double? inactiveBorderWidth;
  /// Creates a [DotIndicatorTheme].
  const DotIndicatorTheme({this.spacing, this.padding, this.dotBuilder, this.size, this.borderRadius, this.activeColor, this.inactiveColor, this.inactiveBorderColor, this.inactiveBorderWidth});
  /// Creates a copy of this theme but with the given fields replaced.
  DotIndicatorTheme copyWith({ValueGetter<double?>? spacing, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<DotBuilder?>? dotBuilder, ValueGetter<double?>? size, ValueGetter<double?>? borderRadius, ValueGetter<Color?>? activeColor, ValueGetter<Color?>? inactiveColor, ValueGetter<Color?>? inactiveBorderColor, ValueGetter<double?>? inactiveBorderWidth});
  bool operator ==(Object other);
  int get hashCode;
}
```
