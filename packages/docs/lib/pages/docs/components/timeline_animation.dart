import 'package:docs/pages/docs/components/timeline_animation/timeline_animation_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TimelineAnimationExample extends StatelessWidget {
  const TimelineAnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'timeline_animation',
      description: 'A timeline animation is a way of displaying a list of '
          'events in chronological order, sometimes described as a project '
          'artifact with animations.',
      displayName: 'Timeline Animation',
      children: [
        WidgetUsageExample(
          title: 'Timeline Animation Example',
          path:
              'lib/pages/docs/components/timeline_animation/timeline_animation_example_1.dart',
          child: TimelineAnimationExample1(),
        ),
      ],
    );
  }
}
