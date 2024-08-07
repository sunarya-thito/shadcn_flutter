import 'package:docs/pages/docs/components/tab_list/tab_list_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TabListExample extends StatelessWidget {
  const TabListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tab_list',
      description: 'A list of tabs for selecting a single item.',
      displayName: 'Tab List',
      children: [
        WidgetUsageExample(
          title: 'Tab List Example',
          path: 'lib/pages/docs/components/tab_list/tab_list_example_1.dart',
          child: TabListExample1(),
        ),
      ],
    );
  }
}
