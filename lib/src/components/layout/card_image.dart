import 'package:shadcn_flutter/shadcn_flutter.dart';

class CardImageTheme {
  final AbstractButtonStyle? style;
  final Axis? direction;
  final double? hoverScale;
  final double? normalScale;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? gap;

  const CardImageTheme({
    this.style,
    this.direction,
    this.hoverScale,
    this.normalScale,
    this.backgroundColor,
    this.borderColor,
    this.gap,
  });

  CardImageTheme copyWith({
    ValueGetter<AbstractButtonStyle?>? style,
    ValueGetter<Axis?>? direction,
    ValueGetter<double?>? hoverScale,
    ValueGetter<double?>? normalScale,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? borderColor,
    ValueGetter<double?>? gap,
  }) {
    return CardImageTheme(
      style: style == null ? this.style : style(),
      direction: direction == null ? this.direction : direction(),
      hoverScale: hoverScale == null ? this.hoverScale : hoverScale(),
      normalScale: normalScale == null ? this.normalScale : normalScale(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      gap: gap == null ? this.gap : gap(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CardImageTheme &&
        other.style == style &&
        other.direction == direction &&
        other.hoverScale == hoverScale &&
        other.normalScale == normalScale &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor &&
        other.gap == gap;
  }

  @override
  int get hashCode => Object.hash(
        style,
        direction,
        hoverScale,
        normalScale,
        backgroundColor,
        borderColor,
        gap,
      );
}

class CardImage extends StatefulWidget {
  final Widget image;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onPressed;
  final bool? enabled;
  final AbstractButtonStyle? style;
  final Axis? direction;
  final double? hoverScale;
  final double? normalScale;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? gap;

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
    this.direction,
    this.hoverScale,
    this.normalScale,
    this.backgroundColor,
    this.borderColor,
    this.gap,
  });

  @override
  State<CardImage> createState() => _CardImageState();
}

class _CardImageState extends State<CardImage> {
  final WidgetStatesController _statesController = WidgetStatesController();

  Widget _wrapIntrinsic(Widget child, Axis direction) {
    return direction == Axis.horizontal
        ? IntrinsicHeight(child: child)
        : IntrinsicWidth(child: child);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<CardImageTheme>(context);
    final style = styleValue(
        widgetValue: widget.style,
        themeValue: compTheme?.style,
        defaultValue: const ButtonStyle.fixed(
          density: ButtonDensity.compact,
        ));
    final direction = styleValue(
        widgetValue: widget.direction,
        themeValue: compTheme?.direction,
        defaultValue: Axis.vertical);
    final hoverScale = styleValue(
        widgetValue: widget.hoverScale,
        themeValue: compTheme?.hoverScale,
        defaultValue: 1.05);
    final normalScale = styleValue(
        widgetValue: widget.normalScale,
        themeValue: compTheme?.normalScale,
        defaultValue: 1.0);
    final backgroundColor = styleValue(
        widgetValue: widget.backgroundColor,
        themeValue: compTheme?.backgroundColor,
        defaultValue: Colors.transparent);
    final borderColor = styleValue(
        widgetValue: widget.borderColor,
        themeValue: compTheme?.borderColor,
        defaultValue: Colors.transparent);
    final gap = styleValue(
        widgetValue: widget.gap,
        themeValue: compTheme?.gap,
        defaultValue: 12 * scaling);
    return Button(
      statesController: _statesController,
      style: style,
      onPressed: widget.onPressed,
      enabled: widget.enabled,
      child: _wrapIntrinsic(
        Flex(
          direction: direction,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: OutlinedContainer(
                backgroundColor: backgroundColor ?? theme.colorScheme.card,
                borderColor: borderColor ?? theme.colorScheme.border,
                child: AnimatedBuilder(
                    animation: _statesController,
                    builder: (context, child) {
                      return AnimatedScale(
                        duration: kDefaultDuration,
                        scale: _statesController.value
                                .contains(WidgetState.hovered)
                            ? hoverScale
                            : normalScale,
                        child: widget.image,
                      );
                    }),
              ),
            ),
            Gap(gap),
            Basic(
              title: widget.title,
              subtitle: widget.subtitle,
              trailing: widget.trailing,
              leading: widget.leading,
            ),
          ],
        ),
        direction,
      ),
    );
  }
}
