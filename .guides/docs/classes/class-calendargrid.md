---
title: "Class: CalendarGrid"
description: "Widget that renders a calendar grid using provided data."
---

```dart
/// Widget that renders a calendar grid using provided data.
///
/// Takes calendar grid data and an item builder to render the visual grid
/// of calendar dates. Handles layout and arrangement of dates in a weekly grid.
class CalendarGrid extends StatelessWidget {
  /// The grid data containing all calendar items to display.
  final CalendarGridData data;
  /// Builder function to create widgets for each grid item.
  final Widget Function(CalendarGridItem item) itemBuilder;
  /// Creates a calendar grid widget.
  const CalendarGrid({super.key, required this.data, required this.itemBuilder});
  Widget build(BuildContext context);
}
```
