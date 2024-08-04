import 'package:flutter/material.dart' as mat;

import '../../../shadcn_flutter.dart';

class CircularProgressIndicator extends StatelessWidget {
  final double? value;
  final double? size;
  final Duration duration;
  final bool animated;

  const CircularProgressIndicator({
    Key? key,
    this.value,
    this.size,
    this.duration = kDefaultDuration,
    this.animated = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconThemeData = IconTheme.of(context);
    final theme = Theme.of(context);
    if (value == null || !animated) {
      return RepaintBoundary(
        child: SizedBox(
          width: size ??
              (iconThemeData.size ?? theme.scaling * 24) - theme.scaling * 8,
          height: size ??
              (iconThemeData.size ?? theme.scaling * 24) - theme.scaling * 8,
          child: mat.CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
            color: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
            strokeWidth: (size ?? (iconThemeData.size ?? theme.scaling * 24)) /
                theme.scaling *
                12,
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
                  (iconThemeData.size ?? theme.scaling * 24) -
                      theme.scaling * 8,
              height: size ??
                  (iconThemeData.size ?? theme.scaling * 24) -
                      theme.scaling * 8,
              child: mat.CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
                color: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                strokeWidth:
                    (size ?? (iconThemeData.size ?? theme.scaling * 24)) /
                        theme.scaling *
                        12,
                value: value,
              ),
            ),
          );
        },
      );
    }
  }
}
