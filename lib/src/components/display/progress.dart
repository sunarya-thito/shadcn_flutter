import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A theme for [Progress].
class ProgressTheme {
  /// The color of the progress.
  final Color? color;

  /// The background color of the progress.
  final Color? backgroundColor;

  /// The border radius of the progress.
  final BorderRadiusGeometry? borderRadius;

  /// The minimum height of the progress.
  final double? minHeight;

  /// Creates a [ProgressTheme].
  const ProgressTheme({
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.minHeight,
  });

  /// Creates a copy of this theme but with the given fields replaced with the new values.
  ProgressTheme copyWith({
    Color? color,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius,
    double? minHeight,
  }) {
    return ProgressTheme(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      minHeight: minHeight ?? this.minHeight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProgressTheme) return false;
    return other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.borderRadius == borderRadius &&
        other.minHeight == minHeight;
  }

  @override
  int get hashCode => Object.hash(
        color,
        backgroundColor,
        borderRadius,
        minHeight,
      );
}

/// A progress indicator that shows the progress of a task.
class Progress extends StatelessWidget {
  /// The progress value.
  final double? progress;

  /// The minimum value of the progress.
  final double min;

  /// The maximum value of the progress.
  final double max;

  /// Whether to disable the animation of the progress.
  final bool disableAnimation;

  /// The color of the progress.
  final Color? color;

  /// The background color of the progress.
  final Color? backgroundColor;

  /// Creates a new [Progress] instance.
  const Progress({
    super.key,
    this.progress,
    this.min = 0.0,
    this.max = 1.0,
    this.disableAnimation = false,
    this.color,
    this.backgroundColor,
  }) : assert(progress == null || progress >= min && progress <= max,
            'Progress must be between min and max');

  /// The normalized value of the progress.
  double? get normalizedValue {
    if (progress == null) {
      return null;
    }
    return (progress! - min) / (max - min);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ProgressTheme>(context);
    return LinearProgressIndicator(
      value: normalizedValue,
      backgroundColor: styleValue(
          defaultValue: backgroundColor,
          themeValue: compTheme?.backgroundColor),
      color: styleValue(
          themeValue: compTheme?.color, widgetValue: color, defaultValue: null),
      minHeight: styleValue(
          defaultValue: 8.0 * theme.scaling, themeValue: compTheme?.minHeight),
      borderRadius: styleValue(
          defaultValue: theme.borderRadiusSm,
          themeValue: compTheme?.borderRadius),
      disableAnimation: disableAnimation,
    );
  }
}
