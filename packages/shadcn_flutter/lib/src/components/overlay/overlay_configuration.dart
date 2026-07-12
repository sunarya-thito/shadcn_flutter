import '../../../shadcn_flutter.dart';

/// Describes *what* overlay to show and *how*, independent of the specific
/// mechanism (popover, drawer, sheet, dialog, menu, tooltip).
///
/// This replaces choosing an [OverlayHandler] per call site (or relying on a
/// single app-wide adaptive default in [ShadcnLayer]) with an explicit,
/// per-call configuration object. Each concrete subclass ([PopoverConfiguration],
/// [DrawerConfiguration], [SheetConfiguration], [DialogConfiguration],
/// [MenuConfiguration], [TooltipConfiguration]) knows how to present itself
/// via [show], and how to adapt itself for the current platform via
/// [adaptiveConversion].
///
/// Use [showOverlay] to present a configuration.
///
/// Example:
/// ```dart
/// showOverlay(
///   context,
///   PopoverConfiguration(
///     alignment: Alignment.topCenter,
///     builder: (context) => const Text('Popover content'),
///   ),
/// );
/// ```
abstract class OverlayConfiguration<T> {
  /// Creates an [OverlayConfiguration].
  const OverlayConfiguration();

  /// Actually presents the overlay using this configuration's mechanism.
  OverlayCompleter<T?> show(BuildContext context);

  /// Returns an equivalent configuration adapted for the current platform,
  /// e.g. a [PopoverConfiguration] becomes a [DrawerConfiguration] on mobile.
  ///
  /// Returns `this` by default (no adaptation). Called by [showOverlay] when
  /// `adaptive: true` (the default).
  OverlayConfiguration<T> adaptiveConversion(BuildContext context) => this;
}

/// Unified entry point for presenting any [OverlayConfiguration].
///
/// Replaces directly calling `showPopover`/`openDrawer`/`openSheet`/`showDialog`
/// or reaching for a specific [OverlayHandler]. When [adaptive] is true (the
/// default), [configuration] is first passed through
/// [OverlayConfiguration.adaptiveConversion] so it can present itself
/// differently depending on platform (e.g. a popover becoming a bottom drawer
/// on mobile), explicitly, per call site, instead of via a single app-wide
/// default.
///
/// Example:
/// ```dart
/// showOverlay(
///   context,
///   PopoverConfiguration(
///     alignment: Alignment.topCenter,
///     builder: (context) => const Text('Popover content'),
///   ),
///   adaptive: false, // force a popover even on mobile
/// );
/// ```
OverlayCompleter<T?> showOverlay<T>(
  BuildContext context,
  OverlayConfiguration<T> configuration, {
  bool adaptive = true,
}) {
  final resolved =
      adaptive ? configuration.adaptiveConversion(context) : configuration;
  return resolved.show(context);
}

/// [OverlayConfiguration] that presents its content as a popover.
///
/// On mobile platforms, [adaptiveConversion] converts this into a
/// [DrawerConfiguration] sliding up from the bottom, matching the historical
/// default behavior of `showPopover` under [ShadcnLayer]. Pass
/// `adaptive: false` to [showOverlay] (or call [show] directly) to always get
/// a real popover regardless of platform.
///
/// While shown, [OverlayController] can update this overlay in place (new
/// alignment, margin, etc.) by assigning a new [PopoverConfiguration] to the
/// live overlay's [OverlayCompleter.config].
class PopoverConfiguration<T> extends OverlayConfiguration<T> {
  /// The [Anchor] to position/track against ([LinkedAnchor] for an anchor
  /// key registered via [OverlayAnchor], or [ContextAnchor]), if using
  /// anchor-based positioning instead of the [BuildContext] passed to [show].
  final Anchor? anchor;

  /// Popover alignment relative to the anchor.
  final AlignmentGeometry alignment;

  /// Builds the popover content.
  final WidgetBuilder builder;

  /// Explicit position, overrides [alignment] if provided.
  final Offset? position;

  /// Anchor alignment point.
  final AlignmentGeometry? anchorAlignment;

  /// Width constraint mode.
  final PopoverConstraint widthConstraint;

