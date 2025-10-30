---
title: "Class: MultiCalendarValue"
description: "Calendar value representing multiple selected dates."
---

```dart
/// Calendar value representing multiple selected dates.
///
/// Encapsulates a list of individually selected dates. Provides lookup
/// functionality to determine if a date is among the selected dates.
/// Used with [CalendarSelectionMode.multi].
class MultiCalendarValue extends CalendarValue {
  /// The list of selected dates.
  final List<DateTime> dates;
  /// Creates a multi calendar value with the specified list of dates.
  MultiCalendarValue(this.dates);
  CalendarValueLookup lookup(int year, [int? month, int? day]);
  CalendarView get view;
  String toString();
  bool operator ==(Object other);
  int get hashCode;
  SingleCalendarValue toSingle();
  RangeCalendarValue toRange();
  MultiCalendarValue toMulti();
}
```
