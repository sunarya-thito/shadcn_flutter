import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/multiselect/multiselect_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MultiSelectExample extends StatelessWidget {
  const MultiSelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'multiselect',
      description:
          'A multi-select component that allows users to select multiple items from a list.',
      displayName: 'Multi Select',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/multiselect/multiselect_example_1.dart',
          child: MultiSelectExample1(),
        ),
      ],
    );
  }
}
