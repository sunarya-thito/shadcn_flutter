---
title: "Class: CalendarValue"
description: "Abstract base class representing calendar selection values."
---

```dart
/// Abstract base class representing calendar selection values.
///
/// Provides a unified interface for different types of calendar selections including
/// single dates, date ranges, and multiple date collections. Handles date lookup
/// operations and conversion between different selection types.
///
/// Subclasses include:
/// - [SingleCalendarValue]: Represents a single selected date
/// - [RangeCalendarValue]: Represents a date range with start and end
/// - [MultiCalendarValue]: Represents multiple individual selected dates
///
/// The class provides factory constructors for easy creation and conversion
/// methods to transform between different selection types as needed.
///
/// Example:
/// ```dart
/// // Create different value types
/// final single = CalendarValue.single(DateTime.now());
/// final range = CalendarValue.range(startDate, endDate);
/// final multi = CalendarValue.multi([date1, date2, date3]);
///
/// // Check if a date is selected
/// final lookup = value.lookup(2024, 3, 15);
/// final isSelected = lookup != CalendarValueLookup.none;
/// ```
abstract class CalendarValue {
  CalendarValueLookup lookup(int year, [int? month = 1, int? day = 1]);
  const CalendarValue();
  static SingleCalendarValue single(DateTime date);
  static RangeCalendarValue range(DateTime start, DateTime end);
  static MultiCalendarValue multi(List<DateTime> dates);
  SingleCalendarValue toSingle();
  RangeCalendarValue toRange();
  MultiCalendarValue toMulti();
  CalendarView get view;
}
```
