---
title: "Class: RawTableLayout"
description: "Low-level table layout widget."
---

```dart
/// Low-level table layout widget.
///
/// Provides raw table layout functionality with support for frozen rows/columns
/// and scrolling. Used internally by higher-level table widgets.
///
/// Example:
/// ```dart
/// RawTableLayout(
///   width: (index) => FlexTableSize(),
///   height: (index) => FixedTableSize(50),
///   clipBehavior: Clip.hardEdge,
///   children: [...],
/// )
/// ```
class RawTableLayout extends MultiChildRenderObjectWidget {
  /// Creates a [RawTableLayout].
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, optional): Table cell widgets.
  /// - [width] (`TableSizeSupplier`, required): Column width supplier.
  /// - [height] (`TableSizeSupplier`, required): Row height supplier.
  /// - [clipBehavior] (`Clip`, required): Content clipping behavior.
  /// - [frozenColumn] (`CellPredicate?`, optional): Frozen column predicate.
  /// - [frozenRow] (`CellPredicate?`, optional): Frozen row predicate.
  /// - [verticalOffset] (`double?`, optional): Vertical scroll offset.
  /// - [horizontalOffset] (`double?`, optional): Horizontal scroll offset.
  /// - [viewportSize] (`Size?`, optional): Viewport size for scrolling.
  const RawTableLayout({super.key, super.children, required this.width, required this.height, required this.clipBehavior, this.frozenColumn, this.frozenRow, this.verticalOffset, this.horizontalOffset, this.viewportSize});
  /// Supplier function for column widths.
  final TableSizeSupplier width;
  /// Supplier function for row heights.
  final TableSizeSupplier height;
  /// How content should be clipped.
  final Clip clipBehavior;
  /// Predicate for determining frozen columns.
  final CellPredicate? frozenColumn;
  /// Predicate for determining frozen rows.
  final CellPredicate? frozenRow;
  /// Vertical scroll offset.
  final double? verticalOffset;
  /// Horizontal scroll offset.
  final double? horizontalOffset;
  /// Size of the visible viewport.
  final Size? viewportSize;
  RenderTableLayout createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderTableLayout renderObject);
}
```