  /// Height constraint mode.
  final PopoverConstraint heightConstraint;

  /// Widget key for the popover overlay.
  final Key? key;

  /// Whether to use the root overlay.
  final bool rootOverlay;

  /// Whether the popover is modal.
  final bool modal;

  /// Whether tapping the barrier dismisses the popover.
  final bool barrierDismissable;

  /// Clipping behavior for the popover content.
  final Clip clipBehavior;

  /// Region grouping identifier.
  final Object? regionGroupId;

  /// Additional position offset.
  final Offset? offset;

  /// Transition origin alignment.
  final AlignmentGeometry? transitionAlignment;

  /// Popover margin.
  final EdgeInsetsGeometry? margin;

  /// Whether the popover follows the anchor if it moves.
  final bool follow;

  /// Whether outside taps are consumed.
  final bool consumeOutsideTaps;

  /// Callback invoked on every follow tick.
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;

  /// Whether horizontal inversion is allowed when space is constrained.
  final bool allowInvertHorizontal;

  /// Whether vertical inversion is allowed when space is constrained.
  final bool allowInvertVertical;

  /// Whether to dismiss when backdrop gains focus.
  final bool dismissBackdropFocus;

  /// Show animation duration.
  final Duration? showDuration;

  /// Dismiss animation duration.
  final Duration? dismissDuration;

  /// Custom barrier configuration.
  final OverlayBarrier? overlayBarrier;

  /// Explicit [OverlayHandler] override. If null, resolves the ambient
  /// [OverlayManager] at [show] time.
  final OverlayHandler? handler;

  /// Creates a [PopoverConfiguration].
  const PopoverConfiguration({
    this.anchor,
    required this.alignment,
    required this.builder,
    this.position,
    this.anchorAlignment,
    this.widthConstraint = PopoverConstraint.flexible,
    this.heightConstraint = PopoverConstraint.flexible,
    this.key,
    this.rootOverlay = true,
    this.modal = true,
    this.barrierDismissable = true,
    this.clipBehavior = Clip.none,
    this.regionGroupId,
    this.offset,
    this.transitionAlignment,
    this.margin,
    this.follow = true,
    this.consumeOutsideTaps = true,
    this.onTickFollow,
    this.allowInvertHorizontal = true,
    this.allowInvertVertical = true,
    this.dismissBackdropFocus = true,
    this.showDuration,
    this.dismissDuration,
    this.overlayBarrier,
    this.handler,
  });

