import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/sortable/sortable_example_1.dart';
import 'package:docs/pages/docs/components/sortable/sortable_example_2.dart';
import 'package:docs/pages/docs/components/sortable/sortable_example_3.dart';
import 'package:docs/pages/docs/components/sortable/sortable_example_4.dart';
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
          title: 'Example',
          path: 'lib/pages/docs/components/sortable/sortable_example_1.dart',
          child: SortableExample1(),
        ),
        WidgetUsageExample(
          title: 'Locked Axis Example',
          path: 'lib/pages/docs/components/sortable/sortable_example_2.dart',
          child: SortableExample2(),
        ),
        WidgetUsageExample(
          title: 'Horizontal Example',
          path: 'lib/pages/docs/components/sortable/sortable_example_3.dart',
          child: SortableExample3(),
        ),
        WidgetUsageExample(
          title: 'ListView Example',
          path: 'lib/pages/docs/components/sortable/sortable_example_4.dart',
          child: SortableExample4(),
        ),
      ],
    );
  }
}
