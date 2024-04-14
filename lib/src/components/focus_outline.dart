import '../../shadcn_flutter.dart';

class FocusOutline extends StatelessWidget {
  final Widget child;
  final bool focused;
  final BorderRadius? borderRadius;

  const FocusOutline({
    Key? key,
    required this.child,
    required this.focused,
    this.borderRadius,
  }) : super(key: key);

  BorderRadius get adjustedBorderRadius {
    var radius = borderRadius;
    if (radius == null) return BorderRadius.zero;
    // since the align adds 3 to the border, we need to add 3 to all of the radii
    const double align = 4;
    return BorderRadius.only(
      topLeft: radius.topLeft + const Radius.circular(align),
      topRight: radius.topRight + const Radius.circular(align),
      bottomLeft: radius.bottomLeft + const Radius.circular(align),
      bottomRight: radius.bottomRight + const Radius.circular(align),
    );
  }

  @override
  Widget build(BuildContext context) {
    double align = -4;
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
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          )
        : child;
  }
}
