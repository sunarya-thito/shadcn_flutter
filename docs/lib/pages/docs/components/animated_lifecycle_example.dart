import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/state/animated_lifecycle_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AnimatedLifecycleExample extends StatelessWidget {
  const AnimatedLifecycleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'animated_lifecycle',
      displayName: 'Animated Lifecycle',
      description:
          'AnimatedLifecycleBucket and AnimatedLifecycleWidget help manage the lifecycle of widgets with entry and exit animations.',
      children: [
        WidgetUsageExample(
          title: 'Animated Lifecycle Example',
          path:
              'lib/pages/docs/components/state/animated_lifecycle_example_1.dart',
          child: AnimatedLifecycleExample1(),
        ),
      ],
    );
  }
}
