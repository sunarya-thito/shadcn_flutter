import 'package:example/pages/docs/components/radio_group/radio_group_example_1.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class RadioGroupExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'radio_group',
      description: 'A radio group is a group of radio buttons.',
      displayName: 'Radio Group',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: RadioGroupExample1(),
          path:
              'lib/pages/docs/components/radio_group/radio_group_example_1.dart',
        ),
      ],
    );
  }
}
