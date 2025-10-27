---
title: "Class: TimeRange"
description: "Reference for TimeRange"
---

```dart
class TimeRange {
  final TimeOfDay start;
  final TimeOfDay end;
  const TimeRange({required this.start, required this.end});
  TimeRange copyWith({ValueGetter<TimeOfDay>? start, ValueGetter<TimeOfDay>? end});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
