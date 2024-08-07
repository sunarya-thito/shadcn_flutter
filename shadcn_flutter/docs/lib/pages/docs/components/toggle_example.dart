import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/toggle/toggle_example_1.dart';
import 'package:docs/pages/docs/components/toggle/toggle_example_2.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ToggleExample extends StatelessWidget {
  const ToggleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'toggle',
      description:
          'Toggle is a widget that can be used to switch between two states.',
      displayName: 'Toggle',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/toggle/toggle_example_1.dart',
          child: ToggleExample1(),
        ),
        WidgetUsageExample(
          title: 'Group Example',
          path: 'lib/pages/docs/components/toggle/toggle_example_2.dart',
          child: ToggleExample2(),
        )
      ],
    );
  }
}
