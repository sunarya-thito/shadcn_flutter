import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'circular_progress/circular_progress_example_1.dart';
import 'circular_progress/circular_progress_example_2.dart';

class CircularProgressExample extends StatelessWidget {
  const CircularProgressExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'circular_progress',
      description: 'A circular progress indicator.',
      displayName: 'Circular Progress',
      children: [
        WidgetUsageExample(
          title: 'Circular Progress Example',
          path:
              'lib/pages/docs/components/circular_progress/circular_progress_example_1.dart',
          child: CircularProgressExample1(),
        ),
        WidgetUsageExample(
          title: 'Circular Progress with Value Example',
          path:
              'lib/pages/docs/components/circular_progress/circular_progress_example_2.dart',
          child: CircularProgressExample2(),
        ),
      ],
    );
  }
}
