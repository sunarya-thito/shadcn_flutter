import 'package:docs/pages/docs/components/navigation_bar/navigation_bar_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class NavigationBarExample extends StatelessWidget {
  const NavigationBarExample({super.key});
  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'navigation_bar',
      description:
          'A widget that displays a bar with navigation buttons and labels.',
      displayName: 'Navigation Bar',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/navigation_bar/navigation_bar_example_1.dart',
          child: NavigationBarExample1(),
        ),
      ],
    );
  }
}
