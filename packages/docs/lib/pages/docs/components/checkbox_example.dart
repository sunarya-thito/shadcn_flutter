import 'package:docs/pages/docs/components/checkbox/checkbox_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'checkbox/checkbox_example_2.dart';

class CheckboxExample extends StatelessWidget {
  const CheckboxExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'checkbox',
      description:
          'Checkboxes allow the user to select one or more items from a set.',
      displayName: 'Checkbox',
      children: [
        WidgetUsageExample(
          title: 'Checkbox Example',
          path: 'lib/pages/docs/components/checkbox/checkbox_example_1.dart',
          child: CheckboxExample1(),
        ),
        WidgetUsageExample(
          title: 'Checkbox Example with Tristate',
          path: 'lib/pages/docs/components/checkbox/checkbox_example_2.dart',
          child: CheckboxExample2(),
        ),
      ],
    );
  }
}
