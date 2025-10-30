---
title: "Class: FrozenTableData"
description: "Configuration for frozen (pinned) rows and columns in a table."
---

```dart
/// Configuration for frozen (pinned) rows and columns in a table.
///
/// Specifies which rows and columns should remain fixed in place
/// during scrolling, useful for keeping headers or key columns visible.
///
/// Example:
/// ```dart
/// FrozenTableData(
///   frozenRows: [TableRef(0)],      // Freeze first row (header)
///   frozenColumns: [TableRef(0, 2)], // Freeze first two columns
/// )
/// ```
class FrozenTableData {
  /// Rows that should be frozen during vertical scrolling.
  final Iterable<TableRef> frozenRows;
  /// Columns that should be frozen during horizontal scrolling.
  final Iterable<TableRef> frozenColumns;
  /// Creates a [FrozenTableData].
  const FrozenTableData({this.frozenRows = const [], this.frozenColumns = const []});
  /// Tests if a row at the given index and span is frozen.
  bool testRow(int index, int span);
  /// Tests if a column at the given index and span is frozen.
  bool testColumn(int index, int span);
}
```
