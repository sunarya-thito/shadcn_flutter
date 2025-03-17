import 'package:shadcn_flutter/shadcn_flutter.dart';

class ModalBackdrop extends StatelessWidget {
  static bool shouldClipSurface(double? surfaceOpacity) {
    if (surfaceOpacity == null) {
      return true;
    }
    return surfaceOpacity < 1;
  }

  final Widget child;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry padding;
  final Color barrierColor;
  final Animation<double>? fadeAnimation;
  final bool modal;
  final bool surfaceClip;

  const ModalBackdrop({
    super.key,
    this.modal = true,
    this.surfaceClip = true,
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
    Widget paintWidget = CustomPaint(
      painter: SurfaceBarrierPainter(
        clip: surfaceClip,
        borderRadius: resolvedBorderRadius,
        barrierColor: barrierColor,
        padding: resolvedPadding,
      ),
    );
    if (fadeAnimation != null) {
      paintWidget = FadeTransition(
        opacity: fadeAnimation!,
        child: paintWidget,
      );
    }
    return RepaintBoundary(
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          if (!surfaceClip)
            Positioned.fill(
              child: IgnorePointer(
                child: paintWidget,
              ),
            ),
          child,
          if (surfaceClip)
            Positioned.fill(
              child: IgnorePointer(
                child: paintWidget,
              ),
            ),
        ],
      ),
    );
  }
}

class ModalContainer extends StatelessWidget {
  static const kFullScreenMode = #modal_surface_card_fullscreen;
  static bool isFullScreenMode(BuildContext context) {
    return Model.maybeOf<bool>(context, kFullScreenMode) == true;
  }
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool filled;
  final Color? fillColor;
  final BorderRadiusGeometry? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Clip clipBehavior;
  final List<BoxShadow>? boxShadow;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final Duration? duration;
  const ModalContainer({
    super.key,
    required this.child,
    this.padding,
    this.filled = false,
    this.fillColor,
    this.borderRadius,
    this.clipBehavior = Clip.none,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    var fullScreenMode = Model.maybeOf<bool>(context, kFullScreenMode);
    return SurfaceCard(
      clipBehavior: clipBehavior,
      borderRadius: fullScreenMode == true ? BorderRadius.zero : borderRadius,
      borderWidth: fullScreenMode == true ? 0 : borderWidth,
      borderColor: borderColor,
      filled: filled,
      fillColor: fillColor,
      boxShadow: fullScreenMode == true ? const [] : boxShadow,
      padding: padding,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      duration: duration,
      child: child,
    );
  }
}

class SurfaceBarrierPainter extends CustomPainter {
  static const double bigSize = 1000000;
  static const bigScreen = Size(bigSize, bigSize);
  static const bigOffset = Offset(-bigSize / 2, -bigSize / 2);

  final bool clip;
  final BorderRadius borderRadius;
  final Color barrierColor;
  final EdgeInsets padding;

  SurfaceBarrierPainter({
    required this.clip,
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
    if (clip) {
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
    }
    canvas.drawRect(
      bigOffset & bigScreen,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant SurfaceBarrierPainter oldDelegate) {
    return oldDelegate.borderRadius != borderRadius ||
        oldDelegate.barrierColor != barrierColor ||
        oldDelegate.padding != padding ||
        oldDelegate.clip != clip;
  }
}

class DialogRoute<T> extends RawDialogRoute<T> {
  final CapturedData? data;
  final AlignmentGeometry alignment;
  final bool fullScreen;
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
    this.fullScreen = false,
    this.data,
  }) : super(
          pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            final Widget pageChild = Builder(
              builder: (context) {
                final theme = Theme.of(context);
                final scaling = theme.scaling;
                return Padding(
                  padding: fullScreen ? EdgeInsets.zero : const EdgeInsets.all(16) * scaling,
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
    bool fullScreen,
    Widget child) {
  var scaleTransition = ScaleTransition(
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
  );
  return FocusScope(
    canRequestFocus: animation.value == 1, // Only focus when fully visible
    child: fullScreen
        ? MultiModel(
            data: const [
              Model(ModalContainer.kFullScreenMode, true),
            ],
            child: scaleTransition,
          )
        : Align(
            alignment: alignment,
            child: scaleTransition,
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
  bool fullScreen = false,
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
        fullScreen,
        child,
      );
    },
    alignment: alignment ?? Alignment.center,
  );
  return navigatorState.push(
    dialogRoute,
  );
}

class _DialogOverlayWrapper<T> extends StatefulWidget {
  final DialogRoute<T> route;
  final Widget child;

  const _DialogOverlayWrapper({
    super.key,
    required this.route,
    required this.child,
  });

  @override
  State<_DialogOverlayWrapper<T>> createState() =>
      _DialogOverlayWrapperState<T>();
}

class _DialogOverlayWrapperState<T> extends State<_DialogOverlayWrapper<T>>
    with OverlayHandlerStateMixin {
  @override
  Widget build(BuildContext context) {
    return Data<OverlayHandlerStateMixin>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  Future<void> close([bool immediate = false]) {
    if (immediate || !widget.route.isCurrent) {
      widget.route.navigator?.removeRoute(widget.route);
    } else {
      widget.route.navigator?.pop();
    }
    return widget.route.completed;
  }

  @override
  void closeLater() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.route.isCurrent) {
        widget.route.navigator?.pop();
      } else {
        widget.route.navigator?.removeRoute(widget.route);
      }
    });
  }

