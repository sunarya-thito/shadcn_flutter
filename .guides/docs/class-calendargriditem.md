---
title: "Class: CalendarGridItem"
description: "Reference for CalendarGridItem"
---

```dart
class CalendarGridItem {
  final DateTime date;
  final int indexInRow;
  final int rowIndex;
  final bool fromAnotherMonth;
  CalendarGridItem(this.date, this.indexInRow, this.fromAnotherMonth, this.rowIndex);
  bool get isToday;
  bool operator ==(Object other);
  int get hashCode;
}
```
