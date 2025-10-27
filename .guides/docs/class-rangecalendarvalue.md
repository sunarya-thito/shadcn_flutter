---
title: "Class: RangeCalendarValue"
description: "Reference for RangeCalendarValue"
---

```dart
class RangeCalendarValue extends CalendarValue {
  final DateTime start;
  final DateTime end;
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
