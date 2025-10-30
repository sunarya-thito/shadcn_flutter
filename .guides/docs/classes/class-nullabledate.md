---
title: "Class: NullableDate"
description: "Represents a date with nullable components (year, month, day)."
---

```dart
/// Represents a date with nullable components (year, month, day).
///
/// Useful for date input scenarios where individual date parts may be
/// missing or incomplete. Can convert to [DateTime] when all parts are present.
///
/// Example:
/// ```dart
/// final date = NullableDate(year: 2024, month: 1, day: 15);
/// print(date.nullableDate); // DateTime(2024, 1, 15)
/// ```
class NullableDate {
  /// The year component (nullable).
  final int? year;
  /// The month component (nullable).
  final int? month;
  /// The day component (nullable).
  final int? day;
  /// Creates a [NullableDate].
  ///
  /// Parameters:
  /// - [year] (`int?`, optional): Year value.
  /// - [month] (`int?`, optional): Month value (1-12).
  /// - [day] (`int?`, optional): Day value (1-31).
  NullableDate({this.year, this.month, this.day});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
  /// Creates a copy with specified parts replaced.
  ///
  /// Parameters:
  /// - [year] (`ValueGetter<int?>?`, optional): New year value.
  /// - [month] (`ValueGetter<int?>?`, optional): New month value.
  /// - [day] (`ValueGetter<int?>?`, optional): New day value.
  ///
  /// Returns: A new [NullableDate] with updated parts.
  NullableDate copyWith({ValueGetter<int?>? year, ValueGetter<int?>? month, ValueGetter<int?>? day});
  /// Converts to [DateTime], using 0 for missing parts.
  ///
  /// Returns: A [DateTime] instance (may be invalid if parts are null/0).
  DateTime get date;
  /// Converts to [DateTime] only if all parts are present.
  ///
  /// Returns: A [DateTime] if complete, otherwise null.
  DateTime? get nullableDate;
  /// Retrieves the value of a specific date part.
  ///
  /// Parameters:
  /// - [part] (`DatePart`, required): The date part to retrieve.
  ///
  /// Returns: The value of the specified part, or null if not set.
  int? operator [](DatePart part);
  /// Converts to a map of date parts.
  ///
  /// Returns: A `Map<DatePart, int>` with non-null parts.
  Map<DatePart, int> toMap();
}
```
