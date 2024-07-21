import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TableParentData extends ContainerBoxParentData<RenderBox> {
  int column = 0;
  int row = 0;
  int columnSpan = 1;
  int rowSpan = 1;
  AlignmentGeometry alignment = Alignment.center;
  TextDirection? textDirection;
}

class TableCell extends ParentDataWidget<TableParentData> {
  final int column;
  final int row;
  final int columnSpan;
  final int rowSpan;
  final AlignmentGeometry alignment;
  final Widget child;
  final TextDirection? textDirection;

  const TableCell({
    Key? key,
    required this.column,
    required this.row,
    this.columnSpan = 1,
    this.rowSpan = 1,
    required this.child,
    this.alignment = Alignment.center,
    this.textDirection,
  }) : super(key: key, child: child);

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as TableParentData;
    bool needsLayout = false;
    if (parentData.column != column) {
      parentData.column = column;
      needsLayout = true;
    }
    if (parentData.row != row) {
      parentData.row = row;
      needsLayout = true;
    }
    if (parentData.columnSpan != columnSpan) {
      parentData.columnSpan = columnSpan;
      needsLayout = true;
    }
    if (parentData.rowSpan != rowSpan) {
      parentData.rowSpan = rowSpan;
      needsLayout = true;
    }
    if (parentData.alignment != alignment) {
      parentData.alignment = alignment;
      needsLayout = true;
    }
    if (parentData.textDirection != textDirection) {
      parentData.textDirection = textDirection;
      needsLayout = true;
    }
    if (needsLayout) {
      final RenderObject? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => RawTable;
}

abstract class CellConstraint {
  const CellConstraint();
}

class FlexConstraint extends CellConstraint {
  final int flex;

  const FlexConstraint(this.flex);
}

class AbsoluteConstraint extends CellConstraint {
  final double size;

  const AbsoluteConstraint(this.size);
}

class IntrinsicConstraint extends CellConstraint {
  const IntrinsicConstraint();
}

class BoxedConstraint extends CellConstraint {
  final double min;
  final double max;

  const BoxedConstraint({
    required this.min,
    required this.max,
  });
}

// typedef CoordinateConstraint = CellConstraint Function(int index);

class Table extends StatelessWidget {
  final List<TableCell> cells;
  final Map<int, CellConstraint>? columnWidths;
  final Map<int, CellConstraint>? rowWidths;
  final TextDirection? textDirection;

  const Table({
    Key? key,
    required this.cells,
    this.columnWidths,
    this.rowWidths,
    this.textDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawTable(
      columnConstraints: columnWidths,
      rowConstraints: rowWidths,
      textDirection: textDirection ?? Directionality.of(context),
      children: cells,
    );
  }
}

class RawTable extends MultiChildRenderObjectWidget {
  final List<Widget> children;
  final Map<int, CellConstraint>? columnConstraints;
  final Map<int, CellConstraint>? rowConstraints;
  final TextDirection textDirection;

