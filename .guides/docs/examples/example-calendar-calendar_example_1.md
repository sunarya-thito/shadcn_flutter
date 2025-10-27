---
title: "Example: components/calendar/calendar_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Calendar with range selection mode.
///
/// Demonstrates navigating months using a custom header and binding
/// a [CalendarValue] for a date range via [CalendarSelectionMode.range].
class CalendarExample1 extends StatefulWidget {
  const CalendarExample1({super.key});

  @override
  State<CalendarExample1> createState() => _CalendarExample1State();
}

class _CalendarExample1State extends State<CalendarExample1> {
  // Holds the current selection (start/end) when in range mode.
  CalendarValue? _value;
  // Tracks the current month/year view independent of selection.
  CalendarView _view = CalendarView.now();
  @override
  Widget build(BuildContext context) {
    ShadcnLocalizations localizations = ShadcnLocalizations.of(context);
    return Card(
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                OutlineButton(
                  density: ButtonDensity.icon,
                  onPressed: () {
                    setState(() {
                      // Move the calendar view to the previous month.
                      _view = _view.previous;
                    });
                  },
                  child: const Icon(Icons.arrow_back).iconXSmall(),
                ),
                Text('${localizations.getMonth(_view.month)} ${_view.year}')
                    .small()
                    .medium()
                    .center()
                    .expanded(),
                OutlineButton(
                  density: ButtonDensity.icon,
                  onPressed: () {
                    setState(() {
                      // Move the calendar view to the next month.
                      _view = _view.next;
                    });
                  },
                  child: const Icon(Icons.arrow_forward).iconXSmall(),
                ),
              ],
            ),
            const Gap(16),
            Calendar(
              value: _value,
              view: _view,
```
