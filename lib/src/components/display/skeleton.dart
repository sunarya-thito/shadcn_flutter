import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Theme for skeleton loading configuration.
class SkeletonTheme {
  /// Duration of the pulse effect.
  final Duration? duration;

  /// Starting color of the pulse effect.
  final Color? fromColor;

  /// Ending color of the pulse effect.
  final Color? toColor;

  /// Whether switching animation is enabled.
  final bool? enableSwitchAnimation;

  /// Creates a [SkeletonTheme].
  const SkeletonTheme({
    this.duration,
    this.fromColor,
    this.toColor,
    this.enableSwitchAnimation,
  });

  /// Returns a copy of this theme with the given fields replaced.
  SkeletonTheme copyWith({
    ValueGetter<Duration?>? duration,
    ValueGetter<Color?>? fromColor,
    ValueGetter<Color?>? toColor,
    ValueGetter<bool?>? enableSwitchAnimation,
  }) {
    return SkeletonTheme(
      duration: duration == null ? this.duration : duration(),
      fromColor: fromColor == null ? this.fromColor : fromColor(),
      toColor: toColor == null ? this.toColor : toColor(),
      enableSwitchAnimation: enableSwitchAnimation == null
          ? this.enableSwitchAnimation
          : enableSwitchAnimation(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SkeletonTheme &&
        other.duration == duration &&
        other.fromColor == fromColor &&
        other.toColor == toColor &&
        other.enableSwitchAnimation == enableSwitchAnimation;
  }

  @override
  int get hashCode =>
      Object.hash(duration, fromColor, toColor, enableSwitchAnimation);
}

class ShadcnSkeletonizerConfigLayer extends StatelessWidget {
  final ThemeData theme;
  final Widget child;
  final Duration? duration;
  final Color? fromColor;
  final Color? toColor;
  final bool? enableSwitchAnimation;

  const ShadcnSkeletonizerConfigLayer({
    super.key,
    required this.theme,
    required this.child,
    this.duration,
    this.fromColor,
    this.toColor,
    this.enableSwitchAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<SkeletonTheme>(context);
    final durationValue = styleValue(
      widgetValue: duration,
      themeValue: compTheme?.duration,
      defaultValue: const Duration(seconds: 1),
    );
    final fromValue = styleValue(
      widgetValue: fromColor,
      themeValue: compTheme?.fromColor,
      defaultValue: theme.colorScheme.primary.scaleAlpha(0.05),
    );
    final toValue = styleValue(
      widgetValue: toColor,
      themeValue: compTheme?.toColor,
      defaultValue: theme.colorScheme.primary.scaleAlpha(0.1),
    );
    final enableSwitchAnimationValue = styleValue(
      widgetValue: enableSwitchAnimation,
      themeValue: compTheme?.enableSwitchAnimation,
      defaultValue: true,
    );
    return SkeletonizerConfig(
      data: SkeletonizerConfigData(
        effect: PulseEffect(
          duration: durationValue,
          from: fromValue,
          to: toValue,
        ),
        enableSwitchAnimation: enableSwitchAnimationValue,
      ),
      child: child,
    );
  }
}

extension SkeletonExtension on Widget {
  Widget asSkeletonSliver({bool enabled = true}) {
    return Skeletonizer(enabled: enabled, ignoreContainers: false, child: this);
  }

  Widget asSkeleton({
    bool enabled = true,
    bool leaf = false,
    Widget? replacement,
    bool unite = false,
    AsyncSnapshot? snapshot,
  }) {
    if (snapshot != null) {
      enabled = !snapshot.hasData;
    }
    if (this is Avatar || this is Image) {
      // https://github.com/Milad-Akarie/skeletonizer/issues/17
      return Skeleton.leaf(enabled: enabled, child: this);
    }
    if (unite) {
      return Skeleton.unite(unite: enabled, child: this);
    }
    if (replacement != null) {
      return Skeleton.replace(replace: enabled, child: replacement);
    }
    if (leaf) {
      return Skeleton.leaf(enabled: enabled, child: this);
    }
    return Skeletonizer(enabled: enabled, child: this);
  }

  Widget ignoreSkeleton() {
    return Skeleton.ignore(child: this);
  }

  Widget excludeSkeleton({bool exclude = true}) {
    return Skeleton.keep(keep: exclude, child: this);
  }
}
