import 'package:docs/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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
        // WidgetUsageExample(
        //   title: 'Multi Container Example',
        //   child: SortableExample2(),
        //   path: 'lib/pages/docs/components/sortable/sortable_example_2.dart',
        // ),
        // WidgetUsageExample(
        //   title: 'Lock Drag Axis Example',
        //   child: SortableExample3(),
        //   path: 'lib/pages/docs/components/sortable/sortable_example_3.dart',
        // ),
      ],
    );
  }
}
