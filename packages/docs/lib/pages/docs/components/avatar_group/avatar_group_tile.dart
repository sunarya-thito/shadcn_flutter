import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AvatarGroupTile extends StatelessWidget implements IComponentPage {
  const AvatarGroupTile({super.key});

  @override
  String get title => 'Avatar Group';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'avatar_group',
      title: 'Avatar Group',
      scale: 1.5,
      center: true,
      example: AvatarGroup.toLeft(children: [
        Avatar(
          initials: Avatar.getInitials('sunarya-thito'),
          backgroundColor: material.Colors.red,
        ),
        Avatar(
          initials: Avatar.getInitials('sunarya-thito'),
          backgroundColor: material.Colors.green,
        ),
        Avatar(
          initials: Avatar.getInitials('sunarya-thito'),
          backgroundColor: material.Colors.blue,
        ),
        Avatar(
          initials: Avatar.getInitials('sunarya-thito'),
          backgroundColor: material.Colors.yellow,
        ),
      ]),
    );
  }
}
