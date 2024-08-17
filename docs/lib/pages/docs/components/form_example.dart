import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/form/form_example_3.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import 'form/form_example_1.dart';
import 'form/form_example_2.dart';

class FormExample extends StatelessWidget {
  const FormExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'form',
      description: 'A helper widget that makes it easy to validate forms.',
      displayName: 'Form',
      children: [
        WidgetUsageExample(
          title: 'Form Example (Table Layout)',
          path: 'lib/pages/docs/components/form/form_example_1.dart',
          child: FormExample1(),
        ),
        WidgetUsageExample(
          title: 'Form Example (Column Layout)',
          path: 'lib/pages/docs/components/form/form_example_2.dart',
          child: FormExample2(),
        ),
        WidgetUsageExample(
          title: 'Validation Mode Example',
          path: 'lib/pages/docs/components/form/form_example_3.dart',
          child: FormExample3(),
        ),
      ],
    );
  }
}
