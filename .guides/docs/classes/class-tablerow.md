---
title: "Class: TableRow"
description: "Reference for TableRow"
---

```dart
class TableRow {
  final List<TableCell> cells;
  final TableCellTheme? cellTheme;
  final bool selected;
  const TableRow({required this.cells, this.cellTheme, this.selected = false});
  TableCellTheme buildDefaultTheme(BuildContext context);
  bool operator ==(Object other);
  int get hashCode;
}
```
