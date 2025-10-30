---
title: "Class: CalendarGridItem"
description: "Individual item within a calendar grid representing a single date cell."
---

```dart
/// Individual item within a calendar grid representing a single date cell.
///
/// Contains metadata about a date's position and state within the calendar grid.
class CalendarGridItem {
  /// The date this grid item represents.
  final DateTime date;
  /// The index of this item within its row (0-6 for day of week).
  final int indexInRow;
  /// The row index in the calendar grid.
  final int rowIndex;
  /// Whether this date belongs to a different month than the grid's primary month.
  final bool fromAnotherMonth;
  /// Creates a calendar grid item.
  CalendarGridItem(this.date, this.indexInRow, this.fromAnotherMonth, this.rowIndex);
  /// Returns true if this item represents today's date.
  bool get isToday;
  bool operator ==(Object other);
  int get hashCode;
}
```
