import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DrawerTile extends StatelessWidget implements IComponentPage {
  const DrawerTile({super.key});

  @override
  String get title => 'Drawer';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Drawer',
      name: 'drawer',
      scale: 1,
      example: DrawerWrapper(
        stackIndex: 0,
        position: OverlayPosition.bottom,
        size: const Size(300, 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Drawer!').large().medium(),
            const Gap(4),
            const Text('This is a drawer that you can use to display content')
                .muted(),
          ],
        ).withPadding(horizontal: 32),
      ).sized(width: 300, height: 300),
    );
  }
}
