---
title: "Class: RawCell"
description: "Low-level widget for positioning cells in table layouts."
---

```dart
/// Low-level widget for positioning cells in table layouts.
///
/// Sets parent data for a table cell widget. Used internally by
/// table implementations to manage cell positioning and spanning.
///
/// Example:
/// ```dart
/// RawCell(
///   column: 0,
///   row: 1,
///   columnSpan: 2,
///   child: Container(...),
/// )
/// ```
class RawCell extends ParentDataWidget<TableParentData> {
  /// Column index for this cell.
  final int column;
  /// Row index for this cell.
  final int row;
  /// Number of columns spanned. Defaults to 1.
  final int? columnSpan;
  /// Number of rows spanned. Defaults to 1.
  final int? rowSpan;
  /// Whether to compute size for this cell.
  final bool computeSize;
  /// Creates a [RawCell].
  const RawCell({super.key, required this.column, required this.row, this.columnSpan, this.rowSpan, this.computeSize = true, required super.child});
  void applyParentData(RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
}
```
