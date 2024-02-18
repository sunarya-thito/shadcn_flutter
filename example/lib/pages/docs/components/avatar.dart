import 'package:flutter/widgets.dart';
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
          builder: (context) {
            return Avatar(
              initials: Avatar.getInitials('sunarya-thito'),
              photoUrl: 'https://avatars.githubusercontent.com/u/64018564?v=4',
            );
          },
          code: '''
Avatar(
  initials: Avatar.getInitials('sunarya-thito'),
  photoUrl: 'https://avatars.githubusercontent.com/u/64018564?v=4',
)''',
        ),
        WidgetUsageExample(
          builder: (context) {
            return Avatar(
              initials: Avatar.getInitials('sunarya-thito'),
              size: 64,
            );
          },
          code: '''
Avatar(
  initials: Avatar.getInitials('sunarya-thito'),
  size: 64,
)''',
        ),
      ],
    );
  }
}
