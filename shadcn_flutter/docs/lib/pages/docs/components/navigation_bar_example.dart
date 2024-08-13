import 'package:docs/pages/docs/components/navigation_bar/navigation_bar_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class NavigationBarExample extends StatelessWidget {
  const NavigationBarExample({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'navigation_bar',
      description:
          'A widget that displays a bar with navigation buttons and labels.',
      displayName: 'Navigation Bar',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: SizedBox(
            width: 500,
            height: 400,
            child: OutlinedContainer(child: NavigationBarExample1()),
          ),
          path:
              'lib/pages/docs/components/navigation_bar/navigation_bar_example_1.dart',
        ),
      ],
    );
  }
}
