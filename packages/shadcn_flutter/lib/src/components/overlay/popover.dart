import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Handles overlay presentation for popover components.
///
/// Manages the display, positioning, and lifecycle of popover overlays
/// with support for alignment, constraints, and modal behavior.
class PopoverOverlayHandler extends OverlayHandler {
  /// Creates a [PopoverOverlayHandler].
  const PopoverOverlayHandler();
  @override
  OverlayCompleter<T> show<T>({
    required BuildContext context,
    required AlignmentGeometry alignment,
    required WidgetBuilder builder,
    ui.Offset? position,
    AlignmentGeometry? anchorAlignment,
    PopoverConstraint widthConstraint = PopoverConstraint.flexible,
    PopoverConstraint heightConstraint = PopoverConstraint.flexible,
    Key? key,
    bool rootOverlay = true,
    bool modal = true,
    bool barrierDismissable = true,
    ui.Clip clipBehavior = Clip.none,
    Object? regionGroupId,
    ui.Offset? offset,
    AlignmentGeometry? transitionAlignment,
    EdgeInsetsGeometry? margin,
    bool follow = true,
    bool consumeOutsideTaps = true,
    Anchor? anchor,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  }) {
    final Anchor resolvedAnchor =
        (anchor ?? const ContextAnchor()).resolve(context);

    BuildContext resolvedContext = context;
    if (resolvedAnchor is ContextAnchor) {
      resolvedContext = resolvedAnchor.context ?? context;
    } else if (resolvedAnchor is LinkedAnchor) {
      final registry = resolvedAnchor.registry ?? OverlayAnchorRegistry.global;
      resolvedContext =
          registry.find(resolvedAnchor.key)?.context ?? context;
    }

    final subscription = resolvedAnchor.subscribe();
    if (!subscription.isVisible) {
      final popoverEntry = OverlayPopoverEntry<T>();
      popoverEntry.completer.complete();
      popoverEntry.animationCompleter.complete();
      return popoverEntry;
    }

    TextDirection textDirection = Directionality.of(resolvedContext);
    Alignment resolvedAlignment = alignment.resolve(textDirection);
    anchorAlignment ??= alignment * -1;
    Alignment resolvedAnchorAlignment = anchorAlignment.resolve(textDirection);
    final OverlayState overlay =
        Overlay.of(resolvedContext, rootOverlay: rootOverlay);
    final themes =
        InheritedTheme.capture(from: resolvedContext, to: overlay.context);
    final data = Data.capture(from: resolvedContext, to: overlay.context);

    Size? anchorSize = subscription.anchorSize;
    if (position == null) {
      RenderBox renderBox = resolvedContext.findRenderObject() as RenderBox;
      Offset pos = renderBox.localToGlobal(Offset.zero);
      anchorSize ??= renderBox.size;
      position = Offset(
        pos.dx +
            anchorSize.width / 2 +
            anchorSize.width / 2 * resolvedAnchorAlignment.x,
        pos.dy +
            anchorSize.height / 2 +
            anchorSize.height / 2 * resolvedAnchorAlignment.y,
      );
    }
    final OverlayPopoverEntry<T> popoverEntry = OverlayPopoverEntry();
    final GlobalKey<PopoverOverlayWidgetState> resolvedKey = key
            is GlobalKey<PopoverOverlayWidgetState>
        ? key
        : GlobalKey<PopoverOverlayWidgetState>(debugLabel: 'PopoverAnchor$key');
    popoverEntry.stateKey = resolvedKey;
    key = resolvedKey;
    final completer = popoverEntry.completer;
    final animationCompleter = popoverEntry.animationCompleter;
    ValueNotifier<bool> isClosed = ValueNotifier(false);
    Future<T?> onClose() {
      if (isClosed.value) return Future.value();
      isClosed.value = true;
      completer.complete();
      return animationCompleter.future;
    }

    void onImmediateClose() {
      popoverEntry.remove();
      completer.complete();
    }

    Future<T?> onCloseWithResult(Object? value) {
      if (isClosed.value) return Future.value();
      isClosed.value = true;
      completer.complete(value as T);
      return animationCompleter.future;
    }

    popoverEntry.onClose = onClose;
    popoverEntry.onImmediateClose = onImmediateClose;
    popoverEntry.onCloseWithResult = onCloseWithResult;
    OverlayEntry? barrierEntry;
    late OverlayEntry overlayEntry;
    if (modal) {
      if (consumeOutsideTaps) {
        barrierEntry = OverlayEntry(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                if (!barrierDismissable || isClosed.value) return;
                isClosed.value = true;
                completer.complete();
              },
            );
          },
        );
      } else {
        barrierEntry = OverlayEntry(
          builder: (context) {
            return Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (event) {
                if (!barrierDismissable || isClosed.value) return;
                isClosed.value = true;
                completer.complete();
              },
            );
          },
        );
      }
    }

    overlayEntry = OverlayEntry(
      builder: (innerContext) {
        return RepaintBoundary(
          child: AnimatedBuilder(
              animation: isClosed,
              builder: (innerContext, child) {
                return FocusScope(
                  autofocus: dismissBackdropFocus,
                  canRequestFocus: !isClosed.value,
                  child: AnimatedValueBuilder.animation(
                      value: isClosed.value ? 0.0 : 1.0,
                      initialValue: 0.0,
                      curve: isClosed.value
                          ? const Interval(0, 2 / 3)
                          : Curves.linear,
                      duration: isClosed.value
                          ? (showDuration ?? kDefaultDuration)
                          : (dismissDuration ??
                              const Duration(milliseconds: 100)),
                      onEnd: (value) {
                        if (value == 0.0 && isClosed.value) {
                          popoverEntry.remove();
                          popoverEntry.dispose();
                          animationCompleter.complete();
                        }
                      },
                      builder: (innerContext, animation) {
                        var popoverAnchor = PopoverOverlayWidget(
                          animation: animation,
                          onTapOutside: () {
                            if (isClosed.value) return;
                            if (!modal) {
                              isClosed.value = true;
                              completer.complete();
                            }
                          },
                          key: key,
                          anchor: resolvedAnchor,
                          position: position!,
                          alignment: resolvedAlignment,
                          themes: themes,
                          builder: builder,
                          anchorSize: anchorSize,
                          // anchorAlignment: anchorAlignment ?? alignment * -1,
                          anchorAlignment: resolvedAnchorAlignment,
                          widthConstraint: widthConstraint,
                          heightConstraint: heightConstraint,
                          regionGroupId: regionGroupId,
                          offset: offset,
                          transitionAlignment: transitionAlignment,
                          margin: margin,
                          follow: follow,
                          consumeOutsideTaps: consumeOutsideTaps,
                          onTickFollow: onTickFollow,
                          allowInvertHorizontal: allowInvertHorizontal,
                          allowInvertVertical: allowInvertVertical,
                          data: data,
                          onClose: onClose,
                          onImmediateClose: onImmediateClose,
                          onCloseWithResult: onCloseWithResult,
                          completer: popoverEntry,
                        );
                        return popoverAnchor;
                      }),
                );
              }),
        );
      },
    );
    popoverEntry.initialize(overlayEntry, barrierEntry);
    if (barrierEntry != null) {
      overlay.insert(barrierEntry);
    }
    overlay.insert(overlayEntry);
    return popoverEntry;
  }
}

