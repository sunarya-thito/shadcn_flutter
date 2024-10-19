import 'package:pixel_snap/pixel_snap.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ModalContainer extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;
  final Color barrierColor;
  final Animation<double>? fadeAnimation;
  final bool modal;

  const ModalContainer({
    super.key,
    this.modal = true,
    this.borderRadius = BorderRadius.zero,
    this.barrierColor = const Color.fromRGBO(0, 0, 0, 0.8),
    this.padding = EdgeInsets.zero,
    this.fadeAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!modal) {
      return child;
    }
    var textDirection = Directionality.of(context);
    var resolvedBorderRadius = borderRadius.resolve(textDirection);
    var resolvedPadding = padding.resolve(textDirection);
    var snap = PixelSnap.of(context);
    Widget paintWidget = CustomPaint(
      painter: SurfaceBarrierPainter(
        borderRadius: resolvedBorderRadius.pixelSnap(snap),
        barrierColor: barrierColor,
        padding: resolvedPadding.pixelSnap(snap),
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
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: paintWidget,
          ),
        ),
      ],
    );
  }
}

class SurfaceBarrierPainter extends CustomPainter {
  static const double bigSize = 10000000000000000000000;
  static const bigScreen = Size(bigSize, bigSize);
  static const bigOffset = Offset(-bigSize / 2, -bigSize / 2);

  final BorderRadius borderRadius;
  final Color barrierColor;
  final EdgeInsets padding;

  SurfaceBarrierPainter({
    required this.borderRadius,
    required this.barrierColor,
    this.padding = EdgeInsets.zero,
  });

  Rect _padRect(Rect rect) {
    return Rect.fromLTRB(
      rect.left + padding.left,
      rect.top + padding.top,
      rect.right - padding.right,
      rect.bottom - padding.bottom,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = barrierColor
      ..blendMode = BlendMode.srcOver
      ..style = PaintingStyle.fill;
    var rect = (Offset.zero & size);
    rect = _padRect(rect);
    Path path = Path()
      ..addRect(bigOffset & bigScreen)
      ..addRRect(RRect.fromRectAndCorners(
        rect,
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
  var dialogRoute = DialogRoute<T>(
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
  );
  return navigatorState.push(
    dialogRoute,
  );
}

class DialogOverlayHandler extends OverlayHandler {
  const DialogOverlayHandler();
  @override
  OverlayCompleter<T> show<T>({
    required BuildContext context,
    required AlignmentGeometry alignment,
    required WidgetBuilder builder,
    Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    Alignment? transitionAlignment,
    EdgeInsets? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverAnchorState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  }) {
    var navigatorState = Navigator.of(
      context,
      rootNavigator: rootOverlay,
    );
    final CapturedThemes themes =
        InheritedTheme.capture(from: context, to: navigatorState.context);
    final CapturedData data =
        Data.capture(from: context, to: navigatorState.context);
    var dialogRoute = DialogRoute<T>(
      context: context,
      builder: (context) {
        if (overlayBarrier != null) {
          return Data.inherit(
            data: this,
            child: ModalContainer(
              modal: overlayBarrier.modal,
              borderRadius: overlayBarrier.borderRadius,
              padding: overlayBarrier.padding,
              barrierColor: overlayBarrier.barrierColor ??
                  const Color.fromRGBO(0, 0, 0, 0.8),
              child: builder(context),
            ),
          );
        }
        return Data.inherit(
          data: this,
          child: builder(context),
        );
      },
      themes: themes,
      barrierDismissible: true,
      barrierColor: overlayBarrier == null
          ? const Color.fromRGBO(0, 0, 0, 0.8)
          : Colors.transparent,
      barrierLabel: 'Dismiss',
      useSafeArea: true,
      data: data,
      traversalEdgeBehavior: TraversalEdgeBehavior.closedLoop,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return _buildShadcnDialogTransitions(
          context,
          BorderRadius.zero,
          Alignment.center,
          animation,
          secondaryAnimation,
          child,
        );
      },
      alignment: Alignment.center,
    );
    navigatorState.push(
      dialogRoute,
    );
    return DialogOverlayCompleter(dialogRoute);
  }
}

class DialogOverlayCompleter<T> extends OverlayCompleter<T> {
  final DialogRoute<T> route;

  DialogOverlayCompleter(this.route);

  @override
  Future<void> get animationFuture => route.completed;

  @override
  void dispose() {
    route.dispose();
  }

  @override
  Future<T> get future => route.popped.then((value) {
        assert(value is T, 'Dialog route was closed without returning a value');
        return value as T;
      });

  @override
  bool get isAnimationCompleted => route.animation?.isCompleted ?? true;

  @override
  bool get isCompleted => route.animation?.isCompleted ?? true;

  @override
  void remove() {
    if (route.isCurrent) {
      route.navigator?.pop();
    } else {
      route.navigator?.removeRoute(route);
    }
  }
}