  @override
  Future<void> closeWithResult<X>([X? value]) {
    if (widget.route.isCurrent) {
      widget.route.navigator?.pop(value);
    } else {
      widget.route.navigator?.removeRoute(widget.route);
    }
    return widget.route.completed;
  }
}

class DialogOverlayHandler extends OverlayHandler {
  static bool isDialogOverlay(BuildContext context) {
    return Model.maybeOf<bool>(context, #shadcn_flutter_dialog_overlay) == true;
  }

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
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
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
        final theme = Theme.of(context);
        final surfaceOpacity = theme.surfaceOpacity;
        var child = _DialogOverlayWrapper(
          route: ModalRoute.of(context) as DialogRoute<T>,
          child: Builder(builder: (context) {
            return builder(context);
          }),
        );
        if (overlayBarrier != null) {
          return MultiModel(
            data: const [
              Model(#shadcn_flutter_dialog_overlay, true),
            ],
            child: ModalBackdrop(
              modal: modal,
              surfaceClip: ModalBackdrop.shouldClipSurface(surfaceOpacity),
              borderRadius: overlayBarrier.borderRadius,
              padding: overlayBarrier.padding,
              barrierColor: overlayBarrier.barrierColor ??
                  const Color.fromRGBO(0, 0, 0, 0.8),
              child: child,
            ),
          );
        }
        return MultiModel(
          data: const [
            Model(#shadcn_flutter_dialog_overlay, true),
          ],
          child: child,
        );
      },
      themes: themes,
      barrierDismissible: barrierDismissable,
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
          false,
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

class FullScreenDialogOverlayHandler extends OverlayHandler {
  static bool isDialogOverlay(BuildContext context) {
    return Model.maybeOf<bool>(context, #shadcn_flutter_dialog_overlay) == true;
  }

  const FullScreenDialogOverlayHandler();
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
    bool barrierDismissable = true,
    Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
    LayerLink? layerLink,
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
      fullScreen: true,
      builder: (context) {
        final theme = Theme.of(context);
        final surfaceOpacity = theme.surfaceOpacity;
        var child = _DialogOverlayWrapper(
          route: ModalRoute.of(context) as DialogRoute<T>,
          child: Builder(builder: (context) {
            return builder(context);
          }),
        );
        if (overlayBarrier != null) {
          return MultiModel(
            data: const [
              Model(#shadcn_flutter_dialog_overlay, true),
            ],
            child: ModalBackdrop(
              modal: modal,
              surfaceClip: ModalBackdrop.shouldClipSurface(surfaceOpacity),
              borderRadius: overlayBarrier.borderRadius,
              padding: overlayBarrier.padding,
              barrierColor: overlayBarrier.barrierColor ??
                  const Color.fromRGBO(0, 0, 0, 0.8),
              child: child,
            ),
          );
        }
        return MultiModel(
          data: const [
            Model(#shadcn_flutter_dialog_overlay, true),
          ],
          child: child,
        );
      },
      themes: themes,
      barrierDismissible: barrierDismissable,
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
          true,
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
