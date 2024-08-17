import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/navigation_menu/navigation_menu_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationMenuExample extends StatelessWidget {
  const NavigationMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'navigation_menu',
      description:
          'Navigation menu is a component that provides a list of navigation items.',
      displayName: 'Navigation Menu',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/navigation_menu/navigation_menu_example_1.dart',
          child: NavigationMenuExample1(),
        ),
      ],
    );
  }
}
