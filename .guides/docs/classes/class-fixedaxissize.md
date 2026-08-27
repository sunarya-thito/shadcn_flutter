---
title: "Class: FixedAxisSize"
description: "An [AxisSize] of a fixed number of logical pixels."
---

```dart
/// An [AxisSize] of a fixed number of logical pixels.
class FixedAxisSize extends AxisSize {
  /// The size in logical pixels.
  final double size;
  /// Creates a fixed axis size.
  const FixedAxisSize(this.size);
  double resolve(double available);
}
```
