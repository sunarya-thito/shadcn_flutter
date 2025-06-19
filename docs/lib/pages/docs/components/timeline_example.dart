import 'package:docs/pages/docs/components/timeline/timeline_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TimelineExample extends StatelessWidget {
  const TimelineExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'timeline',
      description: 'A timeline is a way of displaying a list of events in '
          'chronological order, sometimes described as a project artifact.',
      displayName: 'Timeline',
      children: [
        WidgetUsageExample(
          title: 'Timeline Example',
          path: 'lib/pages/docs/components/timeline/timeline_example_1.dart',
          child: TimelineExample1(),
        ),
      ],
    );
  }
}
