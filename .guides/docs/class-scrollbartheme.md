---
title: "Class: ScrollbarTheme"
description: "Theme configuration for [Scrollbar]."
---

```dart
/// Theme configuration for [Scrollbar].
class ScrollbarTheme {
  /// Color of the scrollbar thumb.
  final Color? color;
  /// Thickness of the scrollbar thumb.
  final double? thickness;
  /// Radius of the scrollbar thumb.
  final Radius? radius;
  /// Creates a [ScrollbarTheme].
  const ScrollbarTheme({this.color, this.thickness, this.radius});
  /// Creates a copy of this theme with the given values replaced.
  ScrollbarTheme copyWith({ValueGetter<Color?>? color, ValueGetter<double?>? thickness, ValueGetter<Radius?>? radius});
  bool operator ==(Object other);
  int get hashCode;
}
```
