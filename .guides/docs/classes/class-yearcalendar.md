---
title: "Class: YearCalendar"
description: "Reference for YearCalendar"
---

```dart
class YearCalendar extends StatelessWidget {
  final int yearSelectStart;
  final int value;
  final ValueChanged<int> onChanged;
  final DateTime? now;
  final CalendarValue? calendarValue;
  final DateStateBuilder? stateBuilder;
  const YearCalendar({super.key, required this.yearSelectStart, required this.value, required this.onChanged, this.now, this.calendarValue, this.stateBuilder});
  Widget build(BuildContext context);
}
```
