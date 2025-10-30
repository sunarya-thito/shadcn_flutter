---
title: "Class: ConstrainedTableSize"
description: "Defines size constraints for table columns or rows."
---

```dart
/// Defines size constraints for table columns or rows.
///
/// Specifies minimum and maximum size limits that can be applied
/// to table dimensions. Used with [ResizableTable] to control
/// resize boundaries.
///
/// Example:
/// ```dart
/// ConstrainedTableSize(
///   min: 50.0,  // Minimum 50 pixels
///   max: 300.0, // Maximum 300 pixels
/// )
/// ```
class ConstrainedTableSize {
  /// Minimum allowed size. Defaults to negative infinity (no minimum).
  final double min;
  /// Maximum allowed size. Defaults to positive infinity (no maximum).
  final double max;
  /// Creates a [ConstrainedTableSize] with optional min and max values.
  const ConstrainedTableSize({this.min = double.negativeInfinity, this.max = double.infinity});
}
```