  /// Returns a copy of this configuration with the given fields replaced.
  PopoverConfiguration<T> copyWith({
    ValueGetter<Anchor?>? anchor,
    ValueGetter<AlignmentGeometry>? alignment,
    ValueGetter<WidgetBuilder>? builder,
    ValueGetter<Offset?>? position,
    ValueGetter<AlignmentGeometry?>? anchorAlignment,
    ValueGetter<PopoverConstraint>? widthConstraint,
    ValueGetter<PopoverConstraint>? heightConstraint,
    ValueGetter<Key?>? key,
    ValueGetter<bool>? rootOverlay,
    ValueGetter<bool>? modal,
    ValueGetter<bool>? barrierDismissable,
    ValueGetter<Clip>? clipBehavior,
    ValueGetter<Object?>? regionGroupId,
    ValueGetter<Offset?>? offset,
    ValueGetter<AlignmentGeometry?>? transitionAlignment,
    ValueGetter<EdgeInsetsGeometry?>? margin,
    ValueGetter<bool>? follow,
    ValueGetter<bool>? consumeOutsideTaps,
    ValueGetter<ValueChanged<PopoverOverlayWidgetState>?>? onTickFollow,
    ValueGetter<bool>? allowInvertHorizontal,
    ValueGetter<bool>? allowInvertVertical,
    ValueGetter<bool>? dismissBackdropFocus,
    ValueGetter<Duration?>? showDuration,
    ValueGetter<Duration?>? dismissDuration,
    ValueGetter<OverlayBarrier?>? overlayBarrier,
    ValueGetter<OverlayHandler?>? handler,
  }) {
    return PopoverConfiguration<T>(
      anchor: anchor == null ? this.anchor : anchor(),
      alignment: alignment == null ? this.alignment : alignment(),
      builder: builder == null ? this.builder : builder(),
      position: position == null ? this.position : position(),
      anchorAlignment:
          anchorAlignment == null ? this.anchorAlignment : anchorAlignment(),
      widthConstraint:
          widthConstraint == null ? this.widthConstraint : widthConstraint(),
      heightConstraint:
          heightConstraint == null ? this.heightConstraint : heightConstraint(),
      key: key == null ? this.key : key(),
      rootOverlay: rootOverlay == null ? this.rootOverlay : rootOverlay(),
      modal: modal == null ? this.modal : modal(),
      barrierDismissable: barrierDismissable == null
          ? this.barrierDismissable
          : barrierDismissable(),
      clipBehavior: clipBehavior == null ? this.clipBehavior : clipBehavior(),
      regionGroupId:
          regionGroupId == null ? this.regionGroupId : regionGroupId(),
      offset: offset == null ? this.offset : offset(),
      transitionAlignment: transitionAlignment == null
          ? this.transitionAlignment
          : transitionAlignment(),
      margin: margin == null ? this.margin : margin(),
      follow: follow == null ? this.follow : follow(),
      consumeOutsideTaps: consumeOutsideTaps == null
          ? this.consumeOutsideTaps
          : consumeOutsideTaps(),
      onTickFollow: onTickFollow == null ? this.onTickFollow : onTickFollow(),
      allowInvertHorizontal: allowInvertHorizontal == null
          ? this.allowInvertHorizontal
          : allowInvertHorizontal(),
      allowInvertVertical: allowInvertVertical == null
          ? this.allowInvertVertical
          : allowInvertVertical(),
      dismissBackdropFocus: dismissBackdropFocus == null
          ? this.dismissBackdropFocus
          : dismissBackdropFocus(),
      showDuration: showDuration == null ? this.showDuration : showDuration(),
      dismissDuration:
          dismissDuration == null ? this.dismissDuration : dismissDuration(),
      overlayBarrier:
          overlayBarrier == null ? this.overlayBarrier : overlayBarrier(),
      handler: handler == null ? this.handler : handler(),
    );
  }

  @override
  OverlayCompleter<T?> show(BuildContext context) {
    final resolvedHandler = handler ?? OverlayManager.of(context);
    return resolvedHandler.show<T>(
      context: context,
      anchor: anchor,
      alignment: alignment,
      builder: builder,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      rootOverlay: rootOverlay,
      modal: modal,
      barrierDismissable: barrierDismissable,
      clipBehavior: clipBehavior,
      regionGroupId: regionGroupId,
      offset: offset,
      transitionAlignment: transitionAlignment,
      margin: margin,
      follow: follow,
      consumeOutsideTaps: consumeOutsideTaps,
      onTickFollow: onTickFollow,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      dismissBackdropFocus: dismissBackdropFocus,
      showDuration: showDuration,
      dismissDuration: dismissDuration,
      overlayBarrier: overlayBarrier,
    );
  }

  @override
  OverlayConfiguration<T> adaptiveConversion(BuildContext context) {
    if (handler == null && isMobile(Theme.of(context).platform)) {
      return toDrawer();
    }
    return this;
  }

  /// Converts this configuration into an equivalent [DrawerConfiguration].
  ///
  /// Used automatically by [adaptiveConversion] on mobile platforms; can also
  /// be called directly for manual conversion.
  DrawerConfiguration<T> toDrawer({
    OverlayPosition position = OverlayPosition.bottom,
  }) {
    return DrawerConfiguration<T>(
      anchor: anchor,
      builder: builder,
      position: position,
      barrierDismissible: barrierDismissable,
    );
  }
}

/// [OverlayConfiguration] that presents its content as a side/bottom drawer
/// (with backdrop transform).
///
/// Already the mobile-appropriate mechanism, so [adaptiveConversion] is the
/// identity conversion (no adaptation performed).
class DrawerConfiguration<T> extends OverlayConfiguration<T> {
  /// The [Anchor] to resolve against ([LinkedAnchor] for an anchor key
  /// registered via [OverlayAnchor], or [ContextAnchor]), if using
  /// anchor-based positioning instead of the [BuildContext] passed to [show].
  final Anchor? anchor;

  /// Builds the drawer content.
  final WidgetBuilder builder;

  /// The edge the drawer slides in from.
  final OverlayPosition position;

  /// Whether the drawer expands to fill available space.
  final bool expands;

  /// Whether the drawer can be dragged to dismiss.
  final bool draggable;

  /// Whether tapping the barrier dismisses the drawer.
  final bool barrierDismissible;

  /// Custom backdrop builder.
  final WidgetBuilder? backdropBuilder;

  /// Whether to respect device safe areas.
  final bool useSafeArea;

  /// Whether to show a drag handle.
  final bool? showDragHandle;

  /// Corner radius for the drawer.
  final BorderRadiusGeometry? borderRadius;

  /// Size of the drag handle.
  final Size? dragHandleSize;

  /// Whether to scale/transform the backdrop.
  final bool transformBackdrop;

  /// Opacity for surface effects.
  final double? surfaceOpacity;

  /// Blur intensity for surface effects.
  final double? surfaceBlur;

  /// Color of the modal barrier.
  final Color? barrierColor;

  /// Custom animation controller.
  final AnimationController? animationController;

  /// Whether to automatically open on creation.
  final bool autoOpen;

  /// Size constraints for the drawer.
  final BoxConstraints? constraints;

  /// Alignment within constraints.
  final AlignmentGeometry? alignment;

  /// Creates a [DrawerConfiguration].
  const DrawerConfiguration({
    this.anchor,
    required this.builder,
    this.position = OverlayPosition.bottom,
    this.expands = false,
    this.draggable = true,
    this.barrierDismissible = true,
    this.backdropBuilder,
    this.useSafeArea = true,
    this.showDragHandle,
    this.borderRadius,
    this.dragHandleSize,
    this.transformBackdrop = true,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.barrierColor,
    this.animationController,
    this.autoOpen = true,
    this.constraints,
    this.alignment,
  });

  @override
  OverlayCompleter<T?> show(BuildContext context) {
    // ignore: deprecated_member_use_from_same_package
    return openDrawerOverlay<T>(
      context: context,
      anchor: anchor,
      builder: builder,
      position: position,
      expands: expands,
      draggable: draggable,
      barrierDismissible: barrierDismissible,
      backdropBuilder: backdropBuilder,
      useSafeArea: useSafeArea,
      showDragHandle: showDragHandle,
      borderRadius: borderRadius,
      dragHandleSize: dragHandleSize,
      transformBackdrop: transformBackdrop,
      surfaceOpacity: surfaceOpacity,
      surfaceBlur: surfaceBlur,
      barrierColor: barrierColor,
      animationController: animationController,
      autoOpen: autoOpen,
      constraints: constraints,
      alignment: alignment,
    );
  }
}

/// [OverlayConfiguration] that presents its content as a minimally-styled,
/// full-extent sheet (no backdrop transform, unlike [DrawerConfiguration]).
///
/// Already the mobile-appropriate mechanism, so [adaptiveConversion] is the
/// identity conversion (no adaptation performed).
class SheetConfiguration<T> extends OverlayConfiguration<T> {
  /// The [Anchor] to resolve against ([LinkedAnchor] for an anchor key
  /// registered via [OverlayAnchor], or [ContextAnchor]), if using
  /// anchor-based positioning instead of the [BuildContext] passed to [show].
  final Anchor? anchor;

  /// Builds the sheet content.
  final WidgetBuilder builder;

  /// The edge the sheet slides in from.
  final OverlayPosition position;

  /// Whether tapping the barrier dismisses the sheet.
  final bool barrierDismissible;

  /// Whether to transform the backdrop.
  final bool transformBackdrop;

  /// Custom backdrop builder.
  final WidgetBuilder? backdropBuilder;

  /// Color of the modal barrier.
  final Color? barrierColor;

  /// Whether the sheet can be dragged to dismiss.
  final bool draggable;

  /// Custom animation controller.
  final AnimationController? animationController;

  /// Whether to automatically open on creation.
  final bool autoOpen;

  /// Size constraints for the sheet.
  final BoxConstraints? constraints;

