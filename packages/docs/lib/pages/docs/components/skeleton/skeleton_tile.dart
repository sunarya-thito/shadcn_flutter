import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class SkeletonTile extends StatelessWidget implements IComponentPage {
  const SkeletonTile({super.key});

  @override
  String get title => 'Skeleton';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Skeleton',
      name: 'skeleton',
      scale: 1,
      example: Card(
        child: Column(
          children: [
            Basic(
              title: const Text('Skeleton Example 1'),
              content: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              leading: const Avatar(
                initials: '',
              ).asSkeleton(),
              // Note: Avatar and other Image related widget needs its own skeleton
              trailing: const Icon(Icons.arrow_forward),
            ).asSkeleton(),
            const Gap(16),
            Basic(
              title: const Text('Skeleton Example 1'),
              content: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              leading: const Avatar(
                initials: '',
              ).asSkeleton(),
              // Note: Avatar and other Image related widget needs its own skeleton
              trailing: const Icon(Icons.arrow_forward),
            ).asSkeleton(),
            const Gap(16),
            Basic(
              title: const Text('Skeleton Example 1'),
              content: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
              leading: const Avatar(
                initials: '',
              ).asSkeleton(),
              // Note: Avatar and other Image related widget needs its own skeleton
              trailing: const Icon(Icons.arrow_forward),
            ).asSkeleton(),
          ],
        ),
      ).sized(height: 300),
    );
  }
}
