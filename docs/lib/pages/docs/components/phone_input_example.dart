import 'package:docs/pages/docs/components/phone_input/phone_input_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class PhoneInputExample extends StatelessWidget {
  const PhoneInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'phone_input',
      description: 'A widget that allows users to input phone numbers.',
      displayName: 'Phone Input',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/phone_input/phone_input_example_1.dart',
          child: PhoneInputExample1(),
        ),
      ],
    );
  }
}
