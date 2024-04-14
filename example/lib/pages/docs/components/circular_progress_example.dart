import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'circular_progress/circular_progress_example_1.dart';
class CircularProgressExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'circular_progress',
      description: 'A circular progress indicator.',
      displayName: 'Circular Progress',
      children: [
        WidgetUsageExample(
          child: CircularProgressExample1(),
          path: 'lib/pages/docs/components/circular_progress/circular_progress_example_1.dart',
        ),
      ],
    );
  }
}
  