---
title: "Class: ResizableTable"
description: "A table widget with resizable columns and rows."
---

```dart
/// A table widget with resizable columns and rows.
///
/// Displays tabular data with interactive row and column resizing capabilities.
/// Supports frozen rows/columns, custom resize modes, and scrolling viewports.
///
/// Example:
/// ```dart
/// ResizableTable(
///   controller: ResizableTableController(),
///   rows: [
///     TableRow(children: [Text('Cell 1'), Text('Cell 2')]),
///     TableRow(children: [Text('Cell 3'), Text('Cell 4')]),
///   ],
/// )
/// ```
class ResizableTable extends StatefulWidget {
  /// List of table rows to display.
  final List<TableRow> rows;
  /// Controller for managing table resize state.
  final ResizableTableController controller;
  /// Theme for table styling.
  final ResizableTableTheme? theme;
  /// How content should be clipped at table boundaries.
  final Clip clipBehavior;
  /// Resize mode for column widths.
  final TableCellResizeMode cellWidthResizeMode;
  /// Resize mode for row heights.
  final TableCellResizeMode cellHeightResizeMode;
  /// Configuration for frozen (non-scrolling) rows and columns.
  final FrozenTableData? frozenCells;
  /// Horizontal scroll offset.
  final double? horizontalOffset;
  /// Vertical scroll offset.
  final double? verticalOffset;
  /// Size of the visible viewport.
  final Size? viewportSize;
  /// Creates a [ResizableTable].
  ///
  /// Parameters:
  /// - [rows] (`List<TableRow>`, required): Table rows.
  /// - [controller] (`ResizableTableController`, required): Resize controller.
  /// - [theme] (`ResizableTableTheme?`, optional): Table theme.
  /// - [clipBehavior] (`Clip`, default: `Clip.hardEdge`): Clipping behavior.
  /// - [cellWidthResizeMode] (`TableCellResizeMode`, default: `reallocate`): Column resize mode.
  /// - [cellHeightResizeMode] (`TableCellResizeMode`, default: `expand`): Row resize mode.
  /// - [frozenCells] (`FrozenTableData?`, optional): Frozen cell configuration.
  /// - [horizontalOffset] (`double?`, optional): Horizontal scroll offset.
  /// - [verticalOffset] (`double?`, optional): Vertical scroll offset.
  /// - [viewportSize] (`Size?`, optional): Viewport size.
  const ResizableTable({super.key, required this.rows, required this.controller, this.theme, this.clipBehavior = Clip.hardEdge, this.cellWidthResizeMode = TableCellResizeMode.reallocate, this.cellHeightResizeMode = TableCellResizeMode.expand, this.frozenCells, this.horizontalOffset, this.verticalOffset, this.viewportSize});
  State<ResizableTable> createState();
}
```
