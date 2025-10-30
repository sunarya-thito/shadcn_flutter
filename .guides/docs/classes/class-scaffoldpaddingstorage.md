---
title: "Class: ScaffoldPaddingStorage"
description: "Storage for scaffold padding values."
---

```dart
/// Storage for scaffold padding values.
///
/// Holds padding values for all four sides of the scaffold content area.
class ScaffoldPaddingStorage {
  /// Top padding value.
  double top;
  /// Left padding value.
  double left;
  /// Right padding value.
  double right;
  /// Bottom padding value.
  double bottom;
  /// Creates a [ScaffoldPaddingStorage].
  ///
  /// Parameters:
  /// - [top] (`double`, required): Top padding.
  /// - [left] (`double`, required): Left padding.
  /// - [right] (`double`, required): Right padding.
  /// - [bottom] (`double`, required): Bottom padding.
  ScaffoldPaddingStorage({required this.top, required this.left, required this.right, required this.bottom});
}
```
