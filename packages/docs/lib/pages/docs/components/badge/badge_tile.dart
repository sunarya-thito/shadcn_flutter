import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class BadgeTile extends StatelessWidget implements IComponentPage {
  const BadgeTile({super.key});

  @override
  String get title => 'Badge';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'badge',
      title: 'Badge',
      center: true,
      scale: 1.5,
      example: const Column(
        children: [
          PrimaryBadge(child: Text('Primary')),
          SecondaryBadge(child: Text('Secondary')),
          DestructiveBadge(child: Text('Destructive')),
        ],
      ).gap(8),
    );
  }
}