/// Internal widget for rendering popover overlays.
///
/// Manages positioning, constraints, and lifecycle of popover content
/// relative to an anchor widget.
class PopoverOverlayWidget extends StatefulWidget {
  /// Creates a [PopoverOverlayWidget].
  const PopoverOverlayWidget({
    super.key,
    required this.anchor,
    this.position,
    required this.alignment,
    this.themes,
    required this.builder,
    required this.animation,
    required this.anchorAlignment,
    this.widthConstraint = PopoverConstraint.flexible,
    this.heightConstraint = PopoverConstraint.flexible,
    this.anchorSize,
    // this.route,
    this.onTapOutside,
    this.regionGroupId,
    this.offset,
    this.transitionAlignment,
    this.margin,
    this.follow = true,
    this.consumeOutsideTaps = true,
    this.onTickFollow,
    this.allowInvertHorizontal = true,
    this.allowInvertVertical = true,
    this.data,
    this.onClose,
    this.onImmediateClose,
    this.onCloseWithResult,
    this.completer,
  });

  /// Explicit position for the popover.
  final Offset? position;

  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry alignment;

  /// Alignment point on the anchor widget.
  final AlignmentGeometry anchorAlignment;

  /// Captured theme data from context.
  final CapturedThemes? themes;

  /// Captured inherited data from context.
  final CapturedData? data;

  /// Builder function for popover content.
  final WidgetBuilder builder;

  /// Size of the anchor widget.
  final Size? anchorSize;

  /// Animation controller for show/hide transitions.
  final Animation<double> animation;

  /// Width constraint mode for the popover.
  final PopoverConstraint widthConstraint;

  /// Height constraint mode for the popover.
  final PopoverConstraint heightConstraint;

  // final PopoverRoute? route;

  /// Callback when popover is closing.
  final FutureVoidCallback? onClose;

  /// Callback for immediate close without animation.
  final VoidCallback? onImmediateClose;

  /// Callback when user taps outside the popover.
  final VoidCallback? onTapOutside;

  /// Region group identifier for coordinating multiple overlays.
  final Object? regionGroupId;

  /// Additional offset applied to popover position.
  final Offset? offset;

  /// Alignment for transition animations.
  final AlignmentGeometry? transitionAlignment;

  /// Margin around the popover.
  final EdgeInsetsGeometry? margin;

  /// Whether popover follows anchor movement.
  final bool follow;

  /// The anchor this popover is positioned/tracked against.
  final Anchor anchor;

  /// Whether to consume taps outside the popover.
  final bool consumeOutsideTaps;

  /// Callback on each frame when following anchor.
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;

  /// Allow horizontal inversion when constrained.
  final bool allowInvertHorizontal;

  /// Allow vertical inversion when constrained.
  final bool allowInvertVertical;

  /// Callback when closing with a result value.
  final PopoverFutureVoidCallback<Object?>? onCloseWithResult;

  /// The completer that manages this popover's lifecycle, if shown via a
  /// [PopoverOverlayHandler]-style `show()`. When non-null, it's inherited
  /// into the content subtree so [closeOverlay] can find it from within.
  final OverlayCompleter? completer;

  @override
  State<PopoverOverlayWidget> createState() => PopoverOverlayWidgetState();
}

/// Callback type for popover futures with value transformation.
///
/// Parameters:
/// - [value] (T): Input value to transform
///
/// Returns a [Future] with the transformed value.
typedef PopoverFutureVoidCallback<T> = Future<T> Function(T value);

/// Size constraint strategies for popover overlays.
///
/// - `flexible`: Size flexibly based on content and available space
/// - `intrinsic`: Use intrinsic content size
/// - `anchorFixedSize`: Match anchor's exact size
/// - `anchorMinSize`: Use anchor size as minimum
/// - `anchorMaxSize`: Use anchor size as maximum
enum PopoverConstraint {
  /// Size flexibly based on content and available space
  flexible,

  /// Use intrinsic content size
  intrinsic,

  /// Match anchor's exact size
  anchorFixedSize,

  /// Use anchor size as minimum
  anchorMinSize,

  /// Use anchor size as maximum
  anchorMaxSize,
}

