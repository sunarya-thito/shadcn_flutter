---
title: "Class: MonthCalendar"
description: "Reference for MonthCalendar"
---

```dart
class MonthCalendar extends StatelessWidget {
  final CalendarView value;
  final ValueChanged<CalendarView> onChanged;
  final DateTime? now;
  final CalendarValue? calendarValue;
  final DateStateBuilder? stateBuilder;
  const MonthCalendar({super.key, required this.value, required this.onChanged, this.now, this.calendarValue, this.stateBuilder});
  Widget build(BuildContext context);
}
```
