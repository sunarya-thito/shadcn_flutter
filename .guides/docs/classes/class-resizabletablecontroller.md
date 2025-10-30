---
title: "Class: ResizableTableController"
description: "Controller for managing resizable table column and row dimensions."
---

```dart
/// Controller for managing resizable table column and row dimensions.
///
/// Provides programmatic control over table column widths and row heights
/// with support for constraints, default sizes, and interactive resizing.
/// Extends [ChangeNotifier] to notify listeners when dimensions change.
///
/// Example:
/// ```dart
/// final controller = ResizableTableController(
///   defaultColumnWidth: 100.0,
///   defaultRowHeight: 40.0,
///   columnWidths: {0: 150.0, 2: 200.0},
///   widthConstraints: {1: ConstrainedTableSize(min: 50, max: 300)},
/// );
/// ```
class ResizableTableController extends ChangeNotifier {
  /// Creates a controller for managing resizable table dimensions.
  ///
  /// This controller manages column widths and row heights with support for
  /// constraints and dynamic resizing. It provides methods to resize individual
  /// columns/rows or adjust shared borders between adjacent columns/rows.
  ///
  /// Parameters:
  /// - [columnWidths] (`Map<int, double>?`): Initial column widths by index
  /// - [defaultColumnWidth] (double, required): Default width for columns without explicit width
  /// - [rowHeights] (`Map<int, double>?`): Initial row heights by index
  /// - [defaultRowHeight] (double, required): Default height for rows without explicit height
  /// - [defaultWidthConstraint] (ConstrainedTableSize?): Default width constraints applied to all columns
  /// - [defaultHeightConstraint] (ConstrainedTableSize?): Default height constraints applied to all rows
  /// - [widthConstraints] (`Map<int, ConstrainedTableSize>?`): Per-column width constraints
  /// - [heightConstraints] (`Map<int, ConstrainedTableSize>?`): Per-row height constraints
  ///
  /// Example:
  /// ```dart
  /// ResizableTableController(
  ///   defaultColumnWidth: 100,
  ///   defaultRowHeight: 40,
  ///   widthConstraints: {
  ///     0: ConstrainedTableSize(min: 80, max: 200),
  ///   },
  /// )
  /// ```
  ResizableTableController({Map<int, double>? columnWidths, required double defaultColumnWidth, Map<int, double>? rowHeights, required double defaultRowHeight, ConstrainedTableSize? defaultWidthConstraint, ConstrainedTableSize? defaultHeightConstraint, Map<int, ConstrainedTableSize>? widthConstraints, Map<int, ConstrainedTableSize>? heightConstraints});
  /// Resizes a specific column to a new width.
  ///
  /// Parameters:
  /// - [column] (`int`, required): Column index.
  /// - [width] (`double`, required): New width in pixels.
  ///
  /// Returns: `bool` — true if resize succeeded, false otherwise.
  bool resizeColumn(int column, double width);
  /// Resizes adjacent columns by dragging their shared border.
  ///
  /// Parameters:
  /// - [previousColumn] (`int`, required): Index of column before border.
  /// - [nextColumn] (`int`, required): Index of column after border.
  /// - [deltaWidth] (`double`, required): Width change in pixels.
  ///
  /// Returns: `double` — actual width change applied.
  double resizeColumnBorder(int previousColumn, int nextColumn, double deltaWidth);
  /// Resizes adjacent rows by dragging their shared border.
  ///
  /// Parameters:
  /// - [previousRow] (`int`, required): Index of row before border.
  /// - [nextRow] (`int`, required): Index of row after border.
  /// - [deltaHeight] (`double`, required): Height change in pixels.
  ///
  /// Returns: `double` — actual height change applied.
  double resizeRowBorder(int previousRow, int nextRow, double deltaHeight);
  /// Resizes a specific row to a new height.
  ///
  /// Parameters:
  /// - [row] (`int`, required): Row index.
  /// - [height] (`double`, required): New height in pixels.
  ///
  /// Returns: `bool` — true if resize succeeded, false otherwise.
  bool resizeRow(int row, double height);
  /// Gets an unmodifiable map of custom column widths.
  ///
  /// Returns: `Map<int, double>?` — map of column indices to widths, or null if none set.
  Map<int, double>? get columnWidths;
  /// Gets an unmodifiable map of custom row heights.
  ///
  /// Returns: `Map<int, double>?` — map of row indices to heights, or null if none set.
  Map<int, double>? get rowHeights;
  /// Gets the width of a specific column.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Column index.
  ///
  /// Returns: `double` — column width in pixels.
  double getColumnWidth(int index);
  /// Gets the height of a specific row.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Row index.
  ///
  /// Returns: `double` — row height in pixels.
  double getRowHeight(int index);
  /// Gets the minimum height constraint for a specific row.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Row index.
  ///
  /// Returns: `double?` — minimum height, or null if unconstrained.
  double? getRowMinHeight(int index);
  /// Gets the maximum height constraint for a specific row.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Row index.
  ///
  /// Returns: `double?` — maximum height, or null if unconstrained.
  double? getRowMaxHeight(int index);
  /// Gets the minimum width constraint for a specific column.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Column index.
  ///
  /// Returns: `double?` — minimum width, or null if unconstrained.
  double? getColumnMinWidth(int index);
  /// Gets the maximum width constraint for a specific column.
  ///
  /// Parameters:
  /// - [index] (`int`, required): Column index.
  ///
  /// Returns: `double?` — maximum width, or null if unconstrained.
  double? getColumnMaxWidth(int index);
}
```
