import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/steps/steps_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepsExample extends StatelessWidget {
  const StepsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'steps',
      description: 'A series of steps for progress.',
      displayName: 'Steps',
      children: [
        WidgetUsageExample(
          title: 'Steps Example',
          path: 'lib/pages/docs/components/steps/steps_example_1.dart',
          child: StepsExample1(),
        ),
      ],
    );
  }
}
