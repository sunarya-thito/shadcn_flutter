import 'package:example/pages/docs/components/avatar/avatar_example_1.dart';
import 'package:example/pages/docs/components/avatar/avatar_example_2.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class AvatarExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'avatar',
      description: 'Avatars are used to represent people or objects.',
      displayName: 'Avatar',
      children: [
        WidgetUsageExample(
          child: AvatarExample1(),
          path: 'lib/pages/docs/components/avatar/avatar_example_1.dart',
        ),
        WidgetUsageExample(
          child: AvatarExample2(),
          path: 'lib/pages/docs/components/avatar/avatar_example_2.dart',
        ),
      ],
    );
  }
}
