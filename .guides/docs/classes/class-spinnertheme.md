---
title: "Class: SpinnerTheme"
description: "Theme configuration for spinner widgets."
---

```dart
/// Theme configuration for spinner widgets.
class SpinnerTheme {
  /// Color of the spinner elements.
  final Color? color;
  /// Size of the spinner widget.
  final double? size;
  /// Creates a [SpinnerTheme] with optional color and size.
  const SpinnerTheme({this.color, this.size});
  /// Creates a copy of this theme with selectively replaced properties.
  SpinnerTheme copyWith({ValueGetter<Color?>? color, ValueGetter<double?>? size});
  bool operator ==(Object other);
  int get hashCode;
}
```
