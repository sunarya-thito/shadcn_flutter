import '../../shadcn_flutter.dart';

class FocusOutline extends StatelessWidget {
  final Widget child;
  final bool focused;
  final BorderRadius? borderRadius;
  final double align;
  final double width;
  final double? radius;
  const FocusOutline({
    Key? key,
    required this.child,
    required this.focused,
    this.borderRadius,
    this.align = 0,
    this.width = 1,
    this.radius,
  }) : super(key: key);

  BorderRadius get adjustedBorderRadius {
    if (this.radius != null) {
      return BorderRadius.circular(this.radius!);
    }
    var radius = borderRadius;
    if (radius == null) return BorderRadius.zero;
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
    return focused
        ? Stack(
            clipBehavior: Clip.none,
            children: [
              child,
              Positioned(
                top: align,
                right: align,
                bottom: align,
                left: align,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: adjustedBorderRadius,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.ring,
                      width: width,
                    ),
                  ),
                ),
              ),
            ],
          )
        : child;
  }
}
