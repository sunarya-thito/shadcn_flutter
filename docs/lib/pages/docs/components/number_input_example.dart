import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/number_input/number_input_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NumberInputExample extends StatelessWidget {
  const NumberInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'number_input',
      description:
          'A number input field with buttons to increase or decrease the value.',
      displayName: 'Number Input',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/number_input/number_input_example_1.dart',
          child: NumberInputExample1(),
        ),
      ],
    );
  }
}
