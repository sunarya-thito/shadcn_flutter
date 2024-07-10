import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/toggle/toggle_example_1.dart';
import 'package:example/pages/docs/components/toggle/toggle_example_2.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ToggleExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'toggle',
      description:
          'Toggle is a widget that can be used to switch between two states.',
      displayName: 'Toggle',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: ToggleExample1(),
          path: 'lib/pages/docs/components/toggle/toggle_example_1.dart',
        ),
        WidgetUsageExample(
          title: 'Group Example',
          child: ToggleExample2(),
          path: 'lib/pages/docs/components/toggle/toggle_example_2.dart',
        )
      ],
    );
  }
}
