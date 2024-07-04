import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'divider/divider_example_1.dart';
import 'divider/divider_example_2.dart';
import 'divider/divider_example_3.dart';

class DividerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'divider',
      description:
          'A divider is a thin line that groups content in lists and layouts.',
      displayName: 'Divider',
      children: [
        WidgetUsageExample(
          title: 'Horizontal Divider Example',
          child: DividerExample1(),
          path: 'lib/pages/docs/components/divider/divider_example_1.dart',
        ),
        WidgetUsageExample(
          title: 'Vertical Divider Example',
          child: DividerExample2(),
          path: 'lib/pages/docs/components/divider/divider_example_2.dart',
        ),
        WidgetUsageExample(
          title: 'Divider with Text Example',
          child: DividerExample3(),
          path: 'lib/pages/docs/components/divider/divider_example_3.dart',
        ),
      ],
    );
  }
}
