import '../../../shadcn_flutter.dart';

class FocusOutlineTheme {
  final Color? color;
  final double? width;
  final double? align;
  final double? radius;
  final BorderRadiusGeometry? borderRadius;

  const FocusOutlineTheme({
    this.color,
    this.width,
    this.align,
    this.radius,
    this.borderRadius,
  });

  FocusOutlineTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<double?>? width,
    ValueGetter<double?>? align,
    ValueGetter<double?>? radius,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return FocusOutlineTheme(
      color: color == null ? this.color : color(),
      width: width == null ? this.width : width(),
      align: align == null ? this.align : align(),
      radius: radius == null ? this.radius : radius(),
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FocusOutlineTheme &&
        other.color == color &&
        other.width == width &&
        other.align == align &&
        other.radius == radius &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(color, width, align, radius, borderRadius);
}

class FocusOutline extends StatelessWidget {
  final Widget child;
  final bool focused;
  final BorderRadiusGeometry? borderRadius;
  final double align;
  final double width;
  final double? radius;
  final Color? color;
  const FocusOutline({
    super.key,
    required this.child,
    required this.focused,
    this.borderRadius,
    this.align = 0,
    this.width = 1,
    this.radius,
    this.color,
  });

  BorderRadius _getAdjustedBorderRadius(
    TextDirection textDirection,
    double align,
    double? radius,
    BorderRadiusGeometry? borderRadius,
  ) {
    if (radius != null) {
      return BorderRadius.circular(radius);
    }
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
      defaultValue: 0.0,
      themeValue: compTheme?.align,
      widgetValue: this.align,
    );
    final double width = styleValue(
      defaultValue: 1.0,
      themeValue: compTheme?.width,
      widgetValue: this.width,
    );
    final double? radius = styleValue(
      themeValue: compTheme?.radius,
      widgetValue: this.radius,
      defaultValue: null,
    );
    final BorderRadiusGeometry? borderRadius = styleValue(
      themeValue: compTheme?.borderRadius,
      widgetValue: this.borderRadius,
      defaultValue: null,
    );
    final Color color = styleValue(
      defaultValue: Theme.of(context).colorScheme.ring,
      themeValue: compTheme?.color,
      widgetValue: this.color,
    );
    final double offset = -align;
    TextDirection textDirection = Directionality.of(context);
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        child,
        if (focused)
          Positioned(
            top: offset,
            right: offset,
            bottom: offset,
            left: offset,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: _getAdjustedBorderRadius(
                    textDirection,
                    align,
                    radius,
                    borderRadius,
                  ),
                  border: Border.all(color: color, width: width),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
