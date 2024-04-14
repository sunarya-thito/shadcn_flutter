import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'badge/badge_example_1.dart';
import 'badge/badge_example_2.dart';
import 'badge/badge_example_3.dart';
import 'badge/badge_example_4.dart';

class BadgeExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'badge',
      description: 'Badges are small status descriptors for UI elements.',
      displayName: 'Badge',
      children: [
        WidgetUsageExample(
          child: BadgeExample1(),
          path: 'lib/pages/docs/components/badge/badge_example_1.dart',
        ),
        WidgetUsageExample(
          child: BadgeExample2(),
          path: 'lib/pages/docs/components/badge/badge_example_2.dart',
        ),
        WidgetUsageExample(
          child: BadgeExample3(),
          path: 'lib/pages/docs/components/badge/badge_example_3.dart',
        ),
        WidgetUsageExample(
          child: BadgeExample4(),
          path: 'lib/pages/docs/components/badge/badge_example_4.dart',
        ),
      ],
    );
  }
}
