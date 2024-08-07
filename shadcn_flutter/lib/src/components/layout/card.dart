import 'package:shadcn_flutter/shadcn_flutter.dart';

class Card extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool filled;
  final Color? fillColor;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Clip clipBehavior;
  final List<BoxShadow>? boxShadow;

  const Card({
    Key? key,
    required this.child,
    this.padding,
    this.filled = false,
    this.fillColor,
    this.borderRadius,
    this.clipBehavior = Clip.none,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
  }) : super(key: key);

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
      child: AnimatedContainer(
          duration: kDefaultDuration,
          padding: padding ?? (EdgeInsets.all(16 * scaling)),
          child: mergeAnimatedTextStyle(
            child: child,
            duration: kDefaultDuration,
            style: TextStyle(
              color: theme.colorScheme.cardForeground,
            ),
          )),
    );
  }
}
