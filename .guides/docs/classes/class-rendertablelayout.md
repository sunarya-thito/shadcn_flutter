---
title: "Class: RenderTableLayout"
description: "Custom render object for laying out table cells with advanced features."
---

```dart
/// Custom render object for laying out table cells with advanced features.
///
/// Provides a sophisticated table layout system with support for:
/// - Flexible and fixed column widths and row heights
/// - Frozen columns and rows (sticky headers/footers)
/// - Viewport-based scrolling and clipping
/// -Span cells (cells that span multiple columns/rows)
/// - Dynamic sizing based on content or constraints
///
/// This render object handles the complex layout calculations needed for
/// tables with variable-sized cells, scrolling, and frozen regions.
///
/// See also:
/// - [TableSize], which defines sizing strategies for columns and rows
/// - [TableLayoutResult], which contains the computed layout dimensions
class RenderTableLayout extends RenderBox with ContainerRenderObjectMixin<RenderBox, TableParentData>, RenderBoxContainerDefaultsMixin<RenderBox, TableParentData> {
  /// Creates a render object for table layout.
  ///
  /// Initializes the table layout system with sizing functions and optional
  /// frozen cell configurations. This render object handles the complex
  /// layout calculations for tables with variable cell sizes.
  ///
  /// Parameters:
  /// - [children] (`List<RenderBox>?`): Optional initial child render boxes
  /// - [width] (TableSizeSupplier, required): Function providing width for each column
  /// - [height] (TableSizeSupplier, required): Function providing height for each row
  /// - [clipBehavior] (Clip, required): How to clip children outside table bounds
  /// - [frozenCell] (CellPredicate?): Predicate identifying frozen columns
  /// - [frozenRow] (CellPredicate?): Predicate identifying frozen rows
  /// - [verticalOffset] (double?): Vertical scroll offset for viewport
  /// - [horizontalOffset] (double?): Horizontal scroll offset for viewport
  /// - [viewportSize] (Size?): Size of the visible viewport area
  ///
  /// Frozen cells remain visible during scrolling, useful for sticky headers.
  RenderTableLayout({List<RenderBox>? children, required TableSizeSupplier width, required TableSizeSupplier height, required Clip clipBehavior, CellPredicate? frozenCell, CellPredicate? frozenRow, double? verticalOffset, double? horizontalOffset, Size? viewportSize});
  void setupParentData(RenderObject child);
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
  double computeMinIntrinsicWidth(double height);
  Size computeDryLayout(BoxConstraints constraints);
  void paint(PaintingContext context, Offset offset);
  void performLayout();
  /// Computes the table layout with specified constraints.
  ///
  /// Performs the complex table layout algorithm that:
  /// 1. Determines maximum row and column counts from child cells
  /// 2. Calculates fixed and flexible sizing for all columns and rows
  /// 3. Distributes available space among flex items
  /// 4. Handles both tight and loose flex constraints
  /// 5. Computes final dimensions for each column and row
  ///
  /// The layout algorithm respects size constraints from [TableSize] objects
  /// and ensures cells spanning multiple columns/rows are properly handled.
  ///
  /// Parameters:
  /// - [constraints] (BoxConstraints, required): Layout constraints for the table
  /// - [intrinsicComputer] (IntrinsicComputer?): Optional function to compute intrinsic sizes
  ///
  /// Returns [TableLayoutResult] containing computed dimensions and layout metadata.
  TableLayoutResult computeTableSize(BoxConstraints constraints, [IntrinsicComputer? intrinsicComputer]);
  double computeMaxIntrinsicWidth(double height);
  double computeMinIntrinsicHeight(double width);
  double computeMaxIntrinsicHeight(double width);
  /// Gets an unmodifiable list of computed column widths.
  ///
  /// Returns the width of each column after layout calculation. The list
  /// index corresponds to the column index, and the value is the width in
  /// logical pixels.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns an unmodifiable `List<double>` of column widths.
  List<double> get columnWidths;
  /// Gets an unmodifiable list of computed row heights.
  ///
  /// Returns the height of each row after layout calculation. The list
  /// index corresponds to the row index, and the value is the height in
  /// logical pixels.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns an unmodifiable `List<double>` of row heights.
  List<double> get rowHeights;
  /// Gets the top-left offset of a cell at the specified position.
  ///
  /// Calculates the cumulative offset by summing the widths of all columns
  /// before the specified column and heights of all rows before the specified row.
  ///
  /// Parameters:
  /// - [column] (int, required): Zero-based column index
  /// - [row] (int, required): Zero-based row index
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns [Offset] representing the cell's top-left corner position.
  Offset getOffset(int column, int row);
  /// Gets the remaining unclaimed width in the table layout.
  ///
  /// This represents horizontal space not allocated to any column after
  /// fixed and flex sizing calculations. Useful for understanding how much
  /// space is available for expansion or debugging layout issues.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining width in logical pixels as a double.
  double get remainingWidth;
  /// Gets the remaining unclaimed height in the table layout.
  ///
  /// This represents vertical space not allocated to any row after
  /// fixed and flex sizing calculations. Useful for understanding how much
  /// space is available for expansion or debugging layout issues.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining height in logical pixels as a double.
  double get remainingHeight;
  /// Gets the remaining loose (flexible) width available for loose flex items.
  ///
  /// Loose flex items can shrink below their flex allocation. This getter
  /// returns the remaining width available specifically for items with
  /// loose flex constraints (FlexFit.loose).
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining loose width in logical pixels as a double.
  double get remainingLooseWidth;
  /// Gets the remaining loose (flexible) height available for loose flex items.
  ///
  /// Loose flex items can shrink below their flex allocation. This getter
  /// returns the remaining height available specifically for items with
  /// loose flex constraints (FlexFit.loose).
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns remaining loose height in logical pixels as a double.
  double get remainingLooseHeight;
  /// Indicates whether any column uses tight flex sizing.
  ///
  /// Tight flex items must occupy their full flex allocation. This getter
  /// returns true if at least one column has a tight flex constraint
  /// (FlexFit.tight), which affects how remaining space is distributed.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns true if table has tight flex width columns, false otherwise.
  bool get hasTightFlexWidth;
  /// Indicates whether any row uses tight flex sizing.
  ///
  /// Tight flex items must occupy their full flex allocation. This getter
  /// returns true if at least one row has a tight flex constraint
  /// (FlexFit.tight), which affects how remaining space is distributed.
  ///
  /// Throws [AssertionError] if called before layout is complete.
  ///
  /// Returns true if table has tight flex height rows, false otherwise.
  bool get hasTightFlexHeight;
}
```
