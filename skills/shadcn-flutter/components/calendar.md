# CalendarTheme

Theme configuration for calendar widgets.

## Usage

### Calendar Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/calendar/calendar_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'calendar/calendar_example_2.dart';
import 'calendar/calendar_example_3.dart';
import 'calendar/calendar_example_4.dart';

class CalendarExample extends StatelessWidget {
  const CalendarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'calendar',
      description: 'A widget that lets users select dates and date ranges.',
      displayName: 'Calendar',
      children: [
        WidgetUsageExample(
          title: 'Range Calendar Example',
          path: 'lib/pages/docs/components/calendar/calendar_example_1.dart',
          child: CalendarExample1(),
        ),
        WidgetUsageExample(
          title: 'Single Calendar Example',
          path: 'lib/pages/docs/components/calendar/calendar_example_2.dart',
          child: CalendarExample2(),
        ),
        WidgetUsageExample(
          title: 'Multiple Calendar Example',
          path: 'lib/pages/docs/components/calendar/calendar_example_3.dart',
          child: CalendarExample3(),
        ),
        WidgetUsageExample(
          title: 'Calendar Example',
          path: 'lib/pages/docs/components/calendar/calendar_example_4.dart',
          child: CalendarExample4(),
        ),
      ],
    );
  }
}

```

### Calendar Example 1
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
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              // Range selection allows choosing a start and end date.
              selectionMode: CalendarSelectionMode.range,
            ),
          ],
        ),
      ),
    );
  }
}

```

### Calendar Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Calendar with single-date selection and a "today" marker.
///
/// Uses [CalendarSelectionMode.single] to allow selecting exactly one date,
/// and passes `now` to highlight the current day in the view.
class CalendarExample2 extends StatefulWidget {
  const CalendarExample2({super.key});

  @override
  State<CalendarExample2> createState() => _CalendarExample2State();
}

class _CalendarExample2State extends State<CalendarExample2> {
  CalendarValue? _value;
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
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              selectionMode: CalendarSelectionMode.single,
              // Provide a "today" reference for visual emphasis.
              now: DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Calendar Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Calendar with multi-date selection.
///
/// [CalendarSelectionMode.multi] allows selecting multiple individual days.
class CalendarExample3 extends StatefulWidget {
  const CalendarExample3({super.key});

  @override
  State<CalendarExample3> createState() => _CalendarExample3State();
}

class _CalendarExample3State extends State<CalendarExample3> {
  CalendarValue? _value;
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
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              // Multi selection lets users toggle arbitrary dates on/off.
              selectionMode: CalendarSelectionMode.multi,
            ),
          ],
        ),
      ),
    );
  }
}

```

### Calendar Example 4
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Calendar in read-only mode (no selection).
///
/// [CalendarSelectionMode.none] displays the month grid without allowing
/// user selections; useful for a visual calendar-only view.
class CalendarExample4 extends StatefulWidget {
  const CalendarExample4({super.key});

  @override
  State<CalendarExample4> createState() => _CalendarExample4State();
}

class _CalendarExample4State extends State<CalendarExample4> {
  CalendarValue? _value;
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
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
              },
              now: DateTime.now(),
              // Disable all selection (view-only).
              selectionMode: CalendarSelectionMode.none,
            ),
          ],
        ),
      ),
    );
  }
}

```

### Calendar Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CalendarTile extends StatelessWidget implements IComponentPage {
  const CalendarTile({super.key});

  @override
  String get title => 'Calendar';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'calendar',
      title: 'Calendar',
      scale: 1,
      example: Calendar(
          view: CalendarView.now(), selectionMode: CalendarSelectionMode.none),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `arrowIconColor` | `Color?` | Color of navigation arrow icons. |
