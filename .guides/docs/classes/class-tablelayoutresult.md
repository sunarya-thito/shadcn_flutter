---
title: "Class: TableLayoutResult"
description: "Result of table layout calculations."
---

```dart
/// Result of table layout calculations.
///
/// Contains computed column widths, row heights, and remaining space
/// information after layout. Used internally by the table rendering system.
class TableLayoutResult {
  /// Computed widths for each column.
  final List<double> columnWidths;
  /// Computed heights for each row.
  final List<double> rowHeights;
  /// Remaining width after layout.
  final double remainingWidth;
  /// Remaining height after layout.
  final double remainingHeight;
  /// Remaining loose width for flex items.
  final double remainingLooseWidth;
  /// Remaining loose height for flex items.
  final double remainingLooseHeight;
  /// Whether tight flex sizing is used for width.
  final bool hasTightFlexWidth;
  /// Whether tight flex sizing is used for height.
  final bool hasTightFlexHeight;
  /// Creates a [TableLayoutResult].
  TableLayoutResult({required this.columnWidths, required this.rowHeights, required this.remainingWidth, required this.remainingHeight, required this.remainingLooseWidth, required this.remainingLooseHeight, required this.hasTightFlexWidth, required this.hasTightFlexHeight});
  /// Calculates the top-left offset of a cell at the given position.
  ///
  /// Computes the cumulative offset by summing all column widths before
  /// the target column and all row heights before the target row.
  ///
  /// Parameters:
  /// - [column] (int, required): Zero-based column index
  /// - [row] (int, required): Zero-based row index
  ///
  /// Returns [Offset] representing the cell's position relative to table origin.
  Offset getOffset(int column, int row);
  /// Returns the sum of all column widths and row heights.
  Size get size;
  /// Gets the total width of the table.
  ///
  /// Calculates the sum of all column widths to determine the table's
  /// total horizontal extent. This is the natural width the table would
  /// occupy without any constraints.
  ///
  /// Returns total table width in logical pixels as a double.
  double get width;
  /// Gets the total height of the table.
  ///
  /// Calculates the sum of all row heights to determine the table's
  /// total vertical extent. This is the natural height the table would
  /// occupy without any constraints.
  ///
  /// Returns total table height in logical pixels as a double.
  double get height;
}
```
