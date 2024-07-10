import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'drawer/drawer_example_1.dart';

class DrawerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'drawer',
      description:
          'A drawer is a panel that slides in from the edge of a screen.',
      displayName: 'Drawer',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: DrawerExample1(),
          path: 'lib/pages/docs/components/drawer/drawer_example_1.dart',
        ),
      ],
    );
  }
}
