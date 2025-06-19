import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'badge/badge_example_1.dart';
import 'badge/badge_example_2.dart';
import 'badge/badge_example_3.dart';
import 'badge/badge_example_4.dart';

class BadgeExample extends StatelessWidget {
  const BadgeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'badge',
      description: 'Badges are small status descriptors for UI elements.',
      displayName: 'Badge',
      children: [
        WidgetUsageExample(
          title: 'Primary Badge Example',
          path: 'lib/pages/docs/components/badge/badge_example_1.dart',
          child: BadgeExample1(),
        ),
        WidgetUsageExample(
          title: 'Secondary Badge Example',
          path: 'lib/pages/docs/components/badge/badge_example_2.dart',
          child: BadgeExample2(),
        ),
        WidgetUsageExample(
          title: 'Outline Badge Example',
          path: 'lib/pages/docs/components/badge/badge_example_3.dart',
          child: BadgeExample3(),
        ),
        WidgetUsageExample(
          title: 'Destructive Badge Example',
          path: 'lib/pages/docs/components/badge/badge_example_4.dart',
          child: BadgeExample4(),
        ),
      ],
    );
  }
}
