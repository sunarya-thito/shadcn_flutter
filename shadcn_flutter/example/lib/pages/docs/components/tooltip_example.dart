import 'package:example/pages/docs/components/tooltip/tooltip_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TooltipExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'tooltip',
      description:
          'A floating message that appears when a user interacts with a target.',
      displayName: 'Tooltip',
      children: [
        WidgetUsageExample(
          title: 'Tooltip Example',
          child: TooltipExample1(),
          path: 'lib/pages/docs/components/tooltip/tooltip_example_1.dart',
        ),
      ],
    );
  }
}
