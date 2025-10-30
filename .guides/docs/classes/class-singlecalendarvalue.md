---
title: "Class: SingleCalendarValue"
description: "Calendar value representing a single selected date."
---

```dart
/// Calendar value representing a single selected date.
///
/// Encapsulates a single [DateTime] selection and provides lookup functionality
/// to determine if a given date matches the selected date. Used primarily
/// with [CalendarSelectionMode.single].
///
/// Example:
/// ```dart
/// final singleValue = SingleCalendarValue(DateTime(2024, 3, 15));
/// final lookup = singleValue.lookup(2024, 3, 15);
/// print(lookup == CalendarValueLookup.selected); // true
/// ```
class SingleCalendarValue extends CalendarValue {
  /// The selected date.
  final DateTime date;
  /// Creates a single calendar value with the specified date.
  SingleCalendarValue(this.date);
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
