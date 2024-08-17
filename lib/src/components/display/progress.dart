import 'package:shadcn_flutter/shadcn_flutter.dart';

class Progress extends StatelessWidget {
  final double? progress;
  final double min;
  final double max;
  final bool disableAnimation;
  final Color? color;
  final Color? backgroundColor;
  const Progress({
    super.key,
    this.progress,
    this.min = 0.0,
    this.max = 1.0,
    this.disableAnimation = false,
    this.color,
    this.backgroundColor,
  }) : assert(progress != null && progress >= min && progress <= max,
            'Progress must be between min and max');

  double? get normalizedValue {
    if (progress == null) {
      return null;
    }
    return (progress! - min) / (max - min);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LinearProgressIndicator(
      value: normalizedValue,
      backgroundColor: backgroundColor,
      color: color,
      minHeight: 8.0,
      borderRadius: theme.borderRadiusSm,
      disableAnimation: disableAnimation,
    );
  }
}
