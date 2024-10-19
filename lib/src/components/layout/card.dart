import 'package:shadcn_flutter/shadcn_flutter.dart';

class Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool filled;
  final Color? fillColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Clip clipBehavior;
  final List<BoxShadow>? boxShadow;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const Card({
    super.key,
    required this.child,
    this.padding,
    this.filled = false,
    this.fillColor,
    this.borderRadius,
    this.clipBehavior = Clip.none,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.surfaceOpacity,
    this.surfaceBlur,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return OutlinedContainer(
      clipBehavior: clipBehavior,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      backgroundColor: filled
          ? fillColor ?? theme.colorScheme.border
          : theme.colorScheme.card,
      boxShadow: boxShadow,
      padding: padding ?? (EdgeInsets.all(16 * scaling)),
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      child: mergeAnimatedTextStyle(
        child: child,
        duration: kDefaultDuration,
        style: TextStyle(
          color: theme.colorScheme.cardForeground,
        ),
      ),
    );
  }
}

class SurfaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool filled;
  final Color? fillColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Clip clipBehavior;
  final List<BoxShadow>? boxShadow;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const SurfaceCard({
    super.key,
    required this.child,
    this.padding,
    this.filled = false,
    this.fillColor,
    this.borderRadius,
    this.clipBehavior = Clip.none,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.surfaceOpacity,
    this.surfaceBlur,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: clipBehavior,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      filled: filled,
      fillColor: fillColor,
      boxShadow: boxShadow,
      padding: padding,
      surfaceOpacity: surfaceOpacity ?? theme.surfaceOpacity,
      surfaceBlur: surfaceBlur ?? theme.surfaceBlur,
      child: child,
    );
  }
}
