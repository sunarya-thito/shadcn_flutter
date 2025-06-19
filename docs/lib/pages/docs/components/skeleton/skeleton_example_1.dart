import 'package:shadcn_flutter/shadcn_flutter.dart';

class SkeletonExample1 extends StatelessWidget {
  const SkeletonExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Basic(
          title: Text('Skeleton Example 1'),
          content:
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          leading: Avatar(
            initials: '',
          ),
          trailing: Icon(Icons.arrow_forward),
        ),
        const Gap(24),
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
    );
  }
}
