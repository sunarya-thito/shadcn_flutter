import 'package:flutter/material.dart' as m;
import 'package:shadcn_flutter/shadcn_flutter.dart';

// delegates from LinearProgressIndicator (material) to a custom styled LinearProgressIndicator
class LinearProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? backgroundColor;
  final double? minHeight;
  final Color? color;
  final BorderRadius? borderRadius;
  final String? semanticsLabel;
  final String? semanticsValue;

  const LinearProgressIndicator({
    Key? key,
    this.value,
    this.backgroundColor,
    this.minHeight,
    this.color,
    this.borderRadius,
    this.semanticsLabel,
    this.semanticsValue,
  }) : super(key: key);

  @override
  Widget build(m.BuildContext context) {
    final theme = Theme.of(context);
    return m.LinearProgressIndicator(
      value: value,
      backgroundColor:
          backgroundColor ?? theme.colorScheme.primary.withOpacity(0.2),
      minHeight: minHeight ?? 4,
      color: color ?? theme.colorScheme.primary,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
    );
  }
}
