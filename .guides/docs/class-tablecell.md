---
title: "Class: TableCell"
description: "Reference for TableCell"
---

```dart
class TableCell {
  final int columnSpan;
  final int rowSpan;
  final Widget child;
  final bool columnHover;
  final bool rowHover;
  final Color? backgroundColor;
  final TableCellTheme? theme;
  final bool enabled;
  const TableCell({this.columnSpan = 1, this.rowSpan = 1, required this.child, this.backgroundColor, this.columnHover = false, this.rowHover = true, this.theme, this.enabled = true});
  Widget build(BuildContext context);
  bool operator ==(Object other);
  int get hashCode;
}
```