/// State class for [PopoverOverlayWidget] managing popover positioning and lifecycle.
///
/// Handles dynamic positioning, anchor tracking, size constraints, and
/// animation for popover overlays. Its lifecycle (close/closeLater) and live
/// configuration updates are driven externally by the [OverlayPopoverEntry]
/// (an [OverlayCompleter]) returned from [PopoverOverlayHandler.show].
class PopoverOverlayWidgetState extends State<PopoverOverlayWidget> {
  late Anchor _anchor;
  late AnchorSubscription _subscription;
  late Offset? _position;
  late Offset? _offset;
  late AlignmentGeometry _alignment;
  late AlignmentGeometry _anchorAlignment;
  late PopoverConstraint _widthConstraint;
  late PopoverConstraint _heightConstraint;
  late EdgeInsetsGeometry? _margin;
  Size? _anchorSize;
  late bool _follow;
  late bool _allowInvertHorizontal;
  late bool _allowInvertVertical;
  OverlayConfiguration? _config;

  /// The configuration currently applied to this popover, if assigned via
  /// [config].
  OverlayConfiguration? get config => _config;

  /// Applies a new configuration's live-updatable fields (alignment, margin,
  /// width/height constraint, follow, offset, invert permissions), matching
  /// whichever of [PopoverConfiguration], [MenuConfiguration], or
  /// [TooltipConfiguration] it is.
  set config(OverlayConfiguration? value) {
    _config = value;
    if (value is PopoverConfiguration) {
      setState(() {
        _alignment = value.alignment;
        final anchorAlignment = value.anchorAlignment;
        if (anchorAlignment != null) _anchorAlignment = anchorAlignment;
        _widthConstraint = value.widthConstraint;
        _heightConstraint = value.heightConstraint;
        final margin = value.margin;
        if (margin != null) _margin = margin;
        _follow = value.follow;
        final offset = value.offset;
        if (offset != null) _offset = offset;
        _allowInvertHorizontal = value.allowInvertHorizontal;
        _allowInvertVertical = value.allowInvertVertical;
        _syncSubscription();
      });
    } else if (value is MenuConfiguration) {
      setState(() {
        _alignment = value.alignment;
        final anchorAlignment = value.anchorAlignment;
        if (anchorAlignment != null) _anchorAlignment = anchorAlignment;
        _widthConstraint = value.widthConstraint;
        _heightConstraint = value.heightConstraint;
        _follow = value.follow;
        final offset = value.offset;
        if (offset != null) _offset = offset;
        _syncSubscription();
      });
    } else if (value is TooltipConfiguration) {
      setState(() {
        _alignment = value.alignment;
        final anchorAlignment = value.anchorAlignment;
        if (anchorAlignment != null) _anchorAlignment = anchorAlignment;
        _follow = value.follow;
        final offset = value.offset;
        if (offset != null) _offset = offset;
        _syncSubscription();
      });
    }
  }

  /// Directly updates the margin without going through [config].
  ///
  /// Used for continuous per-frame adjustments during follow (e.g.
  /// [NavigationMenu] recomputing a content-dependent margin on every
  /// [PopoverOverlayHandler.show]'s `onTickFollow` tick), which is a
  /// different concern from swapping to a new discrete configuration.
  void updateMargin(EdgeInsetsGeometry margin) {
    if (_margin != margin) {
      setState(() {
        _margin = margin;
      });
    }
  }

  void _syncSubscription() {
    if (_follow) {
      _subscription.addListener(_handleAnchorUpdate);
    } else {
      _subscription.removeListener(_handleAnchorUpdate);
    }
  }

  @override
  void initState() {
    super.initState();
    _offset = widget.offset;
    _position = widget.position;
    _alignment = widget.alignment;
    _anchorSize = widget.anchorSize;
    _anchorAlignment = widget.anchorAlignment;
    _widthConstraint = widget.widthConstraint;
    _heightConstraint = widget.heightConstraint;
    _margin = widget.margin;
    _follow = widget.follow;
    _anchor = widget.anchor;
    _subscription = _anchor.subscribe();
    _allowInvertHorizontal = widget.allowInvertHorizontal;
    _allowInvertVertical = widget.allowInvertVertical;
    _syncSubscription();
  }

  @override
  void didUpdateWidget(covariant PopoverOverlayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.alignment != widget.alignment) {
      _alignment = widget.alignment;
    }
    if (oldWidget.anchorSize != widget.anchorSize) {
      _anchorSize = widget.anchorSize;
    }
    if (oldWidget.anchorAlignment != widget.anchorAlignment) {
      _anchorAlignment = widget.anchorAlignment;
    }
    if (oldWidget.widthConstraint != widget.widthConstraint) {
      _widthConstraint = widget.widthConstraint;
    }
    if (oldWidget.heightConstraint != widget.heightConstraint) {
      _heightConstraint = widget.heightConstraint;
    }
    if (oldWidget.offset != widget.offset) {
      _offset = widget.offset;
    }

