import 'package:shadcn_flutter/shadcn_flutter.dart';

/// AvatarGroup directions demo.
///
/// Displays the same set of avatars grouped in four different stacking
/// directions: left, right, top, and bottom. Useful for dense displays
/// where overlapping avatars save space.
class AvatarGroupExample1 extends StatefulWidget {
  const AvatarGroupExample1({super.key});

  @override
  State<AvatarGroupExample1> createState() => _AvatarGroupExample1State();
}

class _AvatarGroupExample1State extends State<AvatarGroupExample1> {
  /// Helper that returns a few colored avatars to visualize overlap.
  List<AvatarWidget> getAvatars() {
    return [
      Avatar(
        initials: Avatar.getInitials('sunarya-thito'),
        backgroundColor: Colors.red,
      ),
      Avatar(
        initials: Avatar.getInitials('sunarya-thito'),
        backgroundColor: Colors.green,
      ),
      Avatar(
        initials: Avatar.getInitials('sunarya-thito'),
        backgroundColor: Colors.blue,
      ),
      Avatar(
        initials: Avatar.getInitials('sunarya-thito'),
        backgroundColor: Colors.yellow,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        // Overlap avatars towards the left.
        AvatarGroup.toLeft(children: getAvatars()),
        // Overlap avatars towards the right.
        AvatarGroup.toRight(children: getAvatars()),
        // Stack vertically upwards.
        AvatarGroup.toTop(children: getAvatars()),
        // Stack vertically downwards.
        AvatarGroup.toBottom(children: getAvatars()),
      ],
    );
  }
}
