import 'package:shadcn_flutter/shadcn_flutter.dart';

class ModalContainer extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final Color barrierColor;
  final Animation<double>? fadeAnimation;

  const ModalContainer({
    Key? key,
    this.borderRadius = BorderRadius.zero,
    this.barrierColor = const Color.fromRGBO(0, 0, 0, 0.8),
    this.fadeAnimation,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget paintWidget = CustomPaint(
      painter: SurfaceBarrierPainter(
        borderRadius: borderRadius,
        barrierColor: barrierColor,
      ),
    );
    if (fadeAnimation != null) {
      paintWidget = FadeTransition(
        opacity: fadeAnimation!,
        child: paintWidget,
      );
    }
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: paintWidget,
        ),
        child,
      ],
    );
  }
}

class SurfaceBarrierPainter extends CustomPainter {
  static const bigOffset = Offset(-999999 / 2, -999999 / 2);
  static const bigScreen = Size(999999, 999999);

  final BorderRadius borderRadius;
  final Color barrierColor;

  SurfaceBarrierPainter({
    required this.borderRadius,
    required this.barrierColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = barrierColor
      ..blendMode = BlendMode.srcOver
      ..style = PaintingStyle.fill;
    Path path = Path()
      ..addRect(bigOffset & bigScreen)
      ..addRRect(RRect.fromRectAndCorners(
        (Offset.zero & size),
        topLeft: borderRadius.topLeft,
        topRight: borderRadius.topRight,
        bottomLeft: borderRadius.bottomLeft,
        bottomRight: borderRadius.bottomRight,
      ));
    path.fillType = PathFillType.evenOdd;
    canvas.clipPath(path);
    canvas.drawRect(
      bigOffset & bigScreen,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant SurfaceBarrierPainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius ||
        oldDelegate.barrierColor != barrierColor;
  }
}

class DialogRoute<T> extends RawDialogRoute<T> {
  final CapturedData? data;
  final AlignmentGeometry alignment;
  DialogRoute({
    required BuildContext context,
    required WidgetBuilder builder,
    CapturedThemes? themes,
    super.barrierColor = const Color.fromRGBO(0, 0, 0, 0),
    super.barrierDismissible,
    String? barrierLabel,
    bool useSafeArea = true,
    super.settings,
    super.anchorPoint,
    super.traversalEdgeBehavior,
    required this.alignment,
    required super.transitionBuilder,
    this.data,
  }) : super(
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            final Widget pageChild = Builder(
              builder: (context) {
                final theme = Theme.of(context);
                final scaling = theme.scaling;
                return Padding(
                  padding: const EdgeInsets.all(16) * scaling,
                  child: builder(context),
                );
              },
            );
            Widget dialog = themes?.wrap(pageChild) ?? pageChild;
            if (data != null) {
              dialog = data.wrap(dialog);
            }
            if (useSafeArea) {
              dialog = SafeArea(child: dialog);
            }
            return dialog;
          },
          barrierLabel: barrierLabel ?? 'Dismiss',
          transitionDuration: const Duration(milliseconds: 150),
        );
}

Widget _buildShadcnDialogTransitions(
    BuildContext context,
    BorderRadiusGeometry borderRadius,
    AlignmentGeometry alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return Align(
    alignment: alignment,
    child: ScaleTransition(
      scale: CurvedAnimation(
        parent: animation.drive(Tween<double>(begin: 0.7, end: 1.0)),
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
        child: child,
      ),
    ),
  );
}

Future<T?> showDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  Color? barrierColor,
  String? barrierLabel,
  bool useSafeArea = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  TraversalEdgeBehavior? traversalEdgeBehavior,
  AlignmentGeometry? alignment,
}) {
  var navigatorState = Navigator.of(
    context,
    rootNavigator: useRootNavigator,
  );
  final CapturedThemes themes =
      InheritedTheme.capture(from: context, to: navigatorState.context);
  final CapturedData data =
      Data.capture(from: context, to: navigatorState.context);
  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    DialogRoute<T>(
      context: context,
      builder: builder,
      themes: themes,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? const Color.fromRGBO(0, 0, 0, 0),
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      settings: routeSettings,
      anchorPoint: anchorPoint,
      data: data,
      traversalEdgeBehavior:
          traversalEdgeBehavior ?? TraversalEdgeBehavior.closedLoop,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return _buildShadcnDialogTransitions(
          context,
          BorderRadius.zero,
          alignment ?? Alignment.center,
          animation,
          secondaryAnimation,
          child,
        );
      },
      alignment: alignment ?? Alignment.center,
    ),
  );
}
