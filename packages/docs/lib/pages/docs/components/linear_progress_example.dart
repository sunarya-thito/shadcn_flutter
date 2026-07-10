import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/linear_progress/linear_progress_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'linear_progress/linear_progress_example_2.dart';

class LinearProgressExample extends StatelessWidget {
  const LinearProgressExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'linear_progress',
      description: 'A widget that shows progress along a line.',
      displayName: 'Linear Progress',
      children: [
        WidgetUsageExample(
          title: 'Indeterminate Example',
          path:
              'lib/pages/docs/components/linear_progress/linear_progress_example_1.dart',
          child: LinearProgressExample1(),
        ),
        WidgetUsageExample(
          title: 'Determinate Example',
          path:
              'lib/pages/docs/components/linear_progress/linear_progress_example_2.dart',
          child: LinearProgressExample2(),
        ),
      ],
    );
  }
}
