import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/calendar/calendar_example.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CalendarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'calendar',
      description: 'A widget that lets users select dates and date ranges.',
      displayName: 'Calendar',
      children: [
        WidgetUsageExample(
          title: 'Calendar Example',
          child: CalendarExample1(),
          path: 'lib/pages/docs/components/calendar/calendar_example_1.dart',
        ),
      ],
    );
  }
}
