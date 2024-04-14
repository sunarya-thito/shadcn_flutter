import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'collapsible/collapsible_example_1.dart';
class CollapsibleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'collapsible',
      description: 'A widget that can be expanded or collapsed.',
      displayName: 'Collapsible',
      children: [
        WidgetUsageExample(
          child: CollapsibleExample1(),
          path: 'lib/pages/docs/components/collapsible/collapsible_example_1.dart',
        ),
      ],
    );
  }
}
  