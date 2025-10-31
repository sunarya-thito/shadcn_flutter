import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for modal backdrop appearance and behavior.
///
/// Defines the visual and behavioral properties of the backdrop that appears
/// behind modal dialogs, including border radius, padding, barrier color,
/// and modal interaction settings.
///
/// Example:
/// ```dart
/// ComponentThemeData(
///   data: {
///     ModalBackdropTheme: ModalBackdropTheme(
///       barrierColor: Colors.black54,
///       borderRadius: BorderRadius.circular(12),
///       modal: true,
///     ),
///   },
///   child: MyApp(),
/// )
/// ```
class ModalBackdropTheme {
  /// Border radius applied to the modal surface.
  final BorderRadiusGeometry? borderRadius;

  /// Padding around the modal content area.
  final EdgeInsetsGeometry? padding;

  /// Color of the barrier that appears behind the modal.
  final Color? barrierColor;

  /// Whether the backdrop behaves as a modal (blocking interaction).
  final bool? modal;

  /// Whether to clip the surface for visual effects.
  final bool? surfaceClip;

  /// Creates a [ModalBackdropTheme].
  ///
  /// All parameters are optional and will use system defaults when null.
  ///
  /// Parameters:
  /// - [borderRadius] (BorderRadiusGeometry?, optional): corner radius for the modal surface
  /// - [padding] (EdgeInsetsGeometry?, optional): padding around modal content
  /// - [barrierColor] (Color?, optional): backdrop color, typically semi-transparent
  /// - [modal] (bool?, optional): whether backdrop blocks user interaction
  /// - [surfaceClip] (bool?, optional): whether to clip surface for visual effects
  ///
  /// Example:
  /// ```dart
  /// const ModalBackdropTheme(
  ///   borderRadius: BorderRadius.circular(8),
  ///   barrierColor: Color.fromRGBO(0, 0, 0, 0.5),
  ///   modal: true,
  /// )
  /// ```
  const ModalBackdropTheme({
    this.borderRadius,
    this.padding,
    this.barrierColor,
    this.modal,
    this.surfaceClip,
  });

  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Uses [ValueGetter] functions to allow null value assignments.
  /// Any parameter set to null will use the current value.
  ///
  /// Returns:
  /// A new [ModalBackdropTheme] with updated values.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = theme.copyWith(
  ///   barrierColor: () => Colors.red.withOpacity(0.3),
  ///   modal: () => false,
  /// );
  /// ```
  ModalBackdropTheme copyWith({
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Color?>? barrierColor,
    ValueGetter<bool?>? modal,
    ValueGetter<bool?>? surfaceClip,
  }) {
    return ModalBackdropTheme(
      borderRadius: borderRadius == null ? this.borderRadius : borderRadius(),
      padding: padding == null ? this.padding : padding(),
      barrierColor: barrierColor == null ? this.barrierColor : barrierColor(),
      modal: modal == null ? this.modal : modal(),
      surfaceClip: surfaceClip == null ? this.surfaceClip : surfaceClip(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ModalBackdropTheme &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.barrierColor == barrierColor &&
        other.modal == modal &&
        other.surfaceClip == surfaceClip;
  }

  @override
  int get hashCode => Object.hash(
        borderRadius,
        padding,
        barrierColor,
        modal,
        surfaceClip,
      );
}

/// A visual backdrop widget that creates modal-style overlays.
///
/// Creates a semi-transparent barrier behind modal content with support for
/// custom colors, clipping, and animation. The backdrop can be configured
/// to prevent interaction with content below when modal behavior is enabled.
///
/// Features:
/// - Customizable barrier color and opacity
/// - Surface clipping for visual effects
/// - Animation support with fade transitions
/// - Configurable modal behavior
/// - Theme integration
///
/// Example:
/// ```dart
/// ModalBackdrop(
///   barrierColor: Colors.black54,
///   borderRadius: BorderRadius.circular(12),
///   modal: true,
///   child: MyDialogContent(),
/// )
/// ```
class ModalBackdrop extends StatelessWidget {
  /// Determines if surface clipping should be enabled based on opacity.
  ///
  /// Returns `true` if [surfaceOpacity] is null or less than 1.0,
  /// indicating that clipping is needed for proper visual effects.
  static bool shouldClipSurface(double? surfaceOpacity) {
    if (surfaceOpacity == null) {
      return true;
    }
    return surfaceOpacity < 1;
  }

  /// The child widget to display above the backdrop.
  final Widget child;

  /// Border radius for the backdrop cutout around the child.
  final BorderRadiusGeometry? borderRadius;

  /// Padding around the child widget.
  final EdgeInsetsGeometry? padding;

  /// Color of the backdrop barrier.
  final Color? barrierColor;

  /// Animation for fade in/out transitions.
  final Animation<double>? fadeAnimation;

  /// Whether the backdrop should behave as a modal.
  final bool? modal;

  /// Whether to apply surface clipping effects.
  final bool? surfaceClip;

  /// Creates a [ModalBackdrop].
  ///
  /// The [child] parameter is required and represents the content to display
  /// above the backdrop.
  ///
  /// Parameters:
  /// - [child] (Widget, required): content widget displayed above backdrop
  /// - [modal] (bool?, optional): enables modal behavior, defaults to true
  /// - [surfaceClip] (bool?, optional): enables surface clipping, defaults to true
  /// - [borderRadius] (BorderRadiusGeometry?, optional): corner radius for cutout
  /// - [barrierColor] (Color?, optional): backdrop color, defaults to black with 80% opacity
  /// - [padding] (EdgeInsetsGeometry?, optional): padding around child
  /// - [fadeAnimation] (`Animation<double>?`, optional): fade transition animation
  ///
  /// Example:
  /// ```dart
  /// ModalBackdrop(
  ///   barrierColor: Colors.black54,
  ///   fadeAnimation: slideController,
  ///   child: AlertDialog(title: Text('Alert')),
  /// )
  /// ```
  const ModalBackdrop({
    super.key,
    this.modal,
    this.surfaceClip,
    this.borderRadius,
    this.barrierColor,
    this.padding,
    this.fadeAnimation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<ModalBackdropTheme>(context);
    final modal = styleValue(
        widgetValue: this.modal,
        themeValue: compTheme?.modal,
        defaultValue: true);
    final surfaceClip = styleValue(
        widgetValue: this.surfaceClip,
        themeValue: compTheme?.surfaceClip,
        defaultValue: true);
    final borderRadius = styleValue(
        widgetValue: this.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: BorderRadius.zero);
    final padding = styleValue(
        widgetValue: this.padding,
        themeValue: compTheme?.padding,
        defaultValue: EdgeInsets.zero);
    final barrierColor = styleValue(
        widgetValue: this.barrierColor,
        themeValue: compTheme?.barrierColor,
        defaultValue: const Color.fromRGBO(0, 0, 0, 0.8));
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

/// A container widget that provides consistent styling for modal content.
///
/// Wraps modal content in a [SurfaceCard] with appropriate styling that
/// adapts to full-screen mode. Handles surface effects, borders, shadows,
/// and clipping behavior automatically based on the modal context.
///
/// Features:
/// - Automatic full-screen mode detection
/// - Surface styling with blur and opacity effects
/// - Configurable borders and shadows
/// - Clip behavior control
/// - Theme integration
///
/// Example:
/// ```dart
/// ModalContainer(
///   padding: EdgeInsets.all(16),
///   borderRadius: BorderRadius.circular(12),
///   filled: true,
///   child: Column(
///     children: [
///       Text('Dialog Title'),
///       Text('Dialog content here'),
///     ],
///   ),
/// )
/// ```
class ModalContainer extends StatelessWidget {
  /// Model key used to identify full-screen modal mode.
  static const kFullScreenMode = #modal_surface_card_fullscreen;

  /// Checks if the current context is in full-screen modal mode.
  ///
  /// Returns `true` if the modal should display in full-screen mode,
  /// which affects styling such as border radius and shadows.
  static bool isFullScreenMode(BuildContext context) {
    return Model.maybeOf<bool>(context, kFullScreenMode) == true;
  }

  /// The child widget to display inside the modal container.
  final Widget child;

  /// Padding applied inside the container around the child.
  final EdgeInsetsGeometry? padding;

  /// Whether the container should have a filled background.
  final bool filled;

  /// Background fill color when [filled] is true.
  final Color? fillColor;

  /// Border radius for the container corners.
  final BorderRadiusGeometry? borderRadius;

  /// Color of the container border.
  final Color? borderColor;

  /// Width of the container border in logical pixels.
  final double? borderWidth;

  /// Clipping behavior for the container content.
  final Clip clipBehavior;

  /// Drop shadow effects applied to the container.
  final List<BoxShadow>? boxShadow;

  /// Surface opacity for backdrop effects.
  final double? surfaceOpacity;

  /// Surface blur intensity for backdrop effects.
  final double? surfaceBlur;

  /// Animation duration for surface transitions.
  final Duration? duration;

  /// Creates a [ModalContainer].
  ///
  /// The [child] parameter is required. Other parameters customize the
  /// container's appearance and behavior.
  ///
  /// Parameters:
  /// - [child] (Widget, required): content to display in the container
  /// - [padding] (EdgeInsetsGeometry?, optional): inner padding around child
  /// - [filled] (bool, default: false): whether to show background fill
  /// - [fillColor] (Color?, optional): background fill color when filled is true
  /// - [borderRadius] (BorderRadiusGeometry?, optional): corner radius
  /// - [clipBehavior] (Clip, default: Clip.none): clipping behavior for content
  /// - [borderColor] (Color?, optional): border color
  /// - [borderWidth] (double?, optional): border width in logical pixels
  /// - [boxShadow] (`List<BoxShadow>?`, optional): drop shadow effects
  /// - [surfaceOpacity] (double?, optional): backdrop opacity level
  /// - [surfaceBlur] (double?, optional): backdrop blur intensity
  /// - [duration] (Duration?, optional): animation duration for transitions
  ///
  /// Example:
  /// ```dart
  /// ModalContainer(
  ///   filled: true,
  ///   padding: EdgeInsets.all(24),
  ///   borderRadius: BorderRadius.circular(8),
  ///   child: Text('Modal Content'),
  /// )
  /// ```
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

/// Custom painter that creates a barrier effect with an optional cutout.
///
/// Paints a large colored rectangle that covers the entire screen, with
/// an optional rounded rectangle cutout to create a "spotlight" effect
/// around modal content. Uses path clipping to create the cutout area.
///
/// Features:
/// - Full-screen barrier painting
/// - Rounded rectangle cutouts
/// - Configurable colors and padding
/// - Efficient repainting optimization
///
/// Example:
/// ```dart
/// CustomPaint(
///   painter: SurfaceBarrierPainter(
///     clip: true,
///     borderRadius: BorderRadius.circular(8),
///     barrierColor: Colors.black54,
///     padding: EdgeInsets.all(16),
///   ),
/// )
/// ```
class SurfaceBarrierPainter extends CustomPainter {
  /// Large size constant for creating screen-filling effects.
  static const double bigSize = 1000000;

  /// Large screen size for painting operations.
  static const bigScreen = Size(bigSize, bigSize);

  /// Large offset to center the big screen.
  static const bigOffset = Offset(-bigSize / 2, -bigSize / 2);

  /// Whether to clip a cutout area in the barrier.
  final bool clip;

  /// Border radius for the cutout area.
  final BorderRadius borderRadius;

  /// Color of the barrier.
  final Color barrierColor;

  /// Padding around the cutout area.
  final EdgeInsets padding;

  /// Creates a [SurfaceBarrierPainter].
  ///
  /// Parameters:
  /// - [clip] (bool, required): whether to create a cutout in the barrier
  /// - [borderRadius] (BorderRadius, required): radius for the cutout corners
  /// - [barrierColor] (Color, required): color of the barrier
  /// - [padding] (EdgeInsets, default: EdgeInsets.zero): padding around cutout
  ///
  /// Example:
  /// ```dart
  /// SurfaceBarrierPainter(
  ///   clip: true,
  ///   borderRadius: BorderRadius.circular(12),
  ///   barrierColor: Colors.black54,
  /// )
  /// ```
  SurfaceBarrierPainter({
    required this.clip,
    required this.borderRadius,
    required this.barrierColor,
    this.padding = EdgeInsets.zero,
  });

  /// Applies padding to a rectangle by shrinking it inward.
  ///
  /// Reduces the rectangle size by the specified padding amounts
  /// on all sides.
  ///
  /// Returns:
  /// A new [Rect] with padding applied.
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

/// Custom route implementation for shadcn_flutter dialogs.
///
/// Extends [RawDialogRoute] to provide consistent dialog behavior with
/// proper theme inheritance, data capture, and transition animations.
/// Handles both standard and full-screen dialog presentations.
///
/// Features:
/// - Theme and data inheritance across navigation boundaries
/// - Configurable alignment and positioning
/// - Full-screen mode support
/// - Custom transition animations
/// - Safe area integration
///
/// This class is typically not used directly - use [showDialog] instead.
class DialogRoute<T> extends RawDialogRoute<T> {
  /// Captured data from the launching context.
  final CapturedData? data;

  /// Alignment for positioning the dialog.
  final AlignmentGeometry alignment;

  /// Whether the dialog should display in full-screen mode.
  final bool fullScreen;

  /// Creates a [DialogRoute].
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context.
  /// - [builder] (`WidgetBuilder`, required): Dialog content builder.
  /// - [themes] (`CapturedThemes?`, optional): Captured theme data.
  /// - [barrierColor] (`Color`, default: transparent): Barrier color.
  /// - [barrierDismissible] (`bool?`, optional): Whether tapping barrier dismisses dialog.
  /// - [barrierLabel] (`String?`, optional): Semantic label for barrier.
  /// - [useSafeArea] (`bool`, default: `true`): Whether to respect safe area.
  /// - [settings] (`RouteSettings?`, optional): Route settings.
  /// - [anchorPoint] (`Offset?`, optional): Anchor point for route.
  /// - [traversalEdgeBehavior] (`TraversalEdgeBehavior?`, optional): Traversal behavior.
  /// - [alignment] (`AlignmentGeometry`, required): Dialog alignment.
  /// - [transitionBuilder] (`RouteTransitionsBuilder`, required): Transition builder.
  /// - [fullScreen] (`bool`, default: `false`): Full-screen mode.
  /// - [data] (`CapturedData?`, optional): Captured data.
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
                  padding: fullScreen
                      ? EdgeInsets.zero
                      : const EdgeInsets.all(16) * scaling,
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

/// Displays a dialog using the shadcn_flutter design system.
///
/// Shows a modal dialog with consistent styling and animation behavior.
/// The dialog is displayed over the current route and blocks interaction
/// with the content below. Supports both centered and full-screen modes.
///
/// Features:
/// - Consistent design system integration
/// - Smooth scale and fade animations
/// - Configurable alignment and barriers
/// - Theme and data inheritance
/// - Safe area handling
/// - Custom transition animations
///
/// Parameters:
/// - [context] (BuildContext, required): build context for navigation
/// - [builder] (WidgetBuilder, required): function that builds dialog content
/// - [useRootNavigator] (bool, default: true): whether to use root navigator
/// - [barrierDismissible] (bool, default: true): tap outside to dismiss
/// - [barrierColor] (Color?, optional): color of the backdrop barrier
/// - [barrierLabel] (String?, optional): semantic label for the barrier
/// - [useSafeArea] (bool, default: true): respect device safe areas
/// - [routeSettings] (RouteSettings?, optional): settings for the route
/// - [anchorPoint] (Offset?, optional): anchor point for transitions
/// - [traversalEdgeBehavior] (TraversalEdgeBehavior?, optional): focus traversal
/// - [alignment] (AlignmentGeometry?, optional): dialog alignment, defaults to center
/// - [fullScreen] (bool, default: false): whether to display in full-screen mode
///
/// Returns:
/// A [Future] that resolves to the result passed to [Navigator.pop].
///
/// Example:
/// ```dart
/// final result = await showDialog<String>(
///   context: context,
///   builder: (context) => AlertDialog(
///     title: Text('Confirm'),
///     content: Text('Are you sure?'),
///     actions: [
///       TextButton(
///         onPressed: () => Navigator.pop(context, 'cancel'),
///         child: Text('Cancel'),
///       ),
///       TextButton(
///         onPressed: () => Navigator.pop(context, 'ok'),
///         child: Text('OK'),
///       ),
///     ],
///   ),
/// );
/// ```
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
    builder: (context) {
      return _DialogOverlayWrapper(
        route: ModalRoute.of(context) as DialogRoute<T>,
        child: Builder(builder: (context) {
          return builder(context);
        }),
      );
    },
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

/// Overlay handler that manages dialog display using the navigation stack.
///
/// Provides a standardized way to show dialogs through the overlay system
/// with proper theme inheritance, animation handling, and modal behavior.
/// Integrates with the shadcn_flutter overlay architecture for consistent
/// dialog management across the application.
///
/// Features:
/// - Navigation-based dialog management
/// - Theme and data inheritance
/// - Configurable modal barriers
/// - Animation integration
/// - Proper focus management
///
/// Example:
/// ```dart
/// const DialogOverlayHandler().show<String>(
///   context: context,
///   alignment: Alignment.center,
///   builder: (context) => MyCustomDialog(),
/// );
/// ```
class DialogOverlayHandler extends OverlayHandler {
  /// Checks if the current context is within a dialog overlay.
  ///
  /// Returns `true` if the context is inside a dialog managed by
  /// this overlay handler.
  static bool isDialogOverlay(BuildContext context) {
    return Model.maybeOf<bool>(context, #shadcn_flutter_dialog_overlay) == true;
  }

  /// Creates a [DialogOverlayHandler].
  ///
  /// Example:
  /// ```dart
  /// const DialogOverlayHandler()
  /// ```
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

/// Full-screen variant of the dialog overlay handler.
///
/// Similar to [DialogOverlayHandler] but specifically designed for full-screen
/// modal presentations. Removes padding and adjusts styling to fill the entire
/// screen while maintaining proper overlay management and animation behavior.
///
/// Features:
/// - Full-screen modal presentation
/// - Edge-to-edge content display
/// - Maintained overlay architecture
/// - Proper animation handling
/// - Theme inheritance
///
/// Example:
/// ```dart
/// const FullScreenDialogOverlayHandler().show<bool>(
///   context: context,
///   alignment: Alignment.center,
///   builder: (context) => FullScreenForm(),
/// );
/// ```
class FullScreenDialogOverlayHandler extends OverlayHandler {
  /// Checks if the current context is within a dialog overlay.
  ///
  /// Returns `true` if the context is inside a dialog managed by
  /// this overlay handler.
  static bool isDialogOverlay(BuildContext context) {
    return Model.maybeOf<bool>(context, #shadcn_flutter_dialog_overlay) == true;
  }

  /// Creates a [FullScreenDialogOverlayHandler].
  ///
  /// Example:
  /// ```dart
  /// const FullScreenDialogOverlayHandler()
  /// ```
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

/// Completer that manages the lifecycle of a dialog overlay.
///
/// Provides control over dialog animations, completion status, and disposal.
/// Wraps a [DialogRoute] to offer a consistent interface for managing
/// dialog lifecycles through the overlay system.
///
/// Features:
/// - Animation state monitoring
/// - Future-based completion handling
/// - Proper resource disposal
/// - Route management integration
///
/// Example:
/// ```dart
/// final completer = DialogOverlayCompleter(dialogRoute);
/// await completer.future; // Wait for dialog completion
/// completer.remove(); // Programmatically close dialog
/// ```
class DialogOverlayCompleter<T> extends OverlayCompleter<T> {
  /// The dialog route managed by this completer.
  final DialogRoute<T> route;

  /// Creates a [DialogOverlayCompleter].
  ///
  /// Parameters:
  /// - [route] (`DialogRoute<T>`, required): the dialog route to manage
  ///
  /// Example:
  /// ```dart
  /// DialogOverlayCompleter(myDialogRoute)
  /// ```
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
