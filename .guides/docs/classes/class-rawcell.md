---
title: "Class: RawCell"
description: "Reference for RawCell"
---

```dart
class RawCell extends ParentDataWidget<TableParentData> {
  final int column;
  final int row;
  final int? columnSpan;
  final int? rowSpan;
  final bool computeSize;
  const RawCell({super.key, required this.column, required this.row, this.columnSpan, this.rowSpan, this.computeSize = true, required super.child});
  void applyParentData(RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
}
```
