---
title: "Class: TableRow"
description: "Represents a row in a table."
---

```dart
/// Represents a row in a table.
///
/// Contains a list of cells and optional styling for all cells in the row.
/// Can be marked as selected to highlight the entire row.
///
/// Example:
/// ```dart
/// TableRow(
///   cells: [
///     TableCell(child: Text('Cell 1')),
///     TableCell(child: Text('Cell 2')),
///   ],
///   selected: true,
///   cellTheme: TableCellTheme(...),
/// )
/// ```
class TableRow {
  /// The cells contained in this row.
  final List<TableCell> cells;
  /// Theme applied to all cells in this row.
  final TableCellTheme? cellTheme;
  /// Whether this row is selected.
  final bool selected;
  /// Creates a [TableRow].
  const TableRow({required this.cells, this.cellTheme, this.selected = false});
  /// Builds the default theme for cells in this row.
  ///
  /// Creates a [TableCellTheme] with default styling when no explicit [cellTheme]
  /// is provided. The default theme includes:
  /// - Border with bottom line using theme border color
  /// - Background color that changes to muted on hover
  /// - Text style that becomes muted when disabled
  ///
  /// The theme uses [WidgetStateProperty] to adapt styling based on cell state
  /// (hovered, selected, disabled).
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context for accessing theme data
  ///
  /// Returns [TableCellTheme] with default or custom cell styling.
  TableCellTheme buildDefaultTheme(BuildContext context);
  bool operator ==(Object other);
  int get hashCode;
}
```
