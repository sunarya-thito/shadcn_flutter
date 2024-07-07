import 'package:example/pages/docs/components/popover/popover_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class PopoverExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'popover',
      description:
          'A floating message that appears when a user interacts with a target.',
      displayName: 'Popover',
      children: [
        WidgetUsageExample(
          title: 'Popover Example',
          child: PopoverExample1(),
          path: 'lib/pages/docs/components/popover/popover_example_1.dart',
        ),
      ],
    );
  }
}
