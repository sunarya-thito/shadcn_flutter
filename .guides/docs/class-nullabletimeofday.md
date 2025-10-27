---
title: "Class: NullableTimeOfDay"
description: "Reference for NullableTimeOfDay"
---

```dart
class NullableTimeOfDay {
  final int? hour;
  final int? minute;
  final int? second;
  NullableTimeOfDay({this.hour, this.minute, this.second});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
  NullableTimeOfDay copyWith({ValueGetter<int?>? hour, ValueGetter<int?>? minute, ValueGetter<int?>? second});
  TimeOfDay? get toTimeOfDay;
  static NullableTimeOfDay? fromTimeOfDay(TimeOfDay? timeOfDay);
  int? operator [](TimePart part);
  Map<TimePart, int> toMap();
}
```
