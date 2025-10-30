---
title: "Class: FixedTableSize"
description: "Table size mode with a fixed pixel value."
---

```dart
/// Table size mode with a fixed pixel value.
///
/// Allocates a specific fixed size regardless of available space.
/// Used for columns/rows that should maintain a constant size.
///
/// Example:
/// ```dart
/// FixedTableSize(150.0) // 150 pixels
/// ```
class FixedTableSize extends TableSize {
  /// The fixed size value in pixels.
  final double value;
  /// Creates a [FixedTableSize] with the specified pixel value.
  const FixedTableSize(this.value);
}
```
