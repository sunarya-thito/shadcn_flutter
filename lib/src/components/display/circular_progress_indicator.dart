import 'package:flutter/material.dart' as mat;

import '../../../shadcn_flutter.dart';

/// Theme data for [CircularProgressIndicator].
class CircularProgressIndicatorTheme {
  /// Color of the progress indicator.
  final Color? color;

  /// Background color of the progress indicator.
  final Color? backgroundColor;

  /// Size of the progress indicator.
  final double? size;

  /// Stroke width of the progress indicator.
  final double? strokeWidth;

  const CircularProgressIndicatorTheme({
    this.color,
    this.backgroundColor,
    this.size,
    this.strokeWidth,
  });

  CircularProgressIndicatorTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<double?>? size,
    ValueGetter<double?>? strokeWidth,
  }) {
    return CircularProgressIndicatorTheme(
      color: color == null ? this.color : color(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      size: size == null ? this.size : size(),
      strokeWidth: strokeWidth == null ? this.strokeWidth : strokeWidth(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CircularProgressIndicatorTheme &&
        other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.size == size &&
        other.strokeWidth == strokeWidth;
  }

  @override
  int get hashCode => Object.hash(
        color,
        backgroundColor,
        size,
        strokeWidth,
      );
}

class CircularProgressIndicator extends StatelessWidget {
  final double? value;

  /// Explicit size for the indicator.
  final double? size;

  /// Color of the indicator.
  final Color? color;

  /// Background color of the indicator.
  final Color? backgroundColor;

  /// Stroke width of the indicator.
  final double? strokeWidth;

  final Duration duration;
  final bool animated;
  final bool onSurface;

  const CircularProgressIndicator({
    super.key,
    this.value,
    this.size,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
    this.duration = kDefaultDuration,
    this.animated = true,
    this.onSurface = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconThemeData = IconTheme.of(context);
    final theme = Theme.of(context);
    final compTheme =
        ComponentTheme.maybeOf<CircularProgressIndicatorTheme>(context);

    final effectiveSize = styleValue(
        widgetValue: size,
        themeValue: compTheme?.size,
        defaultValue:
            (iconThemeData.size ?? 24 * theme.scaling) - 8 * theme.scaling);

    final effectiveColor = styleValue(
        widgetValue: color,
        themeValue: compTheme?.color,
        defaultValue: onSurface
            ? theme.colorScheme.background
            : theme.colorScheme.primary);

    final effectiveBackgroundColor = styleValue(
        widgetValue: backgroundColor,
        themeValue: compTheme?.backgroundColor,
        defaultValue: effectiveColor.scaleAlpha(0.2));

    final effectiveStrokeWidth = styleValue(
        widgetValue: strokeWidth,
        themeValue: compTheme?.strokeWidth,
        defaultValue: effectiveSize / 12);

    if (value == null || !animated) {
      return RepaintBoundary(
        child: SizedBox(
          width: effectiveSize,
          height: effectiveSize,
          child: mat.CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            color: effectiveColor,
            backgroundColor: effectiveBackgroundColor,
            strokeWidth: effectiveStrokeWidth,
            value: value,
          ),
        ),
      );
    } else {
      return AnimatedValueBuilder(
        value: value!,
        duration: duration,
        builder: (context, value, child) {
          return RepaintBoundary(
            child: SizedBox(
              width: effectiveSize,
              height: effectiveSize,
              child: mat.CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
                color: effectiveColor,
                backgroundColor: effectiveBackgroundColor,
                strokeWidth: effectiveStrokeWidth,
                value: value,
              ),
            ),
          );
        },
      );
    }
  }
}
