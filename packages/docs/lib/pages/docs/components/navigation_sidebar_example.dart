import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'navigation_sidebar/navigation_sidebar_example_1.dart';

class NavigationSidebarExample extends StatelessWidget {
  const NavigationSidebarExample({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'navigation_sidebar',
      description:
          'A widget that displays a sidebar with navigation buttons and labels.',
      displayName: 'Navigation Sidebar',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/navigation_sidebar/navigation_sidebar_example_1.dart',
          child: NavigationSidebarExample1(),
        ),
      ],
    );
  }
}
