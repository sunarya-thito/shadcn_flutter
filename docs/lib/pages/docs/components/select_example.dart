import 'package:docs/pages/docs/components/select/select_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class SelectExample extends StatelessWidget {
  const SelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'select',
      description:
          'A select component that allows you to select an item from a list of items.',
      displayName: 'Select',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/select/select_example_1.dart',
          child: SelectExample1(),
        ),
      ],
    );
  }
}
