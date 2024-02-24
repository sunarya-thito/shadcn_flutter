import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class Skeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey[300],
    );
  }
}

class SkeletonShimmer extends StatefulWidget {
  @override
  State<SkeletonShimmer> createState() => _SkeletonShimmerState();
}

class _SkeletonShimmerState extends State<SkeletonShimmer>
    with SingleTickerProviderStateMixin {
  // create fade animation from primary-bg/10 with opacity from 1 to 0.5 and back
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary
                .withOpacity(0.1 + 0.4 * _controller.value),
          ),
        );
      },
    );
  }
}

enum SkeletonShape {
  circle,
  roundedSmall,
  roundedMedium,
  roundedLarge;
}

abstract class SkeletonContent {
  const SkeletonContent();
}

class SkeletonItem extends SkeletonContent {
  final double? width;
  final double? height;
  final SkeletonShape shape;

  const SkeletonItem({
    this.width,
    this.height,
    this.shape = SkeletonShape.roundedSmall,
  });
}

class SkeletonRow extends SkeletonContent {
  final List<SkeletonContent> items;

  const SkeletonRow({
    required this.items,
  });
}

class SkeletonColumn extends SkeletonContent {
  final List<SkeletonContent> items;

  const SkeletonColumn({
    required this.items,
  });
}

class SkeletonText extends SkeletonContent {
  final double? length;
  final double fontSize;

  const SkeletonText({
    this.length,
    this.fontSize = 14,
  });

  const SkeletonText.xs({
    this.length,
  }) : fontSize = 12;

  const SkeletonText.sm({
    this.length,
  }) : fontSize = 14;

  const SkeletonText.md({
    this.length,
  }) : fontSize = 16;

  const SkeletonText.lg({
    this.length,
  }) : fontSize = 18;

  const SkeletonText.xl({
    this.length,
  }) : fontSize = 20;

  const SkeletonText.xxl({
    this.length,
  }) : fontSize = 24;
}
