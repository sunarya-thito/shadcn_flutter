import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'collapsible/collapsible_example_1.dart';

class CollapsibleExample extends StatelessWidget {
  const CollapsibleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'collapsible',
      description: 'A widget that can be expanded or collapsed.',
      displayName: 'Collapsible',
      children: [
        WidgetUsageExample(
          title: 'Collapsible Example',
          path:
              'lib/pages/docs/components/collapsible/collapsible_example_1.dart',
          child: CollapsibleExample1(),
        ),
      ],
    );
  }
}