  /// Alignment within constraints.
  final AlignmentGeometry? alignment;

  /// Creates a [SheetConfiguration].
  const SheetConfiguration({
    this.anchor,
    required this.builder,
    this.position = OverlayPosition.bottom,
    this.barrierDismissible = true,
    this.transformBackdrop = false,
    this.backdropBuilder,
    this.barrierColor,
    this.draggable = false,
    this.animationController,
    this.autoOpen = true,
    this.constraints,
    this.alignment,
  });

  @override
  OverlayCompleter<T?> show(BuildContext context) {
    // ignore: deprecated_member_use_from_same_package
    return openSheetOverlay<T>(
      context: context,
      anchor: anchor,
      builder: builder,
      position: position,
      barrierDismissible: barrierDismissible,
      transformBackdrop: transformBackdrop,
      backdropBuilder: backdropBuilder,
      barrierColor: barrierColor,
      draggable: draggable,
      animationController: animationController,
      autoOpen: autoOpen,
      constraints: constraints,
      alignment: alignment,
    );
  }
}

/// [OverlayConfiguration] that presents its content as a modal dialog via
/// [Navigator]/[DialogRoute].
///
/// Dialogs are usually an intentional choice regardless of platform, so
/// [adaptiveConversion] is the identity conversion (no adaptation performed).
///
/// `showDialog` only exposes a [Future], so [OverlayCompleter.remove] and
/// [OverlayCompleter.dispose] do nothing here. Close the dialog with
/// `Navigator.pop` or `closeOverlay` instead.
class DialogConfiguration<T> extends OverlayConfiguration<T> {
  /// Builds the dialog content.
  final WidgetBuilder builder;

  /// Whether to use the root navigator.
  final bool useRootNavigator;

  /// Whether tapping outside dismisses the dialog.
  final bool barrierDismissible;

  /// Color of the backdrop barrier.
  final Color? barrierColor;

  /// Semantic label for the barrier.
  final String? barrierLabel;

  /// Whether to respect device safe areas.
  final bool useSafeArea;

  /// Settings for the route.
  final RouteSettings? routeSettings;

  /// Anchor point for transitions.
  final Offset? anchorPoint;

  /// Focus traversal edge behavior.
  final TraversalEdgeBehavior? traversalEdgeBehavior;

  /// Dialog alignment, defaults to center.
  final AlignmentGeometry? alignment;

  /// Whether to display in full-screen mode.
  final bool fullScreen;

  /// Creates a [DialogConfiguration].
  const DialogConfiguration({
    required this.builder,
    this.useRootNavigator = true,
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    this.useSafeArea = true,
    this.routeSettings,
    this.anchorPoint,
    this.traversalEdgeBehavior,
    this.alignment,
    this.fullScreen = false,
  });

