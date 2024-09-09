import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShadcnSkeletonizerConfigLayer extends StatelessWidget {
  final ThemeData theme;
  final Widget child;

  const ShadcnSkeletonizerConfigLayer({
    super.key,
    required this.theme,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonizerConfig(
        data: SkeletonizerConfigData(
          effect: PulseEffect(
            duration: const Duration(seconds: 1),
            from: theme.colorScheme.primary.scaleAlpha(0.05),
            to: theme.colorScheme.primary.scaleAlpha(0.1),
          ),
          enableSwitchAnimation: true,
        ),
        child: child);
  }
}

extension SkeletonExtension on Widget {
  Widget asSkeletonSliver({bool enabled = true}) {
    return Skeletonizer(
      enabled: enabled,
      ignoreContainers: false,
      child: this,
    );
  }

  Widget asSkeleton(
      {bool enabled = true,
      bool leaf = false,
      Widget? replacement,
      bool unite = false,
      AsyncSnapshot? snapshot}) {
    if (snapshot != null) {
      enabled = !snapshot.hasData;
    }
    if (this is Avatar || this is Image) {
      // https://github.com/Milad-Akarie/skeletonizer/issues/17
      return Skeleton.leaf(
        enabled: enabled,
        child: this,
      );
    }
    if (unite) {
      return Skeleton.unite(
        unite: enabled,
        child: this,
      );
    }
    if (replacement != null) {
      return Skeleton.replace(
        replace: enabled,
        child: replacement,
      );
    }
    if (leaf) {
      return Skeleton.leaf(
        enabled: enabled,
        child: this,
      );
    }
    return Skeletonizer(
      enabled: enabled,
      child: this,
    );
  }

  Widget ignoreSkeleton() {
    return Skeleton.ignore(child: this);
  }

  Widget excludeSkeleton({bool exclude = true}) {
    return Skeleton.keep(
      keep: exclude,
      child: this,
    );
  }
}
