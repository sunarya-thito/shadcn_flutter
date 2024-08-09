import 'package:shadcn_flutter/src/components/control/hover.dart';

import '../../../shadcn_flutter.dart';

class TooltipContainer extends StatelessWidget {
  final Widget child;
  final double? surfaceOpacity;
  final double? surfaceBlur;

  const TooltipContainer({
    Key? key,
    this.surfaceOpacity,
    this.surfaceBlur,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    var backgroundColor = theme.colorScheme.primary;
    // var surfaceOpacity = this.surfaceOpacity ?? theme.surfaceOpacity;
    // var surfaceBlur = this.surfaceBlur ?? theme.surfaceBlur;
    // Do not use the default value of theme.surfaceOpacity and theme.surfaceBlur
    // but still allow the user to set the value
    var surfaceOpacity = this.surfaceOpacity;
    var surfaceBlur = this.surfaceBlur;
    if (surfaceOpacity != null) {
      backgroundColor = backgroundColor.scaleAlpha(surfaceOpacity);
    }
    Widget animatedContainer = AnimatedContainer(
      duration: kDefaultDuration,
      padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ) *
          scaling,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(theme.radiusSm),
      ),
      child: child.xSmall().primaryForeground(),
    );
    if (surfaceBlur != null && surfaceBlur > 0) {
      animatedContainer = SurfaceBlur(
        surfaceBlur: surfaceBlur,
        borderRadius: BorderRadius.circular(theme.radiusSm),
        child: animatedContainer,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(6) * scaling,
      child: animatedContainer,
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

class InstantTooltip extends StatefulWidget {
  final Widget child;
  final HitTestBehavior behavior;
  final WidgetBuilder tooltipBuilder;
  final Alignment tooltipAlignment;
  final Alignment? tooltipAnchorAlignment;

  const InstantTooltip({
    Key? key,
    required this.child,
    required this.tooltipBuilder,
    this.behavior = HitTestBehavior.translucent,
    this.tooltipAlignment = Alignment.bottomCenter,
    this.tooltipAnchorAlignment,
  }) : super(key: key);

  @override
  State<InstantTooltip> createState() => _InstantTooltipState();
}

class _InstantTooltipState extends State<InstantTooltip> {
  final PopoverController _controller = PopoverController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _controller.close(true);
        _controller.show(
          context: context,
          builder: widget.tooltipBuilder,
          alignment: widget.tooltipAlignment,
          anchorAlignment: widget.tooltipAnchorAlignment,
          dismissBackdropFocus: false,
          showDuration: Duration.zero,
          hideDuration: Duration.zero,
        );
      },
      onExit: (event) {
        _controller.close();
      },
      hitTestBehavior: widget.behavior,
      child: widget.child,
    );
  }
}
