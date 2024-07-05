import 'package:example/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import 'form/form_example_1.dart';
import 'form/form_example_2.dart';

class FormExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'form',
      description: 'A helper widget that makes it easy to validate forms.',
      displayName: 'Form',
      children: [
        WidgetUsageExample(
          title: 'Form Example (Table Layout)',
          child: FormExample1(),
          path: 'lib/pages/docs/components/form/form_example_1.dart',
        ),
        WidgetUsageExample(
          title: 'Form Example (Column Layout)',
          child: FormExample2(),
          path: 'lib/pages/docs/components/form/form_example_2.dart',
        ),
      ],
    );
  }
}
