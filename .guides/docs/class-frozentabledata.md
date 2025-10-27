---
title: "Class: FrozenTableData"
description: "Reference for FrozenTableData"
---

```dart
class FrozenTableData {
  final Iterable<TableRef> frozenRows;
  final Iterable<TableRef> frozenColumns;
  const FrozenTableData({this.frozenRows = const [], this.frozenColumns = const []});
  bool testRow(int index, int span);
  bool testColumn(int index, int span);
}
```
