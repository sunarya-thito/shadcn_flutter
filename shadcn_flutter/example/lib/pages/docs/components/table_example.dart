import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/table/table_example_1.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TableExample extends StatelessWidget {
  const TableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'table',
      description: 'A table displays a collection of data in rows and columns.',
      displayName: 'Table',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: TableExample1(),
          path: 'lib/pages/docs/components/table/table_example_1.dart',
        ),
      ],
    );
  }
}
