import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'drawer/drawer_example_1.dart';

class DrawerExample extends StatelessWidget {
  const DrawerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'drawer',
      description:
          'A drawer is a panel that slides in from the edge of a screen.',
      displayName: 'Drawer',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/drawer/drawer_example_1.dart',
          child: DrawerExample1(),
        ),
      ],
    );
  }
}
