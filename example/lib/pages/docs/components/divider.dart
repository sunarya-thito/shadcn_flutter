import 'package:example/pages/docs/component_page.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';

class DividerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'divider',
      description:
          'A divider is a thin line that groups content in lists and layouts.',
      displayName: 'Divider',
      children: [
        WidgetUsageExample(
          builder: (context) {
            return SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Item 1'),
                  Divider(),
                  Text('Item 2'),
                  Divider(),
                  Text('Item 3'),
                ],
              ),
            );
          },
          code: 'Divider()',
        ),
        // veritcal divider
        WidgetUsageExample(
          builder: (context) {
            return SizedBox(
              width: 300,
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Text('Item 1')),
                  VerticalDivider(),
                  Expanded(child: Text('Item 2')),
                  VerticalDivider(),
                  Expanded(child: Text('Item 3')),
                ],
              ),
            );
          },
          code: 'VerticalDivider()',
        ),
        // with child
        WidgetUsageExample(
          builder: (context) {
            return SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Item 1'),
                  Divider(
                    child: Text('Divider'),
                  ),
                  Text('Item 2'),
                  Divider(
                    child: Text('Divider'),
                  ),
                  Text('Item 3'),
                ],
              ),
            );
          },
          code: 'Divider(\n  child: Text(\'Divider\'),\n)',
        ),
      ],
    );
  }
}
