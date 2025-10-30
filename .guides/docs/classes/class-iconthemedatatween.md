---
title: "Class: IconThemeDataTween"
description: "A tween for animating between two [IconThemeData] values."
---

```dart
/// A tween for animating between two [IconThemeData] values.
class IconThemeDataTween extends Tween<IconThemeData> {
  /// Creates an [IconThemeDataTween].
  ///
  /// Parameters:
  /// - [begin] (`IconThemeData?`, optional): Starting icon theme.
  /// - [end] (`IconThemeData?`, optional): Ending icon theme.
  IconThemeDataTween({super.begin, super.end});
  IconThemeData lerp(double t);
}
```
