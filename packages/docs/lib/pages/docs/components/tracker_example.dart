import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/tracker/tracker_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TrackerExample extends StatelessWidget {
  const TrackerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tracker',
      description: 'Component for visualizing data related to monitoring',
      displayName: 'Tracker',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/tracker/tracker_example_1.dart',
          child: TrackerExample1(),
        ),
      ],
    );
  }
}
