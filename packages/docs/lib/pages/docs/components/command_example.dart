import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'command/command_example_1.dart';

class CommandExample extends StatelessWidget {
  const CommandExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'command',
      description:
          'A command is a component that allows you to search for items.',
      displayName: 'Command',
      children: [
        WidgetUsageExample(
          title: 'Command Example',
          path: 'lib/pages/docs/components/command/command_example_1.dart',
          child: CommandExample1(),
        ),
      ],
    );
  }
}
