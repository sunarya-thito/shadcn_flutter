import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'formatted_input/formatted_input_example_1.dart';

class FormattedInputExample extends StatelessWidget {
  const FormattedInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'formatted_input',
      description: 'Text input with formatted parts.',
      displayName: 'Formatted Input',
      children: [
        WidgetUsageExample(
          title: 'Formatted Input Example',
          path:
              'lib/pages/docs/components/formatted_input/formatted_input_example_1.dart',
          child: FormattedInputExample1(),
        ),
      ],
    );
  }
}
