---
title: "Class: ThemeDataTween"
description: "A tween for animating between two [ThemeData] values."
---

```dart
/// A tween for animating between two [ThemeData] values.
class ThemeDataTween extends Tween<ThemeData> {
  /// Creates a [ThemeDataTween].
  ///
  /// Parameters:
  /// - [begin] (`ThemeData`, required): Starting theme.
  /// - [end] (`ThemeData`, required): Ending theme.
  ThemeDataTween({required ThemeData super.begin, required super.end});
  ThemeData lerp(double t);
}
```
