import 'package:docs/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import 'avatar_group/avatar_group_example_1.dart';

class AvatarGroupExample extends StatelessWidget {
  const AvatarGroupExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'avatar_group',
      description: 'Show a group of avatars.',
      displayName: 'Avatar Group',
      children: [
        WidgetUsageExample(
          title: 'Avatar Group Example 1',
          path:
              'lib/pages/docs/components/avatar_group/avatar_group_example_1.dart',
          child: AvatarGroupExample1(),
        ),
      ],
    );
  }
}
