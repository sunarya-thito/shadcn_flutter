import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/calendar/calendar_example_1.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'calendar/calendar_example_2.dart';
import 'calendar/calendar_example_3.dart';
import 'calendar/calendar_example_4.dart';

class CalendarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'calendar',
      description: 'A widget that lets users select dates and date ranges.',
      displayName: 'Calendar',
      children: [
        WidgetUsageExample(
          title: 'Range Calendar Example',
          child: CalendarExample1(),
          path: 'lib/pages/docs/components/calendar/calendar_example_1.dart',
        ),
        WidgetUsageExample(
          title: 'Single Calendar Example',
          child: CalendarExample2(),
          path: 'lib/pages/docs/components/calendar/calendar_example_2.dart',
        ),
        WidgetUsageExample(
          title: 'Multiple Calendar Example',
          child: CalendarExample3(),
          path: 'lib/pages/docs/components/calendar/calendar_example_3.dart',
        ),
        WidgetUsageExample(
          title: 'Calendar Example',
          child: CalendarExample4(),
          path: 'lib/pages/docs/components/calendar/calendar_example_4.dart',
        ),
      ],
    );
  }
}
