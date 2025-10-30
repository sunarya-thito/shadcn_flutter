---
title: "Class: TableCell"
description: "Represents a single cell in a table."
---

```dart
/// Represents a single cell in a table.
///
/// Defines cell content, spanning behavior, and styling. Cells can span
/// multiple columns or rows, respond to hover interactions, and have
/// custom themes and background colors.
///
/// Example:
/// ```dart
/// TableCell(
///   columnSpan: 2,
///   rowSpan: 1,
///   child: Text('Spanning cell'),
///   rowHover: true,
///   backgroundColor: Colors.blue.shade50,
/// )
/// ```
class TableCell {
  /// Number of columns this cell spans. Defaults to 1.
  final int columnSpan;
  /// Number of rows this cell spans. Defaults to 1.
  final int rowSpan;
  /// The widget displayed in this cell.
  final Widget child;
  /// Whether to highlight this cell when hovering over its column.
  final bool columnHover;
  /// Whether to highlight this cell when hovering over its row.
  final bool rowHover;
  /// Background color for this cell. Overrides theme color.
  final Color? backgroundColor;
  /// Custom theme for this cell. Overrides table-level theme.
  final TableCellTheme? theme;
  /// Whether this cell responds to user interactions.
  final bool enabled;
  /// Creates a [TableCell].
  const TableCell({this.columnSpan = 1, this.rowSpan = 1, required this.child, this.backgroundColor, this.columnHover = false, this.rowHover = true, this.theme, this.enabled = true});
  /// Builds the widget tree for this table cell.
  ///
  /// This method renders the cell with appropriate styling including:
  /// - Background color based on theme and state
  /// - Border styling with state resolution
  /// - Hover effects for column and row highlighting
  /// - Selection state visualization
  /// - Resize handles if the table is resizable
  ///
  /// The build process integrates with the table's hover system to provide
  /// visual feedback when the mouse hovers over cells in the same row or column.
  ///
  /// Returns a [Widget] representing the fully styled table cell.
  Widget build(BuildContext context);
  bool operator ==(Object other);
  int get hashCode;
}
```