    if (oldWidget.margin != widget.margin) {
      _margin = widget.margin;
    }
    bool shouldSyncSubscription = false;
    if (oldWidget.follow != widget.follow) {
      _follow = widget.follow;
      shouldSyncSubscription = true;
    }
    if (!identical(oldWidget.anchor, widget.anchor)) {
      _subscription.removeListener(_handleAnchorUpdate);
      _anchor = widget.anchor;
      _subscription = _anchor.subscribe();
      shouldSyncSubscription = true;
    }
    if (shouldSyncSubscription) {
      _syncSubscription();
    }
    if (oldWidget.allowInvertHorizontal != widget.allowInvertHorizontal) {
      _allowInvertHorizontal = widget.allowInvertHorizontal;
    }
    if (oldWidget.allowInvertVertical != widget.allowInvertVertical) {
      _allowInvertVertical = widget.allowInvertVertical;
    }
    if (oldWidget.position != widget.position && !_follow) {
      _position = widget.position;
    }
  }

  /// Gets the anchor widget's size.
  Size? get anchorSize => _anchorSize;

  /// Gets the anchor alignment for positioning.
  AlignmentGeometry get anchorAlignment => _anchorAlignment;

  /// Gets the explicit position offset.
  Offset? get position => _position;

  /// Gets the popover alignment.
  AlignmentGeometry get alignment => _alignment;

  /// Gets the width constraint strategy.
  PopoverConstraint get widthConstraint => _widthConstraint;

  /// Gets the height constraint strategy.
  PopoverConstraint get heightConstraint => _heightConstraint;

  /// Gets the position offset.
  Offset? get offset => _offset;

  /// Gets the margin around the popover.
  EdgeInsetsGeometry? get margin => _margin;

  /// Gets whether the popover follows the anchor on movement.
  bool get follow => _follow;

  /// Gets the anchor this popover is positioned/tracked against.
  Anchor get anchor => _anchor;

  /// Gets whether horizontal inversion is allowed.
  bool get allowInvertHorizontal => _allowInvertHorizontal;

  /// Gets whether vertical inversion is allowed.
  bool get allowInvertVertical => _allowInvertVertical;

  /// Sets the popover position.
  ///
  /// Updates the explicit position and triggers a rebuild.
  set position(Offset? value) {
    if (_position != value) {
      setState(() {
        _position = value;
      });
    }
  }

  @override
  void dispose() {
    _subscription.removeListener(_handleAnchorUpdate);
    super.dispose();
  }

  void _handleAnchorUpdate() {
    if (!mounted) return;
    if (!_subscription.isVisible) {
      widget.onClose?.call();
      return;
    }
    final renderObject = context.findRenderObject();
    if (renderObject == null) return;
    final transform = _subscription.computeTransform(renderObject);
    final newAnchorSize = _subscription.anchorSize;
    // Map the anchor-alignment point into the overlay's coordinate space,
    // not the anchor's top-left corner. This mirrors how the initial position
    // is computed in PopoverOverlayHandler.show (pos + anchorSize/2 * (1 +
    // anchorAlignment)), which is exactly the alignment point measured from
    // the anchor's local origin. Transforming Offset.zero instead would drop
    // the anchor-alignment offset and snap every overlay to the anchor corner.
    final localAnchorPoint = newAnchorSize != null
        ? _anchorAlignment.optionallyResolve(context).alongSize(newAnchorSize)
        : Offset.zero;
    final newPos = MatrixUtils.transformPoint(transform, localAnchorPoint);
    if (_position != newPos || _anchorSize != newAnchorSize) {
      setState(() {
        _anchorSize = newAnchorSize;
        _position = newPos;
        widget.onTickFollow?.call(this);
      });
    }
  }

  /// Whether this popover positions itself against the anchor's live position
  /// through the compositing pipeline (zero lag, margin/invert re-evaluated
  /// during scroll) instead of the per-frame ticker + re-layout path. Enabled
  /// for anchors that support it (e.g. [LinkedAnchor]) while following.
  bool get _useCompositeTracking =>
      _follow && _subscription.supportsCompositeTracking;

  void _handleAnchorLost() {
    if (!mounted) return;
    widget.onClose?.call();
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget = TapRegion(
      // enabled: widget.consumeOutsideTaps,
      onTapOutside: widget.onTapOutside != null
          ? (event) {
              widget.onTapOutside?.call();
            }
          : null,
      groupId: widget.regionGroupId,
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        removeTop: true,
        child: AnimatedBuilder(
          animation: widget.animation,
          builder: (context, child) {
            final theme = Theme.of(context);
            final scaling = theme.scaling;
            final densityGap = theme.density.baseGap * scaling;
            return PopoverLayout(
              alignment: _alignment.optionallyResolve(context),
              position: _position,
              anchorSize: _anchorSize,
              anchorAlignment: _anchorAlignment.optionallyResolve(context),
              widthConstraint: _widthConstraint,
              heightConstraint: _heightConstraint,
              offset: _offset,
              margin: _margin?.optionallyResolve(context) ??
                  EdgeInsets.all(densityGap),
              scale: tweenValue(0.9, 1.0, widget.animation.value),
              scaleAlignment: (widget.transitionAlignment ?? _alignment)
                  .optionallyResolve(context),
              allowInvertVertical: _allowInvertVertical,
              allowInvertHorizontal: _allowInvertHorizontal,
              liveAnchor:
                  _useCompositeTracking ? () => _subscription.currentAnchorBox : null,
              onAnchorLost: _useCompositeTracking ? _handleAnchorLost : null,
              child: child!,
            );
          },
          child: FadeTransition(
            opacity: widget.animation,
            child: Builder(builder: (context) {
              return widget.builder(context);
            }),
          ),
        ),
      ),
    );
    final completer = widget.completer;
    if (completer != null) {
      childWidget = Data<OverlayCompleter>.inherit(
        data: completer,
        child: childWidget,
      );
    }
    if (widget.themes != null) {
      childWidget = widget.themes!.wrap(childWidget);
    }
    if (widget.data != null) {
      childWidget = widget.data!.wrap(childWidget);
    }
    return childWidget;
  }
}

/// Implementation of [OverlayCompleter] for popover overlays.
///
/// Manages the lifecycle of a popover overlay entry, tracking completion
/// state and handling overlay/barrier entry disposal.
class OverlayPopoverEntry<T> extends OverlayCompleter<T> {
  OverlayEntry? _overlayEntry;
  OverlayEntry? _barrierEntry;

  /// The key used to look up this popover's live widget state, e.g. for
  /// [config]. Set by [PopoverOverlayHandler.show] before the popover is
  /// built.
  GlobalKey<PopoverOverlayWidgetState>? stateKey;

  /// Invoked by [close] (animated). Set by [PopoverOverlayHandler.show].
  Future<T?> Function()? onClose;

  /// Invoked by [closeLater]/immediate [close]. Set by
  /// [PopoverOverlayHandler.show].
  VoidCallback? onImmediateClose;

  /// Invoked by [closeWithResult]. Set by [PopoverOverlayHandler.show].
  Future<T?> Function(Object? value)? onCloseWithResult;

  @override
  OverlayConfiguration? get config => stateKey?.currentState?.config;

  @override
  set config(OverlayConfiguration? value) {
    stateKey?.currentState?.config = value;
  }

