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
  const SpinnerTheme({this.color, this.size});
  SpinnerTheme copyWith({ValueGetter<Color?>? color, ValueGetter<double?>? size});
  bool operator ==(Object other);
  int get hashCode;
}
```
