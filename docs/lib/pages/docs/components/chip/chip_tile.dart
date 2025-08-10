import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChipTile extends StatelessWidget implements IComponentPage {
  const ChipTile({super.key});

  @override
  String get title => 'Chip';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'chip',
      title: 'Chip',
      scale: 1.5,
      example: Card(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(
              child: const Text('Default'),
              onPressed: () {},
            ),
            Chip(
              leading: const Icon(LucideIcons.user),
              child: const Text('With Icon'),
              onPressed: () {},
            ),
            Chip(
              child: const Text('Removable'),
              trailing: const Icon(LucideIcons.x),
              onPressed: () {},
            ),
            Chip(
              child: const Text('Disabled'),
            ),
          ],
        ).withPadding(all: 16),
      ),
    );
  }
}
