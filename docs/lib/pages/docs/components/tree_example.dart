import 'package:docs/pages/docs/components/tree/tree_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TreeExample extends StatelessWidget {
  const TreeExample({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tree',
      description:
          'A tree is a way of displaying a hierarchical list of items.',
      displayName: 'Tree',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/tree/tree_example_1.dart',
          child: TreeExample1(),
        ),
      ],
    );
  }
}
