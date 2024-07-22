import 'package:shadcn_flutter/src/components/control/hover.dart';

import '../../../shadcn_flutter.dart';

class TooltipContainer extends StatelessWidget {
  final Widget child;

  const TooltipContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: kDefaultDuration,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(theme.radiusSm),
      ),
      child: mergeAnimatedTextStyle(
        child: child,
        duration: kDefaultDuration,
        style: TextStyle(
          fontSize: 12,
          color: theme.colorScheme.primaryForeground,
        ),
      ),
    );
  }
}

class Tooltip extends StatefulWidget {
  final Widget child;
  final Widget tooltip;
  final Alignment alignment;
  final Alignment anchorAlignment;

  const Tooltip({
    Key? key,
    required this.child,
    required this.tooltip,
    this.alignment = Alignment.topCenter,
    this.anchorAlignment = Alignment.bottomCenter,
  }) : super(key: key);

  @override
  State<Tooltip> createState() => _TooltipState();
}

class _TooltipState extends State<Tooltip> {
  final PopoverController _controller = PopoverController();
  @override
  Widget build(BuildContext context) {
    return Hover(
      child: widget.child,
      onHover: (hovered) {
        if (hovered) {
          _controller.show(
            context: context,
            builder: (context) {
              return widget.tooltip;
            },
            alignment: widget.alignment,
            anchorAlignment: widget.anchorAlignment,
            dismissBackdropFocus: false,
          );
        } else {
          _controller.close();
        }
      },
    );
  }
}
