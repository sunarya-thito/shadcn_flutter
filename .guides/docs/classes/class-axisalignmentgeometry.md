---
title: "Class: AxisAlignmentGeometry"
description: "Base class for axis-based alignment."
---

```dart
/// Base class for axis-based alignment.
///
/// This allows defining alignment along a single axis which can be
/// resolved to concrete values based on [TextDirection].
abstract class AxisAlignmentGeometry {
  /// Creates an [AxisAlignmentGeometry].
  const AxisAlignmentGeometry();
  /// Resolves the alignment to a concrete [AxisAlignment] based on the text direction.
  ///
  /// Parameters:
  /// - [textDirection] (`TextDirection`, required): The text direction to resolve against.
  ///
  /// Returns:
  /// An [AxisAlignment] corresponding to the resolved alignment.
  AxisAlignment resolve(TextDirection textDirection);
}
```
