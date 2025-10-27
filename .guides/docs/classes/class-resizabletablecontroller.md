---
title: "Class: ResizableTableController"
description: "Reference for ResizableTableController"
---

```dart
class ResizableTableController extends ChangeNotifier {
  ResizableTableController({Map<int, double>? columnWidths, required double defaultColumnWidth, Map<int, double>? rowHeights, required double defaultRowHeight, ConstrainedTableSize? defaultWidthConstraint, ConstrainedTableSize? defaultHeightConstraint, Map<int, ConstrainedTableSize>? widthConstraints, Map<int, ConstrainedTableSize>? heightConstraints});
  bool resizeColumn(int column, double width);
  double resizeColumnBorder(int previousColumn, int nextColumn, double deltaWidth);
  double resizeRowBorder(int previousRow, int nextRow, double deltaHeight);
  bool resizeRow(int row, double height);
  Map<int, double>? get columnWidths;
  Map<int, double>? get rowHeights;
  double getColumnWidth(int index);
  double getRowHeight(int index);
  double? getRowMinHeight(int index);
  double? getRowMaxHeight(int index);
  double? getColumnMinWidth(int index);
  double? getColumnMaxWidth(int index);
}
```
