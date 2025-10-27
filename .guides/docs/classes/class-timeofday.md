---
title: "Class: TimeOfDay"
description: "Reference for TimeOfDay"
---

```dart
class TimeOfDay {
  final int hour;
  final int minute;
  final int second;
  const TimeOfDay({required this.hour, required this.minute, this.second = 0});
  const TimeOfDay.pm({required int hour, required this.minute, this.second = 0});
  const TimeOfDay.am({required this.hour, required this.minute, this.second = 0});
  TimeOfDay.fromDateTime(DateTime dateTime);
  TimeOfDay.fromDuration(Duration duration);
  TimeOfDay.now();
  TimeOfDay copyWith({ValueGetter<int>? hour, ValueGetter<int>? minute, ValueGetter<int>? second});
  /// For backward compatibility
  TimeOfDay replacing({int? hour, int? minute, int? second});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
