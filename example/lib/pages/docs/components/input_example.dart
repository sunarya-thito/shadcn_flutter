import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'input/input_example_1.dart';
import 'input/input_example_2.dart';

class InputExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'input',
      description: 'An input is a field used to elicit a response from a user.',
      displayName: 'Input',
      children: [
        WidgetUsageExample(
          title: 'Input Example',
          child: InputExample1(),
          path: 'lib/pages/docs/components/input/input_example_1.dart',
        ),
        WidgetUsageExample(
          title: 'Input with Initial Value Example',
          child: InputExample2(),
          path: 'lib/pages/docs/components/input/input_example_2.dart',
        ),
      ],
    );
  }
}
