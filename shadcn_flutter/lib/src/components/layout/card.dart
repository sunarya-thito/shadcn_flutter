import 'package:shadcn_flutter/shadcn_flutter.dart';

class Card extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool filled;
  final Color? fillColor;
  final double? borderRadius;

  const Card({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.filled = false,
    this.fillColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedContainer(
      borderRadius: borderRadius,
      backgroundColor: filled
          ? fillColor ?? theme.colorScheme.border
          : theme.colorScheme.card,
      child: AnimatedContainer(
          duration: kDefaultDuration,
          padding: padding,
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
