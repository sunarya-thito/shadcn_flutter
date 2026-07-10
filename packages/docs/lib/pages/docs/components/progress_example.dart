import 'package:docs/pages/docs/components/progress/progress_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class ProgressExample extends StatelessWidget {
  const ProgressExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'progress',
      description: 'A visual indicator of an operation\'s progress.',
      displayName: 'Progress',
      children: [
        WidgetUsageExample(
          title: 'Progress Example',
          path: 'lib/pages/docs/components/progress/progress_example_1.dart',
          child: ProgressExample1(),
        ),
      ],
    );
  }
}
