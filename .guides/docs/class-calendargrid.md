---
title: "Class: CalendarGrid"
description: "Reference for CalendarGrid"
---

```dart
class CalendarGrid extends StatelessWidget {
  final CalendarGridData data;
  final Widget Function(CalendarGridItem item) itemBuilder;
  const CalendarGrid({super.key, required this.data, required this.itemBuilder});
  Widget build(BuildContext context);
}
```
