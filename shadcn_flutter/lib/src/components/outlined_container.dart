import '../../shadcn_flutter.dart';

class OutlinedContainer extends StatefulWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final Clip clipBehavior;
  final double? borderRadius;
  const OutlinedContainer({
    Key? key,
    required this.child,
    this.borderColor,
    this.backgroundColor,
    this.clipBehavior = Clip.none,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<OutlinedContainer> createState() => _OutlinedContainerState();
}

class _OutlinedContainerState extends State<OutlinedContainer> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      clipBehavior: widget.clipBehavior,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.colorScheme.background,
        border: Border.all(
          color: widget.borderColor ?? theme.colorScheme.muted,
          width: 1,
        ),
        borderRadius:
            BorderRadius.circular(widget.borderRadius ?? theme.radiusXl),
      ),
      child: widget.child,
    );
  }
}
