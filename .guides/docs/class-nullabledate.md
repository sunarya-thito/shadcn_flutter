---
title: "Class: NullableDate"
description: "Reference for NullableDate"
---

```dart
class NullableDate {
  final int? year;
  final int? month;
  final int? day;
  NullableDate({this.year, this.month, this.day});
  String toString();
  bool operator ==(Object other);
  int get hashCode;
  NullableDate copyWith({ValueGetter<int?>? year, ValueGetter<int?>? month, ValueGetter<int?>? day});
  DateTime get date;
  DateTime? get nullableDate;
  int? operator [](DatePart part);
  Map<DatePart, int> toMap();
}
```
