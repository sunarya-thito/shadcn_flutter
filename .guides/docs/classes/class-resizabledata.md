---
title: "Class: ResizableData"
description: "Data class providing information about a resizable panel's orientation."
---

```dart
/// Data class providing information about a resizable panel's orientation.
///
/// Used internally to pass layout direction information through the widget tree.
class ResizableData {
  /// The axis direction of the resizable panel (horizontal or vertical).
  final Axis direction;
  /// Creates [ResizableData] with the specified [direction].
  ResizableData(this.direction);
}
```
