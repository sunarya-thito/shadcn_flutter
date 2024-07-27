import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/sortable/sortable_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';

class SortableExample extends StatelessWidget {
  const SortableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'sortable',
      description: 'A sortable is a way of displaying a list of items in '
          'a way that allows the user to change the order of the items.',
      displayName: 'Sortable',
      children: [
        WidgetUsageExample(
          title: 'Sortable Example',
          child: SortableExample1(),
          path: 'lib/pages/docs/components/sortable/sortable_example_1.dart',
        ),
      ],
    );
  }
}
