import 'package:docs/pages/docs/components/table/table_example_1.dart';
import 'package:docs/pages/docs/components/table/table_example_2.dart';
import 'package:docs/pages/docs/components/table/table_example_3.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TableExample extends StatelessWidget {
  const TableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'table',
      description: 'A table displays data in a tabular format.',
      displayName: 'Table',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/table/table_example_1.dart',
          child: TableExample1(),
        ),
        WidgetUsageExample(
          title: 'Resizable Example',
          path: 'lib/pages/docs/components/table/table_example_2.dart',
          child: TableExample2(),
        ),
        WidgetUsageExample(
          title: 'Scrollable Example',
          path: 'lib/pages/docs/components/table/table_example_3.dart',
          child: TableExample3(),
        ),
      ],
    );
  }
}
