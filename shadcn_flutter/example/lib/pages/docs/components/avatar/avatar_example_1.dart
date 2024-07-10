import 'package:shadcn_flutter/shadcn_flutter.dart';

class AvatarExample1 extends StatelessWidget {
  const AvatarExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Avatar(
      initials: Avatar.getInitials('sunarya-thito'),
      photoUrl: 'https://avatars.githubusercontent.com/u/64018564?v=4',
    );
  }
}
