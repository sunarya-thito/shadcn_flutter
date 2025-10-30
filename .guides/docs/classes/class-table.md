---
title: "Class: Table"
description: "A flexible table widget with support for spanning, scrolling, and interactive features."
---

```dart
/// A flexible table widget with support for spanning, scrolling, and interactive features.
///
/// [Table] provides a comprehensive table component with advanced layout capabilities
/// including cell spanning, flexible sizing, frozen cells, scrolling, and rich theming.
/// It supports both simple data tables and complex layouts with header/footer rows.
///
/// ## Key Features
/// - **Cell Spanning**: Support for colspan and rowspan across multiple cells
/// - **Flexible Sizing**: Multiple sizing strategies (fixed, flex, intrinsic) for columns/rows
/// - **Frozen Cells**: Ability to freeze specific cells during scrolling
/// - **Interactive States**: Hover effects and selection states with visual feedback
/// - **Scrolling**: Optional horizontal and vertical scrolling with viewport control
/// - **Theming**: Comprehensive theming system for visual customization
///
/// ## Layout System
/// The table uses a sophisticated layout system that handles:
/// - Variable column widths via [TableSize] strategies
/// - Dynamic row heights based on content
/// - Complex cell spanning calculations
/// - Efficient rendering with viewport culling
///
/// ## Sizing Strategies
/// - [FlexTableSize]: Proportional sizing like CSS flex
/// - [FixedTableSize]: Absolute pixel sizes
/// - [IntrinsicTableSize]: Size based on content
///
/// Example:
/// ```dart
/// Table(
///   rows: [
///     TableHeader(cells: [
///       TableCell(child: Text('Name')),
///       TableCell(child: Text('Age')),
///       TableCell(child: Text('City')),
///     ]),
///     TableRow(cells: [
///       TableCell(child: Text('John Doe')),
///       TableCell(child: Text('25')),
///       TableCell(child: Text('New York')),
///     ]),
///   ],
///   columnWidths: {
///     0: FlexTableSize(flex: 2),
///     1: FixedTableSize(width: 80),
///     2: FlexTableSize(flex: 1),
///   },
/// );
/// ```
class Table extends StatefulWidget {
  /// List of rows to display in the table.
  ///
  /// Type: `List<TableRow>`. Contains the table data organized as rows.
  /// Can include [TableRow], [TableHeader], and [TableFooter] instances.
  /// Each row contains a list of [TableCell] widgets.
  final List<TableRow> rows;
  /// Default sizing strategy for all columns.
  ///
  /// Type: `TableSize`. Used when no specific width is provided in
  /// [columnWidths]. Defaults to [FlexTableSize] for proportional sizing.
  final TableSize defaultColumnWidth;
  /// Default sizing strategy for all rows.
  ///
  /// Type: `TableSize`. Used when no specific height is provided in
  /// [rowHeights]. Defaults to [IntrinsicTableSize] for content-based sizing.
  final TableSize defaultRowHeight;
  /// Specific column width overrides.
  ///
  /// Type: `Map<int, TableSize>?`. Maps column indices to specific sizing
  /// strategies. Overrides [defaultColumnWidth] for specified columns.
  final Map<int, TableSize>? columnWidths;
  /// Specific row height overrides.
  ///
  /// Type: `Map<int, TableSize>?`. Maps row indices to specific sizing
  /// strategies. Overrides [defaultRowHeight] for specified rows.
  final Map<int, TableSize>? rowHeights;
  /// Clipping behavior for the table content.
  ///
  /// Type: `Clip`. Controls how content is clipped at table boundaries.
  /// Defaults to [Clip.hardEdge] for clean boundaries.
  final Clip clipBehavior;
  /// Theme configuration for the table appearance.
  ///
  /// Type: `TableTheme?`. Controls borders, colors, and overall styling.
  /// If null, uses the default theme from [ComponentTheme].
  final TableTheme? theme;
  /// Configuration for frozen cells during scrolling.
  ///
  /// Type: `FrozenTableData?`. Specifies which cells remain visible
  /// during horizontal or vertical scrolling. Useful for headers/footers.
  final FrozenTableData? frozenCells;
  /// Horizontal scroll offset for the table viewport.
  ///
  /// Type: `double?`. Controls horizontal scrolling position. If provided,
  /// the table displays within a scrollable viewport.
  final double? horizontalOffset;
  /// Vertical scroll offset for the table viewport.
  ///
  /// Type: `double?`. Controls vertical scrolling position. If provided,
  /// the table displays within a scrollable viewport.
  final double? verticalOffset;
  /// Size constraints for the table viewport.
  ///
  /// Type: `Size?`. When provided with scroll offsets, constrains the
  /// visible area of the table. Essential for scrolling behavior.
  final Size? viewportSize;
  /// Creates a [Table] widget.
  ///
  /// The table displays data organized in rows and cells with flexible
  /// sizing and interactive features.
  ///
  /// Parameters:
  /// - [rows] (`List<TableRow>`, required): Table data organized as rows
  /// - [defaultColumnWidth] (TableSize, default: FlexTableSize()): Default column sizing
  /// - [defaultRowHeight] (TableSize, default: IntrinsicTableSize()): Default row sizing
  /// - [columnWidths] (`Map<int, TableSize>?`, optional): Column-specific sizes
  /// - [rowHeights] (`Map<int, TableSize>?`, optional): Row-specific sizes
  /// - [clipBehavior] (Clip, default: Clip.hardEdge): Content clipping behavior
  /// - [theme] (TableTheme?, optional): Visual styling configuration
  /// - [frozenCells] (FrozenTableData?, optional): Frozen cell configuration
  /// - [horizontalOffset] (double?, optional): Horizontal scroll position
  /// - [verticalOffset] (double?, optional): Vertical scroll position
  /// - [viewportSize] (Size?, optional): Viewport size constraints
  ///
  /// Example:
  /// ```dart
  /// Table(
  ///   rows: [
  ///     TableHeader(cells: [TableCell(child: Text('Header'))]),
  ///     TableRow(cells: [TableCell(child: Text('Data'))]),
  ///   ],
  ///   columnWidths: {0: FixedTableSize(width: 200)},
  /// );
  /// ```
  const Table({super.key, required this.rows, this.defaultColumnWidth = const FlexTableSize(), this.defaultRowHeight = const IntrinsicTableSize(), this.columnWidths, this.rowHeights, this.clipBehavior = Clip.hardEdge, this.theme, this.frozenCells, this.horizontalOffset, this.verticalOffset, this.viewportSize});
  State<Table> createState();
}
```
