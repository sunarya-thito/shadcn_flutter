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
  /// Looks up whether the specified date is part of this calendar value.
  ///
  /// Returns a [CalendarValueLookup] indicating the relationship of the
  /// queried date to this value (none, selected, start, end, or inRange).
  CalendarValueLookup lookup(int year, [int? month = 1, int? day = 1]);
  /// Creates a base calendar value.
  const CalendarValue();
  /// Factory constructor to create a single date value.
  static SingleCalendarValue single(DateTime date);
  /// Factory constructor to create a date range value.
  static RangeCalendarValue range(DateTime start, DateTime end);
  /// Factory constructor to create a multi-date value.
  static MultiCalendarValue multi(List<DateTime> dates);
  /// Converts this value to a single calendar value.
  SingleCalendarValue toSingle();
  /// Converts this value to a range calendar value.
  RangeCalendarValue toRange();
  /// Converts this value to a multi calendar value.
  MultiCalendarValue toMulti();
  /// Returns the calendar view associated with this value.
  CalendarView get view;
}
```
