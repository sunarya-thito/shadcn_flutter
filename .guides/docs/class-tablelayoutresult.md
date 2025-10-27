---
title: "Class: TableLayoutResult"
description: "Reference for TableLayoutResult"
---

```dart
class TableLayoutResult {
  final List<double> columnWidths;
  final List<double> rowHeights;
  final double remainingWidth;
  final double remainingHeight;
  final double remainingLooseWidth;
  final double remainingLooseHeight;
  final bool hasTightFlexWidth;
  final bool hasTightFlexHeight;
  TableLayoutResult({required this.columnWidths, required this.rowHeights, required this.remainingWidth, required this.remainingHeight, required this.remainingLooseWidth, required this.remainingLooseHeight, required this.hasTightFlexWidth, required this.hasTightFlexHeight});
  Offset getOffset(int column, int row);
  /// Returns the sum of all column widths and row heights.
  Size get size;
  double get width;
  double get height;
}
```
