import 'package:shadcn_flutter/shadcn_flutter.dart';

class CardImage extends StatefulWidget {
  final Widget image;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onPressed;
  final bool? enabled;
  final AbstractButtonStyle? style;
  final Axis direction;
  final double hoverScale;
  final double normalScale;
  final Color? backgroundColor;
  final Color? borderColor;

  const CardImage({
    super.key,
    required this.image,
    this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onPressed,
    this.enabled,
    this.style,
    this.direction = Axis.vertical,
    this.hoverScale = 1.05,
    this.normalScale = 1,
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
  });

  @override
  State<CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  final WidgetStatesController _statesController = WidgetStatesController();

  Widget _wrapIntrinsic(Widget child) {
    return widget.direction == Axis.horizontal
        ? IntrinsicHeight(child: child)
        : IntrinsicWidth(child: child);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Button(
      statesController: _statesController,
      style: widget.style ??
          const ButtonStyle.fixed(
            density: ButtonDensity.compact,
          ),
      onPressed: widget.onPressed,
      enabled: widget.enabled,
      child: _wrapIntrinsic(
        Flex(
          direction: widget.direction,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: OutlinedContainer(
                backgroundColor:
                    widget.backgroundColor ?? theme.colorScheme.card,
                borderColor: widget.borderColor ?? theme.colorScheme.border,
                child: AnimatedBuilder(
                    animation: _statesController,
                    builder: (context, child) {
                      return AnimatedScale(
                        duration: kDefaultDuration,
                        scale: _statesController.value
                                .contains(WidgetState.hovered)
                            ? widget.hoverScale
                            : widget.normalScale,
                        child: widget.image,
                      );
                    }),
              ),
            ),
            Gap(12 * scaling),
            Basic(
              title: widget.title,
              subtitle: widget.subtitle,
              trailing: widget.trailing,
              leading: widget.leading,
            ),
          ],
        ),
      ),
    );
  }
}
