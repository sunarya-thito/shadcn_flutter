---
title: "Class: DateTimeRange"
description: "Reference for DateTimeRange"
---

```dart
class DateTimeRange {
  final DateTime start;
  final DateTime end;
  const DateTimeRange(this.start, this.end);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
  DateTimeRange copyWith({ValueGetter<DateTime>? start, ValueGetter<DateTime>? end});
}
```
