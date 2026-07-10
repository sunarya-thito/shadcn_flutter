import 'package:docs/pages/docs/components/avatar/avatar_example_1.dart';
import 'package:docs/pages/docs/components/avatar/avatar_example_2.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'avatar/avatar_example_3.dart';

class AvatarExample extends StatelessWidget {
  const AvatarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'avatar',
      description: 'Avatars are used to represent people or objects.',
      displayName: 'Avatar',
      children: [
        WidgetUsageExample(
          title: 'Avatar Example',
          path: 'lib/pages/docs/components/avatar/avatar_example_1.dart',
          child: AvatarExample1(),
        ),
        WidgetUsageExample(
          title: 'Avatar Example with Username Initials',
          path: 'lib/pages/docs/components/avatar/avatar_example_2.dart',
          child: AvatarExample2(),
        ),
        WidgetUsageExample(
          title: 'Avatar Example with Badge',
          path: 'lib/pages/docs/components/avatar/avatar_example_3.dart',
          child: AvatarExample3(),
        ),
      ],
    );
  }
}
