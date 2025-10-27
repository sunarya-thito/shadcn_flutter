---
title: "Class: HiddenTheme"
description: "Theme for [Hidden]."
---

```dart
/// Theme for [Hidden].
class HiddenTheme {
  /// Direction of the hidden transition.
  final Axis? direction;
  /// Duration of the animation.
  final Duration? duration;
  /// Curve of the animation.
  final Curve? curve;
  /// Whether the widget is reversed.
  final bool? reverse;
  /// Whether to keep cross axis size when hidden.
  final bool? keepCrossAxisSize;
  /// Whether to keep main axis size when hidden.
  final bool? keepMainAxisSize;
  /// Creates a [HiddenTheme].
  const HiddenTheme({this.direction, this.duration, this.curve, this.reverse, this.keepCrossAxisSize, this.keepMainAxisSize});
  /// Returns a copy of this theme with the given fields replaced.
  HiddenTheme copyWith({ValueGetter<Axis?>? direction, ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<bool?>? reverse, ValueGetter<bool?>? keepCrossAxisSize, ValueGetter<bool?>? keepMainAxisSize});
  bool operator ==(Object other);
  int get hashCode;
}
```
