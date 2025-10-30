---
title: "Class: ResizableDraggerTheme"
description: "Theme for [HorizontalResizableDragger] and [VerticalResizableDragger]."
---

```dart
/// Theme for [HorizontalResizableDragger] and [VerticalResizableDragger].
class ResizableDraggerTheme {
  /// Background color of the dragger.
  final Color? color;
  /// Border radius of the dragger.
  final double? borderRadius;
  /// Width of the dragger.
  final double? width;
  /// Height of the dragger.
  final double? height;
  /// Icon size inside the dragger.
  final double? iconSize;
  /// Icon color inside the dragger.
  final Color? iconColor;
  /// Creates a [ResizableDraggerTheme].
  const ResizableDraggerTheme({this.color, this.borderRadius, this.width, this.height, this.iconSize, this.iconColor});
  /// Creates a copy of this theme with the given fields replaced.
  ResizableDraggerTheme copyWith({ValueGetter<Color?>? color, ValueGetter<double?>? borderRadius, ValueGetter<double?>? width, ValueGetter<double?>? height, ValueGetter<double?>? iconSize, ValueGetter<Color?>? iconColor});
  bool operator ==(Object other);
  int get hashCode;
}
```
