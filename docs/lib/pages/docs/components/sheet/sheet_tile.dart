import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SheetTile extends StatelessWidget implements IComponentPage {
  const SheetTile({super.key});

  @override
  String get title => 'Sheet';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Sheet',
      name: 'sheet',
      verticalOffset: 0,
      scale: 1,
      example: SheetWrapper(
        position: OverlayPosition.right,
        stackIndex: 0,
        size: const Size(300, 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sheet!').large().medium(),
            const Gap(4),
            const Text('This is a sheet that you can use to display content')
                .muted(),
          ],
        ).withPadding(horizontal: 32, vertical: 48),
      ).sized(width: 300, height: 300),
    );
  }
}
