import 'package:shadcn_flutter/shadcn_flutter.dart';

class AvatarExample1 extends StatelessWidget {
  const AvatarExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Avatar(
      backgroundColor: Colors.red,
      initials: Avatar.getInitials('sunarya-thito'),
      provider: const NetworkImage(
          'https://avatars.githubusercontent.com/u/64018564?v=4'),
    );
  }
}
