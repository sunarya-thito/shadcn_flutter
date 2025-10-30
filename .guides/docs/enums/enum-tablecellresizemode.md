---
title: "Enum: TableCellResizeMode"
description: "Defines how table cells should resize."
---

```dart
/// Defines how table cells should resize.
///
/// Determines the behavior when a table cell is resized by the user.
enum TableCellResizeMode {
  /// The cell size will expand when resized
  expand,
  /// The cell size will expand when resized, but the other cells will shrink
  reallocate,
  /// Disables resizing
  none,
}
```
