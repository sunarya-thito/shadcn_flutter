import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/expandable_sidebar/expandable_sidebar_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ExpandableSidebarExample extends StatelessWidget {
  const ExpandableSidebarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'expandable_sidebar',
      description: 'A Navigation Rail that can be expanded or collapsed',
      displayName: 'Expandable Sidebar',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/expandable_sidebar/expandable_sidebar_example_1.dart',
          child: ExpandableSidebarExample1(),
        ),
      ],
    );
  }
}
