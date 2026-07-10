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
