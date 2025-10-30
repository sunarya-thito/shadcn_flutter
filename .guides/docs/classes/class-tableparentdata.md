---
title: "Class: TableParentData"
description: "Parent data for table cell layout information."
---

```dart
/// Parent data for table cell layout information.
///
/// Stores layout parameters for cells in a table including position,
/// span, and frozen state. Used internally by the table rendering system.
class TableParentData extends ContainerBoxParentData<RenderBox> {
  /// Column index of this cell.
  int? column;
  /// Row index of this cell.
  int? row;
  /// Number of columns this cell spans.
  int? columnSpan;
  /// Number of rows this cell spans.
  int? rowSpan;
  /// Whether to compute size for this cell.
  bool computeSize;
  /// Whether this cell's row is frozen.
  bool frozenRow;
  /// Whether this cell's column is frozen.
  bool frozenColumn;
}
```