  @override
  Future<void> close([bool immediate = false]) {
    if (!immediate) {
      return onClose?.call() ?? Future.value();
    }
    onImmediateClose?.call();
    return Future.value();
  }

  @override
  void closeLater() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onClose?.call();
    });
  }

  @override
  Future<void> closeWithResult<X>([X? value]) {
    return onCloseWithResult?.call(value) ?? Future.value();
  }

  /// Completer for the popover's result value.
  final Completer<T?> completer = Completer();

  /// Completer that tracks the popover's animation lifecycle.
  ///
  /// Completes when the popover's entry and exit animations finish.
  /// Used internally to coordinate animation timing and cleanup.
  final Completer<T?> animationCompleter = Completer();

  bool _removed = false;
  bool _disposed = false;

  @override
  bool get isCompleted => completer.isCompleted;

  /// Initializes the popover entry with overlay entries.
  ///
  /// Must be called before the popover can be displayed.
  ///
  /// Parameters:
  /// - [overlayEntry] (OverlayEntry, required): Main overlay entry
  /// - [barrierEntry] (OverlayEntry?): Optional barrier entry
  void initialize(OverlayEntry overlayEntry, [OverlayEntry? barrierEntry]) {
    _overlayEntry = overlayEntry;
    _barrierEntry = barrierEntry;
  }

  @override
  void remove() {
    if (_removed) return;
    _removed = true;
    _overlayEntry?.remove();
    _barrierEntry?.remove();
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _overlayEntry?.dispose();
    _barrierEntry?.dispose();
  }

  @override
  Future<T?> get future => completer.future;

  @override
  Future<T?> get animationFuture => animationCompleter.future;

  @override
  bool get isAnimationCompleted => animationCompleter.isCompleted;
}

/// Custom layout widget for positioning popover content.
///
/// Handles popover positioning with alignment, sizing constraints, and
/// automatic inversion when content would overflow screen bounds.
class PopoverLayout extends SingleChildRenderObjectWidget {
  /// Popover alignment relative to anchor.
  final Alignment alignment;

  /// Anchor alignment for positioning.
  final Alignment anchorAlignment;

  /// Explicit position offset (overrides alignment).
  final Offset? position;

  /// Size of the anchor widget.
  final Size? anchorSize;

  /// Width constraint strategy.
  final PopoverConstraint widthConstraint;

  /// Height constraint strategy.
  final PopoverConstraint heightConstraint;

  /// Additional offset from computed position.
  final Offset? offset;

  /// Margin around the popover.
  final EdgeInsets margin;

  /// Scale factor for the popover.
  final double scale;

  /// Alignment point for scaling transformation.
  final Alignment scaleAlignment;

  /// Filter quality for scaled content.
  final FilterQuality? filterQuality;

  /// Whether to allow horizontal position inversion.
  final bool allowInvertHorizontal;

  /// Whether to allow vertical position inversion.
  final bool allowInvertVertical;

  /// Resolver for the anchor's live [RenderBox], enabling composite-time
  /// tracking. When non-null, the popover re-measures the anchor's position on
  /// every scene build and re-applies margin/invert live (see
  /// [PopoverLayoutRender]); when null it uses the static [position].
  final RenderBox? Function()? liveAnchor;

  /// Called (post-frame) when [liveAnchor] can no longer be resolved — i.e. the
  /// anchor was removed — so the popover can close.
  final VoidCallback? onAnchorLost;

