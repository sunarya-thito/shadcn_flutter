import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'autocomplete/autocomplete_example_1.dart';

class AutoCompleteExample extends StatelessWidget {
  const AutoCompleteExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'autocomplete',
      description: 'A text input with suggestions.',
      displayName: 'AutoComplete',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/autocomplete/autocomplete_example_1.dart',
          child: AutoCompleteExample1(),
        ),
      ],
    );
  }
}
