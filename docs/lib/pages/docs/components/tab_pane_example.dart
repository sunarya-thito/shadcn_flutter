import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/tab_pane/tab_pane_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TabPaneExample extends StatelessWidget {
  const TabPaneExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tab_pane',
      description:
          'A chrome-like tab pane that allows you to switch between different tabs.',
      displayName: 'Tab Pane',
      children: [
        WidgetUsageExample(
          title: 'Tab Pane Example',
          summarize: false,
          path: 'lib/pages/docs/components/tab_pane/tab_pane_example_1.dart',
          child: TabPaneExample1(),
        ),
      ],
    );
  }
}
