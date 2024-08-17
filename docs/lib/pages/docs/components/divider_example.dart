import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'divider/divider_example_1.dart';
import 'divider/divider_example_2.dart';
import 'divider/divider_example_3.dart';

class DividerExample extends StatelessWidget {
  const DividerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'divider',
      description:
          'A divider is a thin line that groups content in lists and layouts.',
      displayName: 'Divider',
      children: [
        WidgetUsageExample(
          title: 'Horizontal Divider Example',
          path: 'lib/pages/docs/components/divider/divider_example_1.dart',
          child: DividerExample1(),
        ),
        WidgetUsageExample(
          title: 'Vertical Divider Example',
          path: 'lib/pages/docs/components/divider/divider_example_2.dart',
          child: DividerExample2(),
        ),
        WidgetUsageExample(
          title: 'Divider with Text Example',
          path: 'lib/pages/docs/components/divider/divider_example_3.dart',
          child: DividerExample3(),
        ),
      ],
    );
  }
}
