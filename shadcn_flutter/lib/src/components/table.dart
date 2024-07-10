import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class TableParentData extends ContainerBoxParentData<RenderBox> {
  int? col;
  int? row;
  int? colSpan;
  int? rowSpan;
  double? colFlex;
  double? rowFlex;
}

class TableItem extends ParentDataWidget {
  final int col;
  final int row;
  final int? colSpan;
  final int? rowSpan;
  final double colFlex;
  final double rowFlex;

  const TableItem({
    super.key,
    required this.col,
    required this.row,
    required super.child,
    this.colSpan,
    this.rowSpan,
    this.colFlex = 1,
    this.rowFlex = 1,
  });

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is TableParentData);
    final parentData = renderObject.parentData as TableParentData;
    bool needsLayout = false;

    if (parentData.col != col) {
      parentData.col = col;
      needsLayout = true;
    }

    if (parentData.row != row) {
      parentData.row = row;
      needsLayout = true;
    }

    if (parentData.colSpan != colSpan) {
      parentData.colSpan = colSpan;
      needsLayout = true;
    }

    if (parentData.rowSpan != rowSpan) {
      parentData.rowSpan = rowSpan;
      needsLayout = true;
    }

    if (parentData.colFlex != colFlex) {
      parentData.colFlex = colFlex;
      needsLayout = true;
    }

    if (parentData.rowFlex != rowFlex) {
      parentData.rowFlex = rowFlex;
      needsLayout = true;
    }

    if (needsLayout) {
      final targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => TableLayout;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('col', col));
    properties.add(IntProperty('row', row));
    properties.add(IntProperty('colSpan', colSpan));
    properties.add(IntProperty('rowSpan', rowSpan));
    properties.add(DoubleProperty('colFlex', colFlex));
    properties.add(DoubleProperty('rowFlex', rowFlex));
  }
}

class TableLayout extends MultiChildRenderObjectWidget {
  TableLayout({
    super.key,
    required List<Widget> children,
  }) : super(children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderTableLayout();
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderTableLayout renderObject) {}
}

typedef _ChildSizingFunction = double Function(RenderBox child, double extent);

class TableLayoutCell {
  final RenderBox child;
  final double widthFraction;
  final double heightFraction;

  TableLayoutCell({
    required this.child,
    required this.widthFraction,
    required this.heightFraction,
  });
}

class RenderTableLayout extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, TableParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, TableParentData> {
  RenderTableLayout({
    List<RenderBox>? children,
  }) {
    addAll(children);
  }

  /// Map<row, Map<col, RenderObject>>
  Map<int, Map<int, TableLayoutCell>> groupColumnChildren() {
    final result = <int, Map<int, TableLayoutCell>>{};
    void putInto(int col, int row, TableLayoutCell child) {
      if (!result.containsKey(row)) {
        result[row] = {};
      }
      result[row]![col] = child;
    }

    RenderBox? child = firstChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      final col = parentData.col!;
      final row = parentData.row!;
      final colSpan = parentData.colSpan ?? 1;
      final rowSpan = parentData.rowSpan ?? 1;
      for (var i = 0; i < rowSpan; i++) {
        for (var j = 0; j < colSpan; j++) {
          putInto(
              col + j,
              row + i,
              TableLayoutCell(
                child: child,
                widthFraction: 1 / colSpan,
                heightFraction: 1 / rowSpan,
              ));
        }
      }
      child = parentData.nextSibling;
    }
    return result;
  }

  ///Map<col, Map<row, RenderObject>>
  Map<int, Map<int, TableLayoutCell>> groupRowChildren() {
    final result = <int, Map<int, TableLayoutCell>>{};
    void putInto(int col, int row, TableLayoutCell child) {
      if (!result.containsKey(col)) {
        result[col] = {};
      }
      result[col]![row] = child;
    }

    RenderBox? child = firstChild;
    while (child != null) {
      final parentData = child.parentData as TableParentData;
      final col = parentData.col!;
      final row = parentData.row!;
      final colSpan = parentData.colSpan ?? 1;
      final rowSpan = parentData.rowSpan ?? 1;
      for (var i = 0; i < rowSpan; i++) {
        for (var j = 0; j < colSpan; j++) {
          putInto(
              col + j,
              row + i,
              TableLayoutCell(
                child: child,
                widthFraction: 1 / colSpan,
                heightFraction: 1 / rowSpan,
              ));
        }
      }
      child = parentData.nextSibling;
    }
    return result;
  }

  double _getIntrinsicSize(
      {required Iterable<TableLayoutCell> children,
      required _ChildSizingFunction sizingFunction,
      required Axis sizingDirection,
      required double extent}) {
    double totalFlex = 0;
    double inflexibleSpace = 0;
    double maxFlexFraction = 0;
    for (final child in children) {
      final renderBox = child.child;
      final parentData = renderBox.parentData as TableParentData;
      var flex = sizingDirection == Axis.horizontal
          ? parentData.colFlex!
          : parentData.rowFlex!;
      totalFlex += flex;
      if (flex > 0) {
        final double flexFraction = sizingFunction(renderBox, extent) / flex;
        maxFlexFraction = max(maxFlexFraction, flexFraction);
      } else {
        inflexibleSpace += sizingFunction(renderBox, extent);
      }
    }
    return maxFlexFraction * totalFlex + inflexibleSpace;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    Map<int, Map<int, TableLayoutCell>> children = groupColumnChildren();
    double height = 0;
    // sum up the intrinsic height of each row
    for (final row in children.values) {
      height += _getIntrinsicSize(
        children: row.values,
        sizingFunction: (child, extent) => child.getMinIntrinsicHeight(extent),
        sizingDirection: Axis.vertical,
        extent: width,
      );
    }
    return height;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    Map<int, Map<int, TableLayoutCell>> children = groupRowChildren();
    double width = 0;
    // sum up the intrinsic width of each column
    for (final col in children.values) {
      width += _getIntrinsicSize(
        children: col.values,
        sizingFunction: (child, extent) => child.getMinIntrinsicWidth(extent),
        sizingDirection: Axis.horizontal,
        extent: height,
      );
    }
    return width;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    Map<int, Map<int, TableLayoutCell>> children = groupColumnChildren();
    double height = 0;
    // sum up the intrinsic height of each row
    for (final row in children.values) {
      height += _getIntrinsicSize(
        children: row.values,
        sizingFunction: (child, extent) => child.getMaxIntrinsicHeight(extent),
        sizingDirection: Axis.vertical,
        extent: width,
      );
    }
    return height;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    Map<int, Map<int, TableLayoutCell>> children = groupRowChildren();
    double width = 0;
    // sum up the intrinsic width of each column
    for (final col in children.values) {
      width += _getIntrinsicSize(
        children: col.values,
        sizingFunction: (child, extent) => child.getMaxIntrinsicWidth(extent),
        sizingDirection: Axis.horizontal,
        extent: height,
      );
    }
    return width;
  }

  @override
  void performLayout() {
    final constraints = this.constraints;
    final children = groupColumnChildren();
  }
}

class _LayoutSizes {
  final double width;
  final double height;
  final double allocatedWidth;
  final double allocatedHeight;

  _LayoutSizes({
    required this.width,
    required this.height,
    required this.allocatedWidth,
    required this.allocatedHeight,
  });
}
