import 'package:shadcn_flutter/shadcn_flutter.dart';

class SkeletonExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Basic(
          title: Text('Skeleton Example 1'),
          content:
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          leading: Avatar(
            initials: '',
          ),
          trailing: Icon(Icons.arrow_forward),
        ),
        gap(24),
        Basic(
          title: Text('Skeleton Example 1'),
          content:
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
          leading: Avatar(
            initials: '',
          ).asSkeleton(),
          // Note: Avatar and other Image related widget needs its own skeleton
          trailing: Icon(Icons.arrow_forward),
        ).asSkeleton(),
      ],
    );
  }
}
