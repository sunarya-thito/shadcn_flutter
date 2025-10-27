import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Simple Avatar with initials only.
///
/// Demonstrates customizing the avatar [size] while displaying
/// just the text initials (no image provider).
class AvatarExample2 extends StatelessWidget {
  const AvatarExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Avatar(
      // Use initials when you don't have an image.
      initials: Avatar.getInitials('sunarya-thito'),
      size: 64,
    );
  }
}
