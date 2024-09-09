import '../../../shadcn_flutter.dart';

class FocusOutline extends StatelessWidget {
  final Widget child;
  final bool focused;
  final BorderRadiusGeometry? borderRadius;
  final double align;
  final double width;
  final double? radius;
  const FocusOutline({
    super.key,
    required this.child,
    required this.focused,
    this.borderRadius,
    this.align = 0,
    this.width = 1,
    this.radius,
  });

  BorderRadius getAdjustedBorderRadius(TextDirection textDirection) {
    if (this.radius != null) {
      return BorderRadius.circular(this.radius!);
    }
    var rawRadius = borderRadius;
    if (rawRadius == null) return BorderRadius.zero;
    var radius = rawRadius.resolve(textDirection);
    // since the align adds 3 to the border, we need to add 3 to all of the radii
    return BorderRadius.only(
      topLeft: radius.topLeft + Radius.circular(align),
      topRight: radius.topRight + Radius.circular(align),
      bottomLeft: radius.bottomLeft + Radius.circular(align),
      bottomRight: radius.bottomRight + Radius.circular(align),
    );
  }

  @override
  Widget build(BuildContext context) {
    double align = -this.align;
    TextDirection textDirection = Directionality.of(context);
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        child,
        if (focused)
          Positioned(
            top: align,
            right: align,
            bottom: align,
            left: align,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: getAdjustedBorderRadius(textDirection),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.ring,
                    width: width,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