  @override
  OverlayCompleter<T?> show(BuildContext context) {
    final navigatorState = Navigator.of(
      context,
      rootNavigator: useRootNavigator,
    );
    final CapturedThemes themes =
        InheritedTheme.capture(from: context, to: navigatorState.context);
    final CapturedData data =
        Data.capture(from: context, to: navigatorState.context);
    final dialogRoute = DialogRoute<T>(
      context: context,
      builder: (context) {
        return DialogOverlayContent<T>(
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
        return buildShadcnDialogTransitions(
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
    final future = navigatorState.push(dialogRoute);
    return _FutureOverlayCompleter<T>(future);
  }
}

/// [OverlayConfiguration] that presents its content as a menu via the
/// ambient [OverlayManager].
///
/// On mobile platforms, [adaptiveConversion] converts this into a
/// [DrawerConfiguration], matching the historical default `menuHandler`
/// behavior under [ShadcnLayer].
class MenuConfiguration<T> extends OverlayConfiguration<T> {
  /// Builds the menu content.
  final WidgetBuilder builder;

  /// Menu alignment relative to the anchor.
  final AlignmentGeometry alignment;

  /// Explicit position, overrides [alignment] if provided.
  final Offset? position;

  /// Anchor alignment point.
  final AlignmentGeometry? anchorAlignment;

  /// Width constraint mode.
  final PopoverConstraint widthConstraint;

  /// Height constraint mode.
  final PopoverConstraint heightConstraint;

  /// Whether to use the root overlay.
  final bool rootOverlay;

  /// Whether the menu is modal.
  final bool modal;

  /// Whether tapping the barrier dismisses the menu.
  final bool barrierDismissable;

  /// Clipping behavior for the menu content.
  final Clip clipBehavior;

  /// Additional position offset.
  final Offset? offset;

  /// Whether the menu follows the anchor if it moves.
  final bool follow;

  /// Custom barrier configuration.
  final OverlayBarrier? overlayBarrier;

  /// Widget key for the menu overlay.
  final Key? key;

  /// Creates a [MenuConfiguration].
  const MenuConfiguration({
    required this.builder,
    this.alignment = Alignment.center,
    this.position,
    this.anchorAlignment,
    this.widthConstraint = PopoverConstraint.flexible,
    this.heightConstraint = PopoverConstraint.flexible,
    this.rootOverlay = true,
    this.modal = true,
    this.barrierDismissable = true,
    this.clipBehavior = Clip.none,
    this.offset,
    this.follow = true,
    this.overlayBarrier,
    this.key,
  });

  @override
  OverlayCompleter<T?> show(BuildContext context) {
    return OverlayManager.of(context).showMenu<T>(
      context: context,
      builder: builder,
      alignment: alignment,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      key: key,
      rootOverlay: rootOverlay,
      modal: modal,
      barrierDismissable: barrierDismissable,
      clipBehavior: clipBehavior,
      offset: offset,
      follow: follow,
      overlayBarrier: overlayBarrier,
    );
  }

  @override
  OverlayConfiguration<T> adaptiveConversion(BuildContext context) {
    if (isMobile(Theme.of(context).platform)) {
      return DrawerConfiguration<T>(builder: builder);
    }
    return this;
  }
}

/// [OverlayConfiguration] that presents its content as a tooltip via the
/// ambient [OverlayManager].
///
/// [adaptiveConversion] returns the configuration unchanged. The
/// `tooltipHandler` that [OverlayManager] injects under [ShadcnLayer] already
/// picks a fixed tooltip implementation appropriate for mobile.
class TooltipConfiguration<T> extends OverlayConfiguration<T> {
  /// Builds the tooltip content.
  final WidgetBuilder builder;

  /// Tooltip alignment relative to the anchor.
  final AlignmentGeometry alignment;

  /// Explicit position, overrides [alignment] if provided.
  final Offset? position;

  /// Anchor alignment point.
  final AlignmentGeometry? anchorAlignment;

  /// Additional position offset.
  final Offset? offset;

  /// Whether the tooltip follows the anchor if it moves.
  final bool follow;

  /// Widget key for the tooltip overlay.
  final Key? key;

  /// Creates a [TooltipConfiguration].
  const TooltipConfiguration({
    required this.builder,
    this.alignment = Alignment.center,
    this.position,
    this.anchorAlignment,
    this.offset,
    this.follow = true,
    this.key,
  });

  @override
  OverlayCompleter<T?> show(BuildContext context) {
    return OverlayManager.of(context).showTooltip<T>(
      context: context,
      builder: builder,
      alignment: alignment,
      position: position,
      anchorAlignment: anchorAlignment,
      offset: offset,
      follow: follow,
      key: key,
      modal: false,
      barrierDismissable: false,
      consumeOutsideTaps: false,
    );
  }
}

/// Adapts a plain [Future]-based result (as returned by `showDialog`) to the
/// [OverlayCompleter] interface expected by [OverlayConfiguration.show].
///
/// [remove] and [dispose] are no-ops since a [Future] alone doesn't expose a
/// way to imperatively dismiss the underlying route.
class _FutureOverlayCompleter<T> extends OverlayCompleter<T?> {
  @override
  final Future<T?> future;

  bool _completed = false;

  _FutureOverlayCompleter(this.future) {
    future.whenComplete(() => _completed = true);
  }

  @override
  Future<void> get animationFuture => future.then((_) {});

  @override
  bool get isCompleted => _completed;

  @override
  bool get isAnimationCompleted => _completed;

  @override
  void remove() {}

  @override
  void dispose() {}
}

/// A controller for managing a single overlay's lifecycle, driven by
/// [OverlayConfiguration] instead of popover-specific parameters.
///
/// Replaces [PopoverController]: [show] accepts any [OverlayConfiguration]
/// (popover, menu, tooltip, drawer, sheet, dialog), so a single controller
/// can drive an overlay regardless of its presentation mechanism.
///
/// If [show] is called again with the same configuration type (still a
/// [PopoverConfiguration], say, just with a different
/// [PopoverConfiguration.alignment]), the open overlay is updated in place
/// through [OverlayCompleter.config] rather than being closed and reopened.
/// A different configuration type, or no overlay currently open, always
/// closes whatever is open and starts fresh.
///
/// Field meanings like "alignment" or "margin" aren't interpreted here.
/// Each [OverlayCompleter] implementation, for example the one
/// [PopoverOverlayHandler] returns, reads whatever configuration it's
/// assigned through [OverlayCompleter.config] on its own terms.
///
/// Example:
/// ```dart
/// class _MyWidgetState extends State<MyWidget> {
///   final OverlayController _controller = OverlayController();
///
///   @override
///   void dispose() {
///     _controller.dispose();
///     super.dispose();
///   }
///
///   void _showMenu() async {
///     await _controller.show(
///       context,
///       PopoverConfiguration(
///         anchor: LinkedAnchor(#myAnchor),
///         alignment: Alignment.bottomStart,
///         builder: (context) => MyPopoverContent(),
///       ),
///     );
///   }
/// }
/// ```
class OverlayController extends ChangeNotifier {
  bool _disposed = false;
  OverlayCompleter? _completer;
  OverlayConfiguration? _config;

  /// The configuration of the currently-open overlay, or `null` if nothing
  /// is open. There's no setter: use [show] to open or update an overlay,
  /// since assigning [config] directly has no [BuildContext] to anchor to.
  OverlayConfiguration? get config => _config;

  /// Whether there's an open overlay that hasn't completed.
  bool get hasOpenOverlay => _completer != null && !_completer!.isCompleted;

  /// Whether there's a mounted overlay with an animation in progress.
  bool get hasMountedOverlay =>
      _completer != null && !_completer!.isAnimationCompleted;

  /// Shows an overlay using the given [configuration], anchored to [context].
  ///
  /// If an overlay managed by this controller is already open with a
  /// configuration of the exact same runtime type as [configuration], it's
  /// updated in place via [OverlayCompleter.config] (see class docs);
  /// otherwise it's closed and the new configuration is opened fresh.
  /// [adaptive] is forwarded to [OverlayConfiguration.adaptiveConversion].
  Future<T?> show<T>(
    BuildContext context,
    OverlayConfiguration<T> configuration, {
    bool adaptive = true,
  }) {
    final resolved =
        adaptive ? configuration.adaptiveConversion(context) : configuration;

    final currentCompleter = _completer;
    final currentConfig = _config;
    if (currentCompleter != null &&
        !currentCompleter.isCompleted &&
        currentConfig != null &&
        resolved.runtimeType == currentConfig.runtimeType) {
      currentCompleter.config = resolved;
      _config = resolved;
      notifyListeners();
      return currentCompleter.future as Future<T?>;
    }

    close();
    final completer = resolved.show(context);
    _completer = completer;
    _config = resolved;
    notifyListeners();
    completer.future.whenComplete(() {
      if (identical(_completer, completer)) {
        _completer = null;
        _config = null;
        if (!_disposed) {
          notifyListeners();
        }
      }
    });
    return completer.future;
  }

  /// Closes the managed overlay, if any.
  ///
  /// Parameters:
  /// - [immediate] (bool, default: false): Skip closing animations when true.
  void close([bool immediate = false]) {
    final completer = _completer;
    if (completer == null) return;
    completer.close(immediate);
    _completer = null;
    _config = null;
    notifyListeners();
  }

  /// Schedules closure of the managed overlay for the next frame.
  void closeLater() {
    final completer = _completer;
    if (completer == null) return;
    completer.closeLater();
    _completer = null;
    _config = null;
    notifyListeners();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    closeLater();
    super.dispose();
  }
}
