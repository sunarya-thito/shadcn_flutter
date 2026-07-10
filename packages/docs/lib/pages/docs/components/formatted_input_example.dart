import 'package:docs/pages/docs/components/formatted_input/formatted_input_example_2.dart';
import 'package:docs/pages/docs/components/formatted_input/formatted_input_example_3.dart';
import 'package:docs/pages/docs/components/formatted_input/formatted_input_example_4.dart';
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
        WidgetUsageExample(
          title: 'Date Input Example',
          path:
              'lib/pages/docs/components/formatted_input/formatted_input_example_2.dart',
          child: FormattedInputExample2(),
        ),
        WidgetUsageExample(
          title: 'Time Input Example',
          path:
              'lib/pages/docs/components/formatted_input/formatted_input_example_3.dart',
          child: FormattedInputExample3(),
        ),
        WidgetUsageExample(
          title: 'Duration Input Example',
          path:
              'lib/pages/docs/components/formatted_input/formatted_input_example_4.dart',
          child: FormattedInputExample4(),
        ),
      ],
    );
  }
}
