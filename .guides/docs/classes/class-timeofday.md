---
title: "Class: TimeOfDay"
description: "Represents a time of day with hour, minute, and second."
---

```dart
/// Represents a time of day with hour, minute, and second.
///
/// Provides constructors for various time representations including
/// AM/PM notation, DateTime conversion, and Duration conversion.
class TimeOfDay {
  /// Hour component (0-23).
  final int hour;
  /// Minute component (0-59).
  final int minute;
  /// Second component (0-59).
  final int second;
  /// Creates a [TimeOfDay] with specified components.
  ///
  /// Parameters:
  /// - [hour] (`int`, required): Hour (0-23).
  /// - [minute] (`int`, required): Minute (0-59).
  /// - [second] (`int`, default: 0): Second (0-59).
  const TimeOfDay({required this.hour, required this.minute, this.second = 0});
  /// Creates a PM time (adds 12 to the hour).
  ///
  /// Parameters:
  /// - [hour] (`int`, required): Hour in 12-hour format (1-12).
  /// - [minute] (`int`, required): Minute (0-59).
  /// - [second] (`int`, default: 0): Second (0-59).
  const TimeOfDay.pm({required int hour, required this.minute, this.second = 0});
  /// Creates an AM time.
  ///
  /// Parameters:
  /// - [hour] (`int`, required): Hour in 12-hour format (0-11).
  /// - [minute] (`int`, required): Minute (0-59).
  /// - [second] (`int`, default: 0): Second (0-59).
  const TimeOfDay.am({required this.hour, required this.minute, this.second = 0});
  /// Creates a [TimeOfDay] from a [DateTime].
  ///
  /// Parameters:
  /// - [dateTime] (`DateTime`, required): DateTime to extract time from.
  TimeOfDay.fromDateTime(DateTime dateTime);
  /// Creates a [TimeOfDay] from a [Duration].
  ///
  /// Parameters:
  /// - [duration] (`Duration`, required): Duration to convert.
  TimeOfDay.fromDuration(Duration duration);
  /// Creates a [TimeOfDay] representing the current time.
  TimeOfDay.now();
  /// Creates a copy with specified fields replaced.
  ///
  /// Parameters:
  /// - [hour] (`ValueGetter<int>?`, optional): New hour value.
  /// - [minute] (`ValueGetter<int>?`, optional): New minute value.
  /// - [second] (`ValueGetter<int>?`, optional): New second value.
  ///
  /// Returns: `TimeOfDay` — copy with updated values.
  TimeOfDay copyWith({ValueGetter<int>? hour, ValueGetter<int>? minute, ValueGetter<int>? second});
  /// For backward compatibility
  TimeOfDay replacing({int? hour, int? minute, int? second});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
