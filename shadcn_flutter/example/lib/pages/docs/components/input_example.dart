import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'input/input_example_1.dart';
import 'input/input_example_2.dart';

class InputExample extends StatelessWidget {
  const InputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'input',
      description: 'An input is a field used to elicit a response from a user.',
      displayName: 'Input',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/input/input_example_1.dart',
          child: InputExample1(),
        ),
        WidgetUsageExample(
          title: 'Initial Value Example',
          path: 'lib/pages/docs/components/input/input_example_2.dart',
          child: InputExample2(),
        ),
      ],
    );
  }
}
