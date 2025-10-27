---
title: "Class: RenderTableLayout"
description: "Reference for RenderTableLayout"
---

```dart
class RenderTableLayout extends RenderBox with ContainerRenderObjectMixin<RenderBox, TableParentData>, RenderBoxContainerDefaultsMixin<RenderBox, TableParentData> {
  RenderTableLayout({List<RenderBox>? children, required TableSizeSupplier width, required TableSizeSupplier height, required Clip clipBehavior, CellPredicate? frozenCell, CellPredicate? frozenRow, double? verticalOffset, double? horizontalOffset, Size? viewportSize});
  void setupParentData(RenderObject child);
  bool hitTestChildren(BoxHitTestResult result, {required Offset position});
  double computeMinIntrinsicWidth(double height);
  Size computeDryLayout(BoxConstraints constraints);
  void paint(PaintingContext context, Offset offset);
  void performLayout();
  TableLayoutResult computeTableSize(BoxConstraints constraints, [IntrinsicComputer? intrinsicComputer]);
  double computeMaxIntrinsicWidth(double height);
  double computeMinIntrinsicHeight(double width);
  double computeMaxIntrinsicHeight(double width);
  List<double> get columnWidths;
  List<double> get rowHeights;
  Offset getOffset(int column, int row);
  double get remainingWidth;
  double get remainingHeight;
  double get remainingLooseWidth;
  double get remainingLooseHeight;
  bool get hasTightFlexWidth;
  bool get hasTightFlexHeight;
}
```