  /// Creates a popover layout widget.
  const PopoverLayout({
    super.key,
    required this.alignment,
    required this.position,
    required this.anchorAlignment,
    required this.widthConstraint,
    required this.heightConstraint,
    this.anchorSize,
    this.offset,
    required this.margin,
    required Widget super.child,
    required this.scale,
    required this.scaleAlignment,
    this.filterQuality,
    this.allowInvertHorizontal = true,
    this.allowInvertVertical = true,
    this.liveAnchor,
    this.onAnchorLost,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return PopoverLayoutRender(
      alignment: alignment,
      position: position,
      anchorAlignment: anchorAlignment,
      widthConstraint: widthConstraint,
      heightConstraint: heightConstraint,
      anchorSize: anchorSize,
      offset: offset,
      margin: margin,
      scale: scale,
      scaleAlignment: scaleAlignment,
      filterQuality: filterQuality,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      liveAnchor: liveAnchor,
      onAnchorLost: onAnchorLost,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant PopoverLayoutRender renderObject) {
    bool hasChanged = false;
    if (renderObject._alignment != alignment) {
      renderObject._alignment = alignment;
      hasChanged = true;
    }
    if (renderObject._position != position) {
      renderObject._position = position;
      hasChanged = true;
    }
    if (renderObject._anchorAlignment != anchorAlignment) {
      renderObject._anchorAlignment = anchorAlignment;
      hasChanged = true;
    }
    if (renderObject._widthConstraint != widthConstraint) {
      renderObject._widthConstraint = widthConstraint;
      hasChanged = true;
    }
    if (renderObject._heightConstraint != heightConstraint) {
      renderObject._heightConstraint = heightConstraint;
      hasChanged = true;
    }
    if (renderObject._anchorSize != anchorSize) {
      renderObject._anchorSize = anchorSize;
      hasChanged = true;
    }
    if (renderObject._offset != offset) {
      renderObject._offset = offset;
      hasChanged = true;
    }
    if (renderObject._margin != margin) {
      renderObject._margin = margin;
      hasChanged = true;
    }
    if (renderObject._scale != scale) {
      renderObject._scale = scale;
      hasChanged = true;
    }
    if (renderObject._scaleAlignment != scaleAlignment) {
      renderObject._scaleAlignment = scaleAlignment;
      hasChanged = true;
    }
    if (renderObject._filterQuality != filterQuality) {
      renderObject._filterQuality = filterQuality;
      hasChanged = true;
    }
    if (renderObject._allowInvertHorizontal != allowInvertHorizontal) {
      renderObject._allowInvertHorizontal = allowInvertHorizontal;
      hasChanged = true;
    }
    if (renderObject._allowInvertVertical != allowInvertVertical) {
      renderObject._allowInvertVertical = allowInvertVertical;
      hasChanged = true;
    }
    renderObject.liveAnchor = liveAnchor;
    renderObject.onAnchorLost = onAnchorLost;
    if (hasChanged) {
      renderObject.markNeedsLayout();
    }
  }
}

/// Custom render object for popover layout positioning.
///
/// Handles the low-level layout calculations for positioning popover content
/// relative to an anchor with automatic constraint adjustments and inversion
/// when the popover would overflow the viewport.
class PopoverLayoutRender extends RenderShiftedBox {
  Alignment _alignment;
  Alignment _anchorAlignment;
  Offset? _position;
  Size? _anchorSize;
  PopoverConstraint _widthConstraint;
  PopoverConstraint _heightConstraint;
  Offset? _offset;
  EdgeInsets _margin;
  double _scale;
  Alignment _scaleAlignment;
  FilterQuality? _filterQuality;
  bool _allowInvertHorizontal;
  bool _allowInvertVertical;
  RenderBox? Function()? _liveAnchor;
  VoidCallback? _onAnchorLost;

  bool _invertX = false;
  bool _invertY = false;

  // Live-tracking state, updated at composite time (see [_composeLiveTransform]).
  Offset? _liveOffset;
  bool _liveInvertX = false;
  bool _liveInvertY = false;
  bool _anchorLostScheduled = false;
  final LayerHandle<_PopoverTrackingLayer> _trackingLayer =
      LayerHandle<_PopoverTrackingLayer>();

  /// Whether composite-time anchor tracking is active.
  bool get _isLiveTracking => _liveAnchor != null;

  set liveAnchor(RenderBox? Function()? value) {
    final bool wasTracking = _liveAnchor != null;
    _liveAnchor = value;
    if (wasTracking != (value != null)) {
      // Toggling tracking changes the paint/compositing path.
      markNeedsCompositingBitsUpdate();
      markNeedsPaint();
    }
  }

  set onAnchorLost(VoidCallback? value) => _onAnchorLost = value;

  /// Creates a popover layout render object.
  ///
  /// All parameters control how the popover is positioned and sized relative
  /// to its anchor.
  PopoverLayoutRender({
    RenderBox? child,
    required Alignment alignment,
    required Offset? position,
    required Alignment anchorAlignment,
    required PopoverConstraint widthConstraint,
    required PopoverConstraint heightConstraint,
    Size? anchorSize,
    Offset? offset,
    EdgeInsets margin = const EdgeInsets.all(8),
    required double scale,
    required Alignment scaleAlignment,
    FilterQuality? filterQuality,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    RenderBox? Function()? liveAnchor,
    VoidCallback? onAnchorLost,
  })  : _alignment = alignment,
        _position = position,
        _anchorAlignment = anchorAlignment,
        _widthConstraint = widthConstraint,
        _heightConstraint = heightConstraint,
        _anchorSize = anchorSize,
        _offset = offset,
        _liveAnchor = liveAnchor,
        _onAnchorLost = onAnchorLost,
        _margin = margin,
        _scale = scale,
        _scaleAlignment = scaleAlignment,
        _filterQuality = filterQuality,
        _allowInvertHorizontal = allowInvertHorizontal,
        _allowInvertVertical = allowInvertVertical,
        super(child);

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return hitTestChildren(result, position: position);
  }

  /// Builds the paint transform that moves the child from where it was laid out
  /// ([paintedOffset], i.e. its parent-data offset) to [targetOffset] and scales
  /// it around [targetOffset] plus the (invert-adjusted) scale alignment point.
  ///
  /// For the static path both offsets are equal, so it reduces to the plain
  /// scale-in-place transform. For live tracking [targetOffset] is the popover's
  /// freshly-computed placement for the anchor's current position.
  Matrix4 _buildTransform(
      Offset paintedOffset, Offset targetOffset, bool invertX, bool invertY) {
    Size childSize = child!.size;
    var scaleAlignment = _scaleAlignment;
    if (invertX || invertY) {
      scaleAlignment = Alignment(
        invertX ? -scaleAlignment.x : scaleAlignment.x,
        invertY ? -scaleAlignment.y : scaleAlignment.y,
      );
    }
    final Offset delta = targetOffset - paintedOffset;
    Matrix4 transform = Matrix4.identity();
    Offset alignmentTranslation = scaleAlignment.alongSize(childSize);
    transform.translateByDouble(targetOffset.dx, targetOffset.dy, 0, 1);
    transform.translateByDouble(
        alignmentTranslation.dx, alignmentTranslation.dy, 0, 1);
    transform.scaleByDouble(_scale, _scale, 1, 1);
    transform.translateByDouble(
        -alignmentTranslation.dx, -alignmentTranslation.dy, 0, 1);
    transform.translateByDouble(-targetOffset.dx, -targetOffset.dy, 0, 1);
    // Innermost: shift the child from its laid-out spot to the live target.
    transform.translateByDouble(delta.dx, delta.dy, 0, 1);
    return transform;
  }

  Matrix4 get _effectiveTransform {
    final Offset baseOffset = (child!.parentData as BoxParentData).offset;
    if (_isLiveTracking) {
      // Use the placement computed on the last scene build so hit-testing and
      // ancestor transforms follow where the popover is actually drawn.
      return _buildTransform(
          baseOffset, _liveOffset ?? baseOffset, _liveInvertX, _liveInvertY);
    }
    return _buildTransform(baseOffset, baseOffset, _invertX, _invertY);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return result.addWithPaintTransform(
      transform: _effectiveTransform,
      position: position,
      hitTest: (BoxHitTestResult result, Offset position) {
        return super.hitTestChildren(result, position: position);
      },
    );
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    Matrix4 effectiveTransform = _effectiveTransform;
    transform.multiply(effectiveTransform);
    super.applyPaintTransform(child, transform);
  }

  @override
  bool get alwaysNeedsCompositing =>
      child != null && (_filterQuality != null || _isLiveTracking);

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    if (_isLiveTracking && _filterQuality == null) {
      // Live tracking: push a layer that re-evaluates the popover's placement
      // against the anchor's live position on every scene build (including page
      // scrolls that never repaint this subtree). The child is painted at its
      // laid-out offset; the layer's transform moves/scales it to the live spot.
      // Drop any transform layer cached by the static paint path.
      layer = null;
      var trackingLayer = _trackingLayer.layer;
      if (trackingLayer == null) {
        trackingLayer = _PopoverTrackingLayer(this);
        _trackingLayer.layer = trackingLayer;
      } else {
        trackingLayer.render = this;
        trackingLayer.remove();
      }
      trackingLayer.paintOffset = offset;
      context.pushLayer(trackingLayer, super.paint, offset);
      return;
    }
    if (child != null) {
      final Matrix4 transform = _effectiveTransform;
      if (_filterQuality == null) {
        final Offset? childOffset = MatrixUtils.getAsTranslation(transform);
        if (childOffset == null) {
          final double det = transform.determinant();
          if (det == 0 || !det.isFinite) {
            layer = null;
            return;
          }
          layer = context.pushTransform(
            needsCompositing,
            offset,
            transform,
            super.paint,
            oldLayer: layer is TransformLayer ? layer as TransformLayer? : null,
          );
        } else {
          super.paint(context, offset + childOffset);
          layer = null;
        }
      } else {
        final Matrix4 effectiveTransform =
            Matrix4.translationValues(offset.dx, offset.dy, 0.0)
              ..multiply(transform)
              ..translateByDouble(-offset.dx, -offset.dy, 0, 1);
        final ui.ImageFilter filter = ui.ImageFilter.matrix(
          effectiveTransform.storage,
          filterQuality: _filterQuality!,
        );
        if (layer is ImageFilterLayer) {
          final ImageFilterLayer filterLayer = layer! as ImageFilterLayer;
          filterLayer.imageFilter = filter;
        } else {
          layer = ImageFilterLayer(imageFilter: filter);
        }
        context.pushLayer(layer!, super.paint, offset);
        assert(() {
          layer!.debugCreator = debugCreator;
          return true;
        }());
      }
    }
  }

