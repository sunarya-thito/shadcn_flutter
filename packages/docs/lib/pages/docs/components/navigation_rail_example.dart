import 'package:docs/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import 'navigation_rail/navigation_rail_example_1.dart';

class NavigationRailExample extends StatelessWidget {
  const NavigationRailExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'navigation_rail',
      description:
          'A widget that displays a rail with navigation buttons and labels.',
      displayName: 'Navigation Rail',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/navigation_rail/navigation_rail_example_1.dart',
          child: SizedBox(
            width: 500,
            height: 400,
            child: OutlinedContainer(child: NavigationRailExample1()),
          ),
        ),
      ],
    );
  }
}
