---
title: "Class: ResizableTable"
description: "Reference for ResizableTable"
---

```dart
class ResizableTable extends StatefulWidget {
  final List<TableRow> rows;
  final ResizableTableController controller;
  final ResizableTableTheme? theme;
  final Clip clipBehavior;
  final TableCellResizeMode cellWidthResizeMode;
  final TableCellResizeMode cellHeightResizeMode;
  final FrozenTableData? frozenCells;
  final double? horizontalOffset;
  final double? verticalOffset;
  final Size? viewportSize;
  const ResizableTable({super.key, required this.rows, required this.controller, this.theme, this.clipBehavior = Clip.hardEdge, this.cellWidthResizeMode = TableCellResizeMode.reallocate, this.cellHeightResizeMode = TableCellResizeMode.expand, this.frozenCells, this.horizontalOffset, this.verticalOffset, this.viewportSize});
  State<ResizableTable> createState();
}
```