  /// Computes appropriate box constraints for the popover child.
  ///
  /// Applies width and height constraint strategies to the child based on
  /// anchor size, viewport constraints, and margin settings.
  ///
  /// Parameters:
  /// - [constraints]: The incoming constraints from parent
  ///
  /// Returns box constraints with min/max values for width and height.
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double minWidth = 0;
    final double availableMaxWidth =
        max(0.0, constraints.maxWidth - _margin.horizontal);
    double maxWidth = availableMaxWidth;
    double minHeight = 0;
    final double availableMaxHeight =
        max(0.0, constraints.maxHeight - _margin.vertical);
    double maxHeight = availableMaxHeight;
    if (_widthConstraint == PopoverConstraint.anchorFixedSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      minWidth = _anchorSize!.width;
      maxWidth = _anchorSize!.width;
    } else if (_widthConstraint == PopoverConstraint.anchorMinSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      minWidth = _anchorSize!.width;
    } else if (_widthConstraint == PopoverConstraint.anchorMaxSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      maxWidth = _anchorSize!.width;
    } else if (_widthConstraint == PopoverConstraint.intrinsic) {
      double intrinsicWidth = child!.getMaxIntrinsicWidth(double.infinity);
      if (intrinsicWidth.isFinite) {
        maxWidth = min(max(minWidth, intrinsicWidth), availableMaxWidth);
      }
    }
    if (_heightConstraint == PopoverConstraint.anchorFixedSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      minHeight = _anchorSize!.height;
      maxHeight = _anchorSize!.height;
    } else if (_heightConstraint == PopoverConstraint.anchorMinSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      minHeight = _anchorSize!.height;
    } else if (_heightConstraint == PopoverConstraint.anchorMaxSize) {
      assert(_anchorSize != null, 'anchorSize must not be null');
      maxHeight = _anchorSize!.height;
    } else if (_heightConstraint == PopoverConstraint.intrinsic) {
      double intrinsicHeight = child!.getMaxIntrinsicHeight(double.infinity);
      if (intrinsicHeight.isFinite) {
        maxHeight = min(max(minHeight, intrinsicHeight), availableMaxHeight);
      }
    }
    return BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }

  /// Pure placement computation: given an anchor point [position] (in this
  /// render object's coordinate space), the laid-out [childSize], and the
  /// [anchorSize], returns the child's offset plus whether it was inverted on
  /// each axis. Applies alignment, the offset, auto-invert (only when it reduces
  /// off-screen overflow), and edge clamping against [size].
  ///
  /// Extracted so it can be evaluated both at layout time (against the static
  /// [_position]) and at composite time (against the anchor's live position),
  /// keeping the two perfectly consistent.
  ({Offset offset, bool invertX, bool invertY}) _computePlacement(
      Offset? position, Size childSize, Size? anchorSize) {
    double offsetX = _offset?.dx ?? 0;
    double offsetY = _offset?.dy ?? 0;
    position ??= Offset(
      size.width / 2 + size.width / 2 * _anchorAlignment.x,
      size.height / 2 + size.height / 2 * _anchorAlignment.y,
    );
    double x = position.dx -
        childSize.width / 2 -
        (childSize.width / 2 * _alignment.x);
    double y = position.dy -
        childSize.height / 2 -
        (childSize.height / 2 * _alignment.y);
    double left = x - _margin.left;
    double top = y - _margin.top;
    double right = x + childSize.width + _margin.right;
    double bottom = y + childSize.height + _margin.bottom;
    bool invertX = false;
    bool invertY = false;
    if ((left < 0 || right > size.width) && _allowInvertHorizontal) {
      double invertedX = position.dx -
          childSize.width / 2 -
          (childSize.width / 2 * -_alignment.x);
      if (anchorSize != null) {
        invertedX -= anchorSize.width * _anchorAlignment.x;
      }
      final double invertedLeft = invertedX - _margin.left;
      final double invertedRight = invertedX + childSize.width + _margin.right;
      // Only flip to the opposite side when doing so actually reduces how far
      // the popover spills off-screen. Inverting a popover that overflows on
      // either side would fling it across the screen (e.g. snapping to the top
      // edge) once it merely touched the margin — a gentle clamp on the
      // original side keeps it anchored instead.
      final double originalOverflow =
          max(0.0, -left) + max(0.0, right - size.width);
      final double invertedOverflow =
          max(0.0, -invertedLeft) + max(0.0, invertedRight - size.width);
      if (invertedOverflow < originalOverflow) {
        x = invertedX;
        left = invertedLeft;
        right = invertedRight;
        offsetX *= -1;
        invertX = true;
      }
    }
    if ((top < 0 || bottom > size.height) && _allowInvertVertical) {
      double invertedY = position.dy -
          childSize.height / 2 -
          (childSize.height / 2 * -_alignment.y);
      if (anchorSize != null) {
        invertedY -= anchorSize.height * _anchorAlignment.y;
      }
      final double invertedTop = invertedY - _margin.top;
      final double invertedBottom =
          invertedY + childSize.height + _margin.bottom;
      final double originalOverflow =
          max(0.0, -top) + max(0.0, bottom - size.height);
      final double invertedOverflow =
          max(0.0, -invertedTop) + max(0.0, invertedBottom - size.height);
      if (invertedOverflow < originalOverflow) {
        y = invertedY;
        top = invertedTop;
        bottom = invertedBottom;
        offsetY *= -1;
        invertY = true;
      }
    }
    final double dx = left < 0
        ? -left
        : right > size.width
            ? size.width - right
            : 0;
    final double dy = top < 0
        ? -top
        : bottom > size.height
            ? size.height - bottom
            : 0;
    return (
      offset: Offset(x + dx + offsetX, y + dy + offsetY),
      invertX: invertX,
      invertY: invertY,
    );
  }

  @override
  void performLayout() {
    // The live anchor's size can't be read here (it's not our child; reading it
    // mid-layout is illegal). It's only needed at composite time, where
    // [_composeLiveTransform] reads it safely. Layout uses the anchor size the
    // state supplied at open, which is stable during scroll.
    child!.layout(getConstraintsForChild(constraints), parentUsesSize: true);
    size = constraints.biggest;
    final placement = _computePlacement(_position, child!.size, _anchorSize);
    _invertX = placement.invertX;
    _invertY = placement.invertY;
    (child!.parentData as BoxParentData).offset = placement.offset;
  }

  /// Computes the paint transform for the current scene build while live
  /// tracking: measures the anchor's live position (valid at composite time,
  /// reflecting this frame's scroll), recomputes the full placement (margin +
  /// invert) against it, and returns the transform moving the laid-out child
  /// there. Schedules a relayout on anchor resize and a close on anchor removal
  /// — only *schedules*, since it runs during compositing.
  Matrix4 _composeLiveTransform() {
    final Offset baseOffset = (child!.parentData as BoxParentData).offset;
    final box = _liveAnchor?.call();
    if (box == null || !box.attached || !box.hasSize) {
      _liveOffset = null;
      _scheduleAnchorLost();
      return _buildTransform(baseOffset, baseOffset, _invertX, _invertY);
    }
    // Safe to read the anchor's size/transform here: layout is complete during
    // compositing, and this reflects the current frame's scroll offset.
    final Size anchorSize = box.size;
    final Offset anchorPoint = _anchorAlignment.alongSize(anchorSize);
    final Offset live =
        MatrixUtils.transformPoint(box.getTransformTo(this), anchorPoint);
    final placement = _computePlacement(live, child!.size, anchorSize);
    _liveOffset = placement.offset;
    _liveInvertX = placement.invertX;
    _liveInvertY = placement.invertY;
    return _buildTransform(
        baseOffset, placement.offset, placement.invertX, placement.invertY);
  }

  void _scheduleAnchorLost() {
    if (_anchorLostScheduled) return;
    _anchorLostScheduled = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _anchorLostScheduled = false;
      _onAnchorLost?.call();
    });
  }

  @override
  void dispose() {
    _trackingLayer.layer = null;
    super.dispose();
  }
}

