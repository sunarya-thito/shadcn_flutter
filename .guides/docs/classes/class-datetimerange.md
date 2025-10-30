---
title: "Class: DateTimeRange"
description: "Represents a range of dates with a start and end time."
---

```dart
/// Represents a range of dates with a start and end time.
///
/// Immutable value type for representing a continuous period between two dates.
/// Commonly used with date range pickers to specify selected date intervals.
///
/// Example:
/// ```dart
/// final range = DateTimeRange(
///   DateTime(2024, 1, 1),
///   DateTime(2024, 1, 31),
/// );
/// ```
class DateTimeRange {
  /// The start date/time of the range.
  final DateTime start;
  /// The end date/time of the range.
  final DateTime end;
  /// Creates a [DateTimeRange].
  ///
  /// Parameters:
  /// - [start] (`DateTime`, required): The beginning of the range.
  /// - [end] (`DateTime`, required): The end of the range.
  const DateTimeRange(this.start, this.end);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
  /// Creates a copy of this range with the given fields replaced.
  ///
  /// Parameters:
  /// - [start] (`ValueGetter<DateTime>?`, optional): New start date.
  /// - [end] (`ValueGetter<DateTime>?`, optional): New end date.
  ///
  /// Returns: A new [DateTimeRange] with updated values.
  DateTimeRange copyWith({ValueGetter<DateTime>? start, ValueGetter<DateTime>? end});
}
```