  const RawTable({
    Key? key,
    required this.children,
    this.columnConstraints,
    this.rowConstraints,
    required this.textDirection,
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RawTableRender(
      columnConstraints: columnConstraints,
      rowConstraints: rowConstraints,
      textDirection: textDirection,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RawTableRender renderObject) {
    bool needsRelayout = false;
    if (renderObject._columnConstraints != columnConstraints) {
      renderObject._columnConstraints = columnConstraints;
      needsRelayout = true;
    }
    if (renderObject._rowConstraints != rowConstraints) {
      renderObject._rowConstraints = rowConstraints;
      needsRelayout = true;
    }
    if (renderObject.textDirection != textDirection) {
      renderObject.textDirection = textDirection;
      needsRelayout = true;
    }
    if (needsRelayout) {
      renderObject.markNeedsLayout();
    }
  }
}

class RawTableRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, TableParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, TableParentData> {
  Map<int, CellConstraint>? _columnConstraints;
  Map<int, CellConstraint>? _rowConstraints;
  TextDirection? textDirection;

  RawTableRender({
    Map<int, CellConstraint>? columnConstraints,
    Map<int, CellConstraint>? rowConstraints,
    TextDirection? textDirection,
    List<RenderBox>? children,
  })  : _columnConstraints = columnConstraints,
        _rowConstraints = rowConstraints,
        textDirection = textDirection {
    addAll(children);
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! TableParentData) {
      child.parentData = TableParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  // @override
  // @protected
  // Size computeDryLayout(covariant BoxConstraints constraints) {
  //   double allocatedWidthSize = 0.0;
  //   double allocatedHeightSize = 0.0;
  //   RenderBox? child = firstChild;
  //   while (child != null) {
  //     final parentData = child.tableParentData;
  //   }
  //   return super.computeDryLayout(constraints);
  // } TODO: Do this later

  @override
  void performLayout() {
    int? minColumn;
    int? minRow;
    int? maxColumn;
    int? maxRow;

    RenderBox? child = firstChild;

    // 1st iteration, find out the bounds of the table
    while (child != null) {
      final parentData = child.tableParentData;
      final column = parentData.column;
      final row = parentData.row;
      final columnSpan = parentData.columnSpan;
      final rowSpan = parentData.rowSpan;

      // set up table bounds
      if (minColumn == null || column < minColumn) {
        minColumn = column;
      }
      if (minRow == null || row < minRow) {
        minRow = row;
      }
      if (maxColumn == null || column + columnSpan > maxColumn) {
        maxColumn = column + columnSpan;
      }
      if (maxRow == null || row + rowSpan > maxRow) {
        maxRow = row + rowSpan;
      }
      // by the end of this, table will have bounds of minColumn, minRow, maxColumn, maxRow
      child = parentData.nextSibling;
    }

    if (minColumn == null ||
        minRow == null ||
        maxColumn == null ||
        maxRow == null) {
      // no children, nothing to do
      size = constraints.smallest;
      return;
    }

    print('table bounds: $minColumn, $minRow, $maxColumn, $maxRow');

    // next, fetch the constraints for each column and row, default to IntrinsicConstraint
    // and then calculate the sizes of each column and row

    Map<int, _SizeConstraint> allocatedColumnSizes = {};
    Map<int, _SizeConstraint> allocatedRowSizes = {};

    double totalHorizontalFlex = 0.0; // for columns
    double totalVerticalFlex = 0.0; // for rows

    double usedWidth = 0.0;
    double usedHeight = 0.0;

    // treat intrinsic as flex(1) where they will be given remaining space equally
    int totalIntrinsicColumns = 0;
    int totalIntrinsicRows = 0;

    for (int i = minColumn; i < maxColumn; i++) {
      final constraint = _columnConstraints?[i];
      if (constraint is FlexConstraint) {
        totalHorizontalFlex += constraint.flex;
      } else if (constraint is AbsoluteConstraint) {
        // absolute constraint have tight constraints
        allocatedColumnSizes[i] =
            _SizeConstraint(min: constraint.size, max: constraint.size);
        usedWidth += constraint.size;
      } else if (constraint is BoxedConstraint) {
        allocatedColumnSizes[i] =
            _SizeConstraint(min: constraint.min, max: constraint.max);
        usedWidth += constraint.min;
      } else {
        assert(constraint == null || constraint is IntrinsicConstraint,
            'Column $i has unknown constraint');
        if (constraint == null || constraint is IntrinsicConstraint) {
          totalIntrinsicColumns++;
        }
      }
      // Intrinsics are ignored, they will be calculated later
    }

    print('non intrinsic sizes: $allocatedColumnSizes $allocatedRowSizes');
    print('current flexes: $totalHorizontalFlex $totalVerticalFlex');

    for (int i = minRow; i < maxRow; i++) {
      final constraint = _rowConstraints?[i];
      if (constraint is FlexConstraint) {
        totalVerticalFlex += constraint.flex;
      } else if (constraint is AbsoluteConstraint) {
        // absolute constraint have tight constraints
        allocatedRowSizes[i] =
            _SizeConstraint(min: constraint.size, max: constraint.size);
        usedHeight += constraint.size;
      } else if (constraint is BoxedConstraint) {
        allocatedRowSizes[i] =
            _SizeConstraint(min: constraint.min, max: constraint.max);
        usedHeight += constraint.min;
      } else {
        assert(constraint == null || constraint is IntrinsicConstraint,
            'Row $i has unknown constraint');
        if (constraint == null || constraint is IntrinsicConstraint) {
          totalIntrinsicRows++;
        }
      }
      // Intrinsics are ignored, they will be calculated later
    }

    double remainingWidth = constraints.maxWidth - usedWidth;
    double remainingHeight = constraints.maxHeight - usedHeight;

    // 2nd iteration, find out the row and column sizes that has intrinsic constraints
    // this is done by collecting cells that have span of 1
    // intrinsics later will determined by the most largest cell in the row/column
    child = firstChild;
    while (child != null) {
      final parentData = child.tableParentData;

      final column = parentData.column;
      final row = parentData.row;
      final columnSpan = parentData.columnSpan;
      final rowSpan = parentData.rowSpan;

      double minIntrinsicWidth = 0;
      double maxIntrinsicWidth = 0;
      for (int i = column; i < column + columnSpan; i++) {
        final constraint = _columnConstraints?[i];
        if (constraint is FlexConstraint) {
          minIntrinsicWidth = double.infinity;
          maxIntrinsicWidth = double.infinity;
          break;
        } else if (constraint is AbsoluteConstraint) {
          minIntrinsicWidth += constraint.size;
          maxIntrinsicWidth += constraint.size;
        } else if (constraint is BoxedConstraint) {
          minIntrinsicWidth += constraint.min;
          maxIntrinsicWidth += constraint.max;
        } else {
          assert(constraint == null || constraint is IntrinsicConstraint,
              'Column $i has unknown constraint');
          if (constraint == null || constraint is IntrinsicConstraint) {
            minIntrinsicWidth += child
                .getMinIntrinsicWidth(remainingWidth / totalIntrinsicColumns);
            maxIntrinsicWidth += child
                .getMaxIntrinsicWidth(remainingWidth / totalIntrinsicColumns);
          }
        }
      }
      minIntrinsicWidth = minIntrinsicWidth / columnSpan;
      maxIntrinsicWidth = maxIntrinsicWidth / columnSpan;
      for (int i = column; i < column + columnSpan; i++) {
        final currentAllocation = allocatedColumnSizes[i];
        if (currentAllocation == null) {
          allocatedColumnSizes[i] = _IntrinsicConstraint(
            min: minIntrinsicWidth,
            max: maxIntrinsicWidth,
          );
        } else {
          allocatedColumnSizes[i] = _IntrinsicConstraint(
            min: max(currentAllocation.min, minIntrinsicWidth),
            max: max(currentAllocation.max, maxIntrinsicWidth),
          );
        }
      }

      double minIntrinsicHeight = 0;
      double maxIntrinsicHeight = 0;
      for (int i = row; i < row + rowSpan; i++) {
        final constraint = _rowConstraints?[i];
        if (constraint is FlexConstraint) {
          minIntrinsicHeight = double.infinity;
          maxIntrinsicHeight = double.infinity;
          break;
        } else if (constraint is AbsoluteConstraint) {
          minIntrinsicHeight += constraint.size;
          maxIntrinsicHeight += constraint.size;
        } else if (constraint is BoxedConstraint) {
          minIntrinsicHeight += constraint.min;
          maxIntrinsicHeight += constraint.max;
        } else {
          assert(constraint == null || constraint is IntrinsicConstraint,
              'Row $i has unknown constraint');
          if (constraint == null || constraint is IntrinsicConstraint) {
            minIntrinsicHeight += child
                .getMinIntrinsicHeight(remainingHeight / totalIntrinsicRows);
            maxIntrinsicHeight += child
                .getMaxIntrinsicHeight(remainingHeight / totalIntrinsicRows);
          }
        }
      }
      minIntrinsicHeight = minIntrinsicHeight / rowSpan;
      maxIntrinsicHeight = maxIntrinsicHeight / rowSpan;
      for (int i = row; i < row + rowSpan; i++) {
        final currentAllocation = allocatedRowSizes[i];
        if (currentAllocation == null) {
          allocatedRowSizes[i] = _IntrinsicConstraint(
            min: minIntrinsicHeight,
            max: maxIntrinsicHeight,
          );
        } else {
          allocatedRowSizes[i] = _IntrinsicConstraint(
            min: max(currentAllocation.min, minIntrinsicHeight),
            max: max(currentAllocation.max, maxIntrinsicHeight),
          );
        }
      }

      child = parentData.nextSibling;
    }

    usedWidth = 0;
    usedHeight = 0;
    for (int i = minColumn; i < maxColumn; i++) {
      final columnSize = allocatedColumnSizes[i] ?? _SizeConstraint.zero;
      usedWidth += columnSize.max;
    }
    for (int i = minRow; i < maxRow; i++) {
      final rowSize = allocatedRowSizes[i] ?? _SizeConstraint.zero;
      usedHeight += rowSize.max;
    }
    remainingWidth = constraints.maxWidth - usedWidth;
    remainingHeight = constraints.maxHeight - usedHeight;

    // we have final remaining, now we use them for our flex constraints
    double widthPerFlex = remainingWidth / totalHorizontalFlex;
    double heightPerFlex = remainingHeight / totalVerticalFlex;

    for (int i = minColumn; i < maxColumn; i++) {
      final constraint = _columnConstraints?[i];
      if (constraint is FlexConstraint) {
        allocatedColumnSizes[i] = _SizeConstraint(
          min: widthPerFlex * constraint.flex,
          max: widthPerFlex * constraint.flex,
        );
      }
    }

    for (int i = minRow; i < maxRow; i++) {
      final constraint = _rowConstraints?[i];
      if (constraint is FlexConstraint) {
        allocatedRowSizes[i] = _SizeConstraint(
          min: heightPerFlex * constraint.flex,
          max: heightPerFlex * constraint.flex,
        );
      }
    }

    // at this point, we have all the sizes for each column and row
    // some children with intrinsic constraints might have been laid out if they have span of 1
    // some are not, we need to lay them out now

    double totalTableWidth = 0.0;
    double totalTableHeight = 0.0;

    for (int i = minColumn; i < maxColumn; i++) {
      final columnSize = allocatedColumnSizes[i] ?? _SizeConstraint.zero;
      totalTableWidth += columnSize!.max;
    }

    for (int i = minRow; i < maxRow; i++) {
      final rowSize = allocatedRowSizes[i] ?? _SizeConstraint.zero;
      totalTableHeight += rowSize!.max;
    }

    child = firstChild;
    while (child != null) {
      final parentData = child.tableParentData;

      final column = parentData.column;
      final row = parentData.row;
      final columnSpan = parentData.columnSpan;
      final rowSpan = parentData.rowSpan;

      double minWidth = 0;
      double maxWidth = 0;
      double minHeight = 0;
      double maxHeight = 0;

      // cell with span more than 1 is not affected by the min constraint
      if (columnSpan == 1) {
        final columnSize = allocatedColumnSizes[column] ?? _SizeConstraint.zero;
        minWidth = columnSize.min;
        maxWidth = columnSize.max;
      } else {
        // cell with span more than 1 will have max width of the sum of the columns
        for (int i = column; i < column + columnSpan; i++) {
          final columnSize = allocatedColumnSizes[i] ?? _SizeConstraint.zero;
          // should we check if the column has been laid out?
          // NO NEED! if the column has been laid out, it will only 1 column span
          minWidth = minWidth + columnSize.min;
          maxWidth = maxWidth + columnSize.max;
        }
      }

      if (rowSpan == 1) {
        final rowSize = allocatedRowSizes[row] ?? _SizeConstraint.zero;
        minHeight = rowSize.min;
        maxHeight = rowSize.max;
      } else {
        // cell with span more than 1 will have max height of the sum of the rows
        for (int i = row; i < row + rowSpan; i++) {
          final rowSize = allocatedRowSizes[i] ?? _SizeConstraint.zero;
          minHeight = minHeight + rowSize.min;
          maxHeight = maxHeight + rowSize.max;
        }
      }

      child.layout(BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
      ));

      double columnOffset = 0;
      double rowOffset = 0;
      for (int i = minColumn; i < column; i++) {
        final columnSize = allocatedColumnSizes[i] ?? _SizeConstraint.zero;
        columnOffset += columnSize.max;
      }
      for (int i = minRow; i < row; i++) {
        final rowSize = allocatedRowSizes[i] ?? _SizeConstraint.zero;
        rowOffset += rowSize!.max;
      }
      parentData.offset = Offset(columnOffset, rowOffset);

      child = parentData.nextSibling;
    }

    size = constraints.constrain(Size(totalTableWidth, totalTableHeight));
  }

  // _TableBounds? _computeBounds() {
  //   int? minColumn;
  //   int? minRow;
  //   int? maxColumn;
  //   int? maxRow;
  //
  //   RenderBox? child = firstChild;
  //   List<List<RenderBox?>> cells = [];
  //
  //   void _put(int col, int row, RenderBox box) {
  //     while (cells.length <= row) {
  //       cells.add(List.filled(maxColumn! + 1, null));
  //     }
  //     List<RenderBox?> rowCells = cells[row];
  //     while (rowCells.length <= col) {
  //       rowCells.add(null);
  //     }
  //     rowCells[col] = box;
  //   }
  //
  //   while (child != null) {
  //     final parentData = child.tableParentData;
  //     final column = parentData.column;
  //     final row = parentData.row;
  //     final columnSpan = parentData.columnSpan;
  //     final rowSpan = parentData.rowSpan;
  //
  //     if (minColumn == null || column < minColumn) {
  //       minColumn = column;
  //     }
  //     if (minRow == null || row < minRow) {
  //       minRow = row;
  //     }
  //     if (maxColumn == null || column + columnSpan > maxColumn) {
  //       maxColumn = column + columnSpan;
  //     }
  //     if (maxRow == null || row + rowSpan > maxRow) {
  //       maxRow = row + rowSpan;
  //     }
  //
  //     for (int i = column; i < column + columnSpan; i++) {
  //       for (int j = row; j < row + rowSpan; j++) {
  //         _put(i, j, child);
  //       }
  //     }
  //
  //     child = parentData.nextSibling;
  //   }
  //
  //   if (minColumn == null ||
  //       minRow == null ||
  //       maxColumn == null ||
  //       maxRow == null) {
  //     return null;
  //   }
  //
  //   return _TableBounds(
  //     minColumn: minColumn,
  //     minRow: minRow,
  //     maxColumn: maxColumn,
  //     maxRow: maxRow,
  //   );
  // }
  //
  // _TableLayoutSizes _computeSizes(BoxConstraints constraints,
  //     ChildLayouter layoutChild, _TableBounds bounds) {
  //   // Map<int, double> columnSizes = {};
  //   // Map<int, double> rowSizes = {};
  //
  //   double totalHorizontalFlex = 0.0;
  //   double totalVerticalFlex = 0.0;
  //
  //   Map<int, _SizeConstraint> columnSizes = {};
  //   Map<int, _SizeConstraint> rowSizes = {};
  //
  //   for (int col = bounds.minColumn; col < bounds.maxColumn; col++) {
  //     final constraint = _columnConstraints?[col];
  //     if (constraint is FlexConstraint) {
  //       totalHorizontalFlex += constraint.flex;
  //     } else if (constraint is AbsoluteConstraint) {
  //       columnSizes[col] =
  //           _SizeConstraint(min: constraint.size, max: constraint.size);
  //     } else if (constraint is BoxedConstraint) {
  //       columnSizes[col] =
  //           _SizeConstraint(min: constraint.min, max: constraint.max);
  //     } else if (constraint == null || constraint is IntrinsicConstraint) {
  //       columnSizes[col] = const _IntrinsicConstraint(min: 0, max: 0);
  //     }
  //   }
  //
  //   for (int row = bounds.minRow; row < bounds.maxRow; row++) {
  //     final constraint = _rowConstraints?[row];
  //     if (constraint is FlexConstraint) {
  //       totalVerticalFlex += constraint.flex;
  //     } else if (constraint is AbsoluteConstraint) {
  //       rowSizes[row] =
  //           _SizeConstraint(min: constraint.size, max: constraint.size);
  //     } else if (constraint is BoxedConstraint) {
  //       rowSizes[row] =
  //           _SizeConstraint(min: constraint.min, max: constraint.max);
  //     } else if (constraint == null || constraint is IntrinsicConstraint) {
  //       rowSizes[row] = const _IntrinsicConstraint(min: 0, max: 0);
  //     }
  //   }
  //
  //   RenderBox? child = firstChild;
  //   while (child != null) {
  //     final parentData = child.tableParentData;
  //
  //     final column = parentData.column;
  //     final row = parentData.row;
  //     final columnSpan = parentData.columnSpan;
  //     final rowSpan = parentData.rowSpan;
  //
  //     // handle the intrinsic constraints for span = 1 first
  //     if (columnSpan == 1) {
  //       final constraint = _columnConstraints?[column];
  //       if (constraint is IntrinsicConstraint) {
  //         final rowSize = rowSizes[row]!;
  //         final minIntrinsicWidth = child.getMinIntrinsicWidth(rowSize.max);
  //         final maxIntrinsicWidth = child.getMaxIntrinsicWidth(rowSize.max);
  //         columnSizes[column] = _IntrinsicConstraint(
  //           min: max(columnSizes[column]!.min, minIntrinsicWidth),
  //           max: max(columnSizes[column]!.max, maxIntrinsicWidth),
  //         );
  //       }
  //     }
  //
  //     if (rowSpan == 1) {
  //       final constraint = _rowConstraints?[row];
  //       if (constraint is IntrinsicConstraint) {
  //         final columnSize = columnSizes[column]!;
  //         final minIntrinsicHeight =
  //             child.getMinIntrinsicHeight(columnSize.max);
  //         final maxIntrinsicHeight =
  //             child.getMaxIntrinsicHeight(columnSize.max);
  //         rowSizes[row] = _IntrinsicConstraint(
  //           min: max(rowSizes[row]!.min, minIntrinsicHeight),
  //           max: max(rowSizes[row]!.max, maxIntrinsicHeight),
  //         );
  //       }
  //     }
  //
  //     child = parentData.nextSibling;
  //   }
  //
  //   child = firstChild;
  //   while (child != null) {
  //     final parentData = child.tableParentData;
  //
  //     final column = parentData.column;
  //     final row = parentData.row;
  //     final columnSpan = parentData.columnSpan;
  //     final rowSpan = parentData.rowSpan;
  //
  //     if (columnSpan > 1) {
  //       final constraint = _columnConstraints?[column];
  //     }
  //
  //     child = parentData.nextSibling;
  //   }
  //
  //   double nonFlexWidth = 0.0;
  //   double nonFlexHeight = 0.0;
  //
  //   for (int col = bounds.minColumn; col < bounds.maxColumn; col++) {
  //     final columnSize = columnSizes[col]!;
  //     nonFlexWidth += columnSize.max;
  //   }
  //
  //   for (int row = bounds.minRow; row < bounds.maxRow; row++) {
  //     final rowSize = rowSizes[row]!;
  //     nonFlexHeight += rowSize.max;
  //   }
  //
  //   return _TableLayoutSizes(
  //     columnSizes: columnSizes,
  //     rowSizes: rowSizes,
  //   );
  // }
}

class _SizeConstraint {
  static const _SizeConstraint zero = _SizeConstraint(min: 0, max: 0);
  final double min;
  final double max;

  const _SizeConstraint({
    required this.min,
    required this.max,
  });

  double constrain(double value) {
    return value.clamp(min, max);
  }

  @override
  String toString() {
    return 'SizeConstraint($min, $max)';
  }
}

class _IntrinsicConstraint extends _SizeConstraint {
  const _IntrinsicConstraint({
    required super.min,
    required super.max,
  });

  @override
  String toString() {
    return 'IntrinsicConstraint(${this.min}, ${this.max})';
  }
}

extension _TableRenderBoxExtension on RenderBox {
  TableParentData get tableParentData => parentData as TableParentData;
}

class _TableBounds {
  final int minColumn;
  final int minRow;
  final int maxColumn;
  final int maxRow;
  final List<List<RenderBox>> cells;

  _TableBounds({
    required this.minColumn,
    required this.minRow,
    required this.maxColumn,
    required this.maxRow,
    required this.cells,
  });
}

class _TableLayoutSizes {
  final Map<int, double> columnSizes;
  final Map<int, double> rowSizes;
  final double totalWidth;
  final double totalHeight;

  _TableLayoutSizes({
    required this.columnSizes,
    required this.rowSizes,
    required this.totalWidth,
    required this.totalHeight,
  });
}