/// Compositing layer for a live-tracking [PopoverLayoutRender]. Its
/// [alwaysNeedsAddToScene] guarantees [addToScene] runs on every scene build —
/// including page scrolls that never repaint the popover's subtree — where it
/// asks the render object to recompute the popover's placement against the
/// anchor's current position and pushes the resulting transform. The child is
/// painted (once, at its laid-out offset) into this layer; only the transform
/// changes per frame, so following costs nothing when the anchor is still.
class _PopoverTrackingLayer extends ContainerLayer {
  _PopoverTrackingLayer(this.render);

  PopoverLayoutRender render;
  Offset paintOffset = Offset.zero;

  @override
  bool get alwaysNeedsAddToScene => true;

  @override
  void addToScene(ui.SceneBuilder builder) {
    final Matrix4 transform = render._composeLiveTransform();
    // Mirror PaintingContext.pushTransform: apply the transform about the
    // offset the child was painted at.
    final Matrix4 effective =
        Matrix4.translationValues(paintOffset.dx, paintOffset.dy, 0)
          ..multiply(transform)
          ..translateByDouble(-paintOffset.dx, -paintOffset.dy, 0, 1);
    engineLayer = builder.pushTransform(
      effective.storage,
      oldLayer: engineLayer as ui.TransformEngineLayer?,
    );
    addChildrenToScene(builder);
    builder.pop();
  }
}
