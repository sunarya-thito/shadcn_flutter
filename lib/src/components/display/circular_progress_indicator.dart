import 'package:flutter/material.dart' as mat;

import '../../../shadcn_flutter.dart';

class CircularProgressIndicator extends StatelessWidget {
  final double? value;
  final double? size;
  final Duration duration;
  final bool animated;
  final bool onSurface;

  const CircularProgressIndicator({
    super.key,
    this.value,
    this.size,
    this.duration = kDefaultDuration,
    this.animated = true,
    this.onSurface = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconThemeData = IconTheme.of(context);
    final theme = Theme.of(context);
    var color =
        onSurface ? theme.colorScheme.background : theme.colorScheme.primary;
    if (value == null || !animated) {
      return RepaintBoundary(
        child: SizedBox(
          width: size ??
              (iconThemeData.size ?? 24 * theme.scaling) - 8 * theme.scaling,
          height: size ??
              (iconThemeData.size ?? 24 * theme.scaling) - 8 * theme.scaling,
          child: mat.CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color,
            ),
            color: color,
            backgroundColor: color.scaleAlpha(0.2),
            strokeWidth:
                (size ?? (iconThemeData.size ?? (theme.scaling * 24))) / 12,
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
              width: size ??
                  (iconThemeData.size ?? (theme.scaling * 24)) -
                      (theme.scaling * 8),
              height: size ??
                  (iconThemeData.size ?? (theme.scaling * 24)) -
                      (theme.scaling * 8),
              child: mat.CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  color,
                ),
                color: color,
                backgroundColor: color.scaleAlpha(0.2),
                strokeWidth:
                    (size ?? (iconThemeData.size ?? (theme.scaling * 24))) / 12,
                value: value,
              ),
            ),
          );
        },
      );
    }
  }
}
