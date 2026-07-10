import 'package:docs/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import 'app_bar/app_bar_example_1.dart';

class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'app_bar',
      description: 'An app bar is a bar that appears at the top of the screen.',
      displayName: 'App Bar',
      children: [
        WidgetUsageExample(
          title: 'Example 1',
          path: 'lib/pages/docs/components/app_bar/app_bar_example_1.dart',
          child: AppBarExample1(),
        ),
      ],
    );
  }
}
