---
title: "Class: YearCalendar"
description: "A calendar widget that displays years in a grid."
---

```dart
/// A calendar widget that displays years in a grid.
///
/// Shows a 4x4 grid of years for year selection. Used as part of the calendar
/// navigation when users want to select a different year.
class YearCalendar extends StatelessWidget {
  /// The starting year for the grid display.
  final int yearSelectStart;
  /// The currently selected year value.
  final int value;
  /// Callback invoked when a year is selected.
  final ValueChanged<int> onChanged;
  /// The current date for highlighting purposes.
  final DateTime? now;
  /// The currently selected calendar value.
  final CalendarValue? calendarValue;
  /// Builder function to determine the state of each year.
  final DateStateBuilder? stateBuilder;
  /// Creates a year selection calendar.
  const YearCalendar({super.key, required this.yearSelectStart, required this.value, required this.onChanged, this.now, this.calendarValue, this.stateBuilder});
  Widget build(BuildContext context);
}
```
