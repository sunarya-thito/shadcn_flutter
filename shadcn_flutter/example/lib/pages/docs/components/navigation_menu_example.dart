import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/navigation_menu/navigation_menu_example_1.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationMenuExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'navigation_menu',
      description:
          'Navigation menu is a component that provides a list of navigation items.',
      displayName: 'Navigation Menu',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: NavigationMenuExample1(),
          path:
              'lib/pages/docs/components/navigation_menu/navigation_menu_example_1.dart',
        ),
      ],
    );
  }
}
