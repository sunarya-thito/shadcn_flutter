---
title: "Class: CalendarGridData"
description: "Data structure representing a complete calendar month grid."
---

```dart
/// Data structure representing a complete calendar month grid.
///
/// Contains all the information needed to render a calendar grid including
/// dates from the current month and overflow dates from adjacent months
/// to fill complete weeks.
class CalendarGridData {
  /// The month number (1-12) this grid represents.
  final int month;
  /// The year this grid represents.
  final int year;
  /// The list of calendar grid items including current and adjacent month dates.
  final List<CalendarGridItem> items;
  /// Creates calendar grid data for the specified month and year.
  ///
  /// Automatically calculates and includes dates from previous and next months
  /// to fill complete weeks in the grid.
  factory CalendarGridData({required int month, required int year});
  bool operator ==(Object other);
  int get hashCode;
}
```
