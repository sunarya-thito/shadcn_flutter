---
title: "Class: RangeCalendarValue"
description: "Calendar value representing a date range selection."
---

```dart
/// Calendar value representing a date range selection.
///
/// Encapsulates a date range with start and end dates. Provides lookup
/// functionality to determine if a date is the start, end, within the range,
/// or outside. Used with [CalendarSelectionMode.range].
///
/// The range is automatically normalized so start is always before or equal to end.
class RangeCalendarValue extends CalendarValue {
  /// The start date of the range (always <= end).
  final DateTime start;
  /// The end date of the range (always >= start).
  final DateTime end;
  /// Creates a range calendar value with the specified start and end dates.
  ///
  /// Automatically normalizes the range so [start] is before [end].
  RangeCalendarValue(DateTime start, DateTime end);
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
