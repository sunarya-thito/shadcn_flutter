---
title: "Class: AxisInsetsDirectional"
description: "Directional insets along an axis.   These insets are defined as start and end, and resolve to left/right or  right/left based on the [TextDirection]."
---

```dart
/// Directional insets along an axis.
///
/// These insets are defined as start and end, and resolve to left/right or
/// right/left based on the [TextDirection].
class AxisInsetsDirectional extends AxisInsetsGeometry {
  /// The start value.
  final double start;
  /// The end value.
  final double end;
  /// Creates an [AxisInsetsDirectional].
  ///
  /// Parameters:
  /// - [start] (`double`, required): The start value.
  /// - [end] (`double`, required): The end value.
  const AxisInsetsDirectional({required this.start, required this.end});
  AxisInsets resolve(TextDirection textDirection);
}
```
