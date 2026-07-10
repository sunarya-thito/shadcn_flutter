import 'package:docs/pages/docs/components/switch/switch_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class SwitchExample extends StatelessWidget {
  const SwitchExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'switch',
      description:
          'A switch is a visual toggle between two mutually exclusive states — on and off.',
      displayName: 'Switch',
      children: [
        WidgetUsageExample(
          title: 'Switch Example',
          path: 'lib/pages/docs/components/switch/switch_example_1.dart',
          child: SwitchExample1(),
        ),
      ],
    );
  }
}
