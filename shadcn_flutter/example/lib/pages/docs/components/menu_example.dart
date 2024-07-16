import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/menubar/menubar_example_1.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'menubar',
      description:
          'A menubar is a horizontal bar that is typically placed at the top of a window or screen. It contains a list of menus that can be used to perform various actions.',
      displayName: 'Menubar',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: MenubarExample1(),
          path: 'lib/pages/docs/components/menubar/menubar_example_1.dart',
        ),
      ],
    );
  }
}
