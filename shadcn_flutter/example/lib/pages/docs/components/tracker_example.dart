import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/tracker/tracker_example_1.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TrackerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'tracker',
      description: 'Component for visualizing data related to monitoring',
      displayName: 'Tracker',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: TrackerExample1(),
          path: 'lib/pages/docs/components/tracker/tracker_example_1.dart',
        ),
      ],
    );
  }
}
