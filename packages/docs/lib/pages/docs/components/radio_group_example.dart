import 'package:docs/pages/docs/components/radio_group/radio_group_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class RadioGroupExample extends StatelessWidget {
  const RadioGroupExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'radio_group',
      description: 'A radio group is a group of radio buttons.',
      displayName: 'Radio Group',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/radio_group/radio_group_example_1.dart',
          child: RadioGroupExample1(),
        ),
      ],
    );
  }
}
