import '../../../shadcn_flutter.dart';

class FocusOutlineTheme {
  final double? align;
  final BorderRadiusGeometry? borderRadius;
  final Border? border;

  const FocusOutlineTheme({
    this.align,
    this.border,
    this.borderRadius,
  });

  FocusOutlineTheme copyWith({
    ValueGetter<Border?>? border,
    ValueGetter<double?>? align,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return FocusOutlineTheme(
      align: align == null ? this.align : align(),
      border: border == null ? this.border : border(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FocusOutlineTheme &&
        other.align == align &&
        other.border == border &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(border, align, borderRadius);
}

class FocusOutline extends StatelessWidget {
  final Widget child;
  final bool focused;
  final BorderRadiusGeometry? borderRadius;
  final double? align;
  final Border? border;
  final BoxShape? shape;
  const FocusOutline({
    super.key,
    required this.child,
    required this.focused,
    this.borderRadius,
    this.align,
    this.border,
    this.shape,
  });

  BorderRadius _getAdjustedBorderRadius(
    TextDirection textDirection,
    double align,
    BorderRadiusGeometry? borderRadius,
  ) {
    var rawRadius = borderRadius;
    if (rawRadius == null) return BorderRadius.zero;
    var resolved = rawRadius.resolve(textDirection);
    return BorderRadius.only(
      topLeft: resolved.topLeft + Radius.circular(align),
      topRight: resolved.topRight + Radius.circular(align),
      bottomLeft: resolved.bottomLeft + Radius.circular(align),
      bottomRight: resolved.bottomRight + Radius.circular(align),
    );
  }

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<FocusOutlineTheme>(context);
    final double align = styleValue(
      defaultValue: 3.0,
      themeValue: compTheme?.align,
      widgetValue: this.align,
    );
    final BorderRadiusGeometry? borderRadius = styleValue(
      themeValue: compTheme?.borderRadius,
      widgetValue: this.borderRadius,
      defaultValue: null,
    );
    final double offset = -align;
    TextDirection textDirection = Directionality.of(context);
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        child,
        AnimatedValueBuilder(
            value: focused ? 1.0 : 0.0,
            duration: kDefaultDuration,
            builder: (context, value, child) {
              return Positioned(
                top: offset * value,
                right: offset * value,
                bottom: offset * value,
                left: offset * value,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: shape != BoxShape.circle
                            ? _getAdjustedBorderRadius(
                                textDirection,
                                align,
                                borderRadius,
                              )
                            : null,
                        shape: shape ?? BoxShape.rectangle,
                        border: styleValue(
                          defaultValue: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .ring
                                .scaleAlpha(0.5),
                            width: 3.0,
                          ),
                          themeValue: compTheme?.border,
                          widgetValue: border,
                        ).scale(value)),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
