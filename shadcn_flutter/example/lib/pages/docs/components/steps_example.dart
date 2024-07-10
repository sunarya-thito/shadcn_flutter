import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/steps/steps_example_1.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'steps',
      description: 'A series of steps for progress.',
      displayName: 'Steps',
      children: [
        WidgetUsageExample(
          title: 'Steps Example',
          child: StepsExample1(),
          path: 'lib/pages/docs/components/steps/steps_example_1.dart',
        ),
      ],
    );
  }
}
