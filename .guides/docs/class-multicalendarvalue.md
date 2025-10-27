---
title: "Class: MultiCalendarValue"
description: "Reference for MultiCalendarValue"
---

```dart
class MultiCalendarValue extends CalendarValue {
  final List<DateTime> dates;
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
