import '../../../shadcn_flutter.dart';

class MediaQueryVisibility extends StatelessWidget {
  final double? minWidth;
  final double? maxWidth;
  final Widget child;
  final Widget? alternateChild;

  const MediaQueryVisibility({
    super.key,
    this.minWidth,
    this.maxWidth,
    required this.child,
    this.alternateChild,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size.width;
    if (minWidth != null && size < minWidth!) {
      return SizedBox(
        child: alternateChild,
      );
    }
    if (maxWidth != null && size > maxWidth!) {
      return SizedBox(
        child: alternateChild,
      );
    }
    // to prevent widget tree from changing
    return SizedBox(
      child: child,
    );
  }
}
