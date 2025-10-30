---
title: "Class: NullableTimeOfDay"
description: "Represents a time with nullable components (hour, minute, second)."
---

```dart
/// Represents a time with nullable components (hour, minute, second).
///
/// Useful for time input scenarios where individual time parts may be
/// missing or incomplete. Can convert to [TimeOfDay] when hour and minute are present.
///
/// Example:
/// ```dart
/// final time = NullableTimeOfDay(hour: 14, minute: 30, second: 0);
/// print(time.toTimeOfDay); // TimeOfDay(hour: 14, minute: 30)
/// ```
class NullableTimeOfDay {
  /// The hour component (nullable, 0-23).
  final int? hour;
  /// The minute component (nullable, 0-59).
  final int? minute;
  /// The second component (nullable, 0-59).
  final int? second;
  /// Creates a [NullableTimeOfDay].
  ///
  /// Parameters:
  /// - [hour] (`int?`, optional): Hour value (0-23).
  /// - [minute] (`int?`, optional): Minute value (0-59).
  /// - [second] (`int?`, optional): Second value (0-59).
  NullableTimeOfDay({this.hour, this.minute, this.second});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
  /// Creates a copy with specified parts replaced.
  ///
  /// Parameters:
  /// - [hour] (`ValueGetter<int?>?`, optional): New hour value.
  /// - [minute] (`ValueGetter<int?>?`, optional): New minute value.
  /// - [second] (`ValueGetter<int?>?`, optional): New second value.
  ///
  /// Returns: A new [NullableTimeOfDay] with updated parts.
  NullableTimeOfDay copyWith({ValueGetter<int?>? hour, ValueGetter<int?>? minute, ValueGetter<int?>? second});
  /// Converts to [TimeOfDay] if hour and minute are present.
  ///
  /// Returns: A [TimeOfDay] instance, or null if hour or minute is missing.
  TimeOfDay? get toTimeOfDay;
  /// Creates a [NullableTimeOfDay] from a [TimeOfDay].
  ///
  /// Parameters:
  /// - [timeOfDay] (`TimeOfDay?`, optional): The time to convert.
  ///
  /// Returns: A [NullableTimeOfDay] instance, or null if input is null.
  static NullableTimeOfDay? fromTimeOfDay(TimeOfDay? timeOfDay);
  /// Retrieves the value of a specific time part.
  ///
  /// Parameters:
  /// - [part] (`TimePart`, required): The time part to retrieve.
  ///
  /// Returns: The value of the specified part, or null if not set.
  int? operator [](TimePart part);
  /// Converts to a map of time parts.
  ///
  /// Returns: A `Map<TimePart, int>` with non-null parts.
  Map<TimePart, int> toMap();
}
```
