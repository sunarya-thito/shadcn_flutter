import 'package:docs/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import 'keyboard_display/keyboard_display_example_1.dart';

class KeyboardDisplayExample extends StatelessWidget {
  const KeyboardDisplayExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'keyboard_display',
      description: 'A widget that displays a keyboard key.',
      displayName: 'Keyboard Display',
      children: [
        WidgetUsageExample(
          title: 'Example 1',
          path:
              'lib/pages/docs/components/keyboard_display/keyboard_display_example_1.dart',
          child: KeyboardDisplayExample1(),
        ),
      ],
    );
  }
}
