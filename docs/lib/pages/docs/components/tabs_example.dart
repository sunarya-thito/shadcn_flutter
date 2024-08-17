import 'package:docs/pages/docs/components/tabs/tabs_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TabsExample extends StatelessWidget {
  const TabsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tabs',
      description: 'A list of tabs for selecting a single item.',
      displayName: 'Tabs',
      children: [
        WidgetUsageExample(
          title: 'Tabs Example',
          path: 'lib/pages/docs/components/tabs/tabs_example_1.dart',
          child: TabsExample1(),
        ),
      ],
    );
  }
}
