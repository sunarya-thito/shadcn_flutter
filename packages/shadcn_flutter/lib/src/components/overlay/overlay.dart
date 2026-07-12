import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

/// Closes the currently active overlay with an optional result value.
///
/// Searches up the widget tree for the [OverlayCompleter] of the overlay
/// [context] is inside of (inherited by the overlay's own content) and
/// requests it to close with the provided result. If none is found, returns
/// a completed future.
///
/// Parameters:
/// - [context] (BuildContext, required): Build context from within the overlay
/// - [value] (T?): Optional result value to return when closing
///
/// Returns a [Future] that completes when the overlay is closed.
///
/// Example:
/// ```dart
/// closeOverlay(context, 'user_confirmed');
/// ```
Future<void> closeOverlay<T>(BuildContext context, [T? value]) {
  return Data.maybeFind<OverlayCompleter>(context)?.closeWithResult(value) ??
      Future.value();
}

/// Abstract interface for overlay operation completion tracking.
///
/// Provides lifecycle management and status tracking for overlay operations,
/// including completion state, animation state, dismissal, and (for
/// mechanisms that support it) live in-place configuration updates.
abstract class OverlayCompleter<T> {
  /// Removes the overlay from the screen.
  void remove();

  /// Disposes resources associated with the overlay.
  void dispose();

  /// Whether the overlay operation has completed.
  bool get isCompleted;

  /// Whether the overlay's animation has completed.
  bool get isAnimationCompleted;

  /// Future that completes with the overlay's result value.
  Future<T?> get future;

  /// Future that completes when the overlay animation finishes.
  Future<void> get animationFuture;

  /// Closes the overlay.
  ///
  /// Parameters:
  /// - [immediate] (bool): If true, closes immediately without animation.
  ///
  /// Returns a [Future] that completes when closed. Defaults to [remove].
  Future<void> close([bool immediate = false]) async => remove();

  /// Schedules overlay closure for the next frame.
  ///
  /// Useful for closing overlays from callbacks where immediate closure
  /// might cause issues with the widget tree. Defaults to [remove].
  void closeLater() => remove();

  /// Closes the overlay with a result value.
  ///
  /// Parameters:
  /// - [value] (X?): Optional result to return.
  ///
  /// Returns a [Future] that completes when closed. Defaults to [remove].
  Future<void> closeWithResult<X>([X? value]) async => remove();

  /// The configuration currently applied to this overlay, if this mechanism
  /// tracks one.
  OverlayConfiguration? get config => null;

  /// Updates alignment, margin, follow, or other settings on the open
  /// overlay without closing and reopening it. Drawer, sheet, and dialog
  /// don't support live updates and can leave this unimplemented;
  /// [OverlayController] closes and reopens the overlay for those instead.
  set config(OverlayConfiguration? value) {}
}

/// Abstract handler for managing overlay presentation and lifecycle.
///
/// Provides common interface for different overlay types (popover, sheet, dialog)
/// with customizable display, positioning, and interaction behavior.
abstract class OverlayHandler {
  /// Default popover overlay handler.
  static const OverlayHandler popover = PopoverOverlayHandler();

  /// Default sheet overlay handler.
  static const OverlayHandler sheet = SheetOverlayHandler();

  /// Default dialog overlay handler.
  static const OverlayHandler dialog = DialogOverlayHandler();

  /// Creates an [OverlayHandler].
  const OverlayHandler();

  /// Shows an overlay with the specified configuration.
  ///
  /// Displays an overlay (popover, sheet, or dialog) with extensive customization
  /// options for positioning, sizing, behavior, and appearance.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  /// - [alignment] (AlignmentGeometry, required): Overlay alignment
  /// - [builder] (WidgetBuilder, required): Overlay content builder
  /// - [position] (Offset?): Explicit position (overrides alignment)
  /// - [anchorAlignment] (AlignmentGeometry?): Anchor alignment
  /// - [widthConstraint] (PopoverConstraint): Width constraint, defaults to flexible
  /// - [heightConstraint] (PopoverConstraint): Height constraint, defaults to flexible
  /// - [key] (Key?): Widget key
  /// - [rootOverlay] (bool): Use root overlay, defaults to true
  /// - [modal] (bool): Modal behavior, defaults to true
  /// - [barrierDismissable] (bool): Dismissible by tapping barrier, defaults to true
  /// - [clipBehavior] (Clip): Clipping behavior, defaults to none
  /// - [regionGroupId] (Object?): Region group ID
  /// - [offset] (Offset?): Position offset
  /// - [transitionAlignment] (AlignmentGeometry?): Transition alignment
  /// - [margin] (EdgeInsetsGeometry?): Overlay margin
  /// - [follow] (bool): Follow anchor on move, defaults to true
  /// - [consumeOutsideTaps] (bool): Consume outside taps, defaults to true
  /// - [onTickFollow] (`ValueChanged<PopoverOverlayWidgetState>?`): Follow tick callback
  /// - [allowInvertHorizontal] (bool): Allow horizontal inversion, defaults to true
  /// - [allowInvertVertical] (bool): Allow vertical inversion, defaults to true
  /// - [dismissBackdropFocus] (bool): Dismiss on backdrop focus, defaults to true
  /// - [showDuration] (Duration?): Show animation duration
  /// - [dismissDuration] (Duration?): Dismiss animation duration
  /// - [overlayBarrier] (OverlayBarrier?): Custom barrier configuration
  /// - [anchor] (Anchor?): Anchor to position/track against, defaults to a
  ///   [ContextAnchor] wrapping [context]
  ///
  /// Returns an [OverlayCompleter] for managing the overlay lifecycle.
  OverlayCompleter<T?> show<T>({
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
    Anchor? anchor,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  });
}

/// Configuration for overlay modal barriers.
///
/// Defines the visual appearance and spacing of the barrier displayed
/// behind modal overlays.
class OverlayBarrier {
  /// Padding around the barrier.
  final EdgeInsetsGeometry padding;

  /// Border radius for the barrier shape.
  final BorderRadiusGeometry borderRadius;

  /// Color of the barrier (typically semi-transparent).
  final Color? barrierColor;

  /// Creates an overlay barrier configuration.
  ///
  /// Parameters:
  /// - [padding] (EdgeInsetsGeometry): Barrier padding, defaults to zero
  /// - [borderRadius] (BorderRadiusGeometry): Border radius, defaults to zero
  /// - [barrierColor] (Color?): Barrier color
  const OverlayBarrier({
    this.padding = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
    this.barrierColor,
  });
}

/// Abstract manager for overlay operations.
///
/// Extends [OverlayHandler] with additional methods for showing specialized
/// overlay types like tooltips and menus. Provides centralized overlay
/// management for an application.
abstract class OverlayManager implements OverlayHandler {
  /// Gets the overlay manager from the widget tree.
  ///
  /// Searches for an [OverlayManager] in the build context and throws
  /// an assertion error if not found.
  ///
  /// Parameters:
  /// - [context] (BuildContext, required): Build context
  ///
  /// Returns the [OverlayManager] instance.
  static OverlayManager of(BuildContext context) {
    var manager = Data.maybeOf<OverlayManager>(context);
    assert(manager != null, 'No OverlayManager found in context');
    return manager!;
  }

  @override
  OverlayCompleter<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
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
    Anchor? anchor,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  });

  /// Shows a tooltip overlay.
  ///
  /// Specialized method for displaying tooltips with appropriate defaults
  /// for tooltip behavior (non-modal, brief display, etc.).
  ///
  /// Parameters similar to [show] method. See [show] for full parameter documentation.
  ///
  /// Returns an [OverlayCompleter] for managing the tooltip lifecycle.
  OverlayCompleter<T?> showTooltip<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
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
    Anchor? anchor,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  });

  /// Shows a menu overlay.
  ///
  /// Specialized method for displaying menus with appropriate defaults
  /// for menu behavior (dismissible, follows anchor, etc.).
  ///
  /// Parameters similar to [show] method. See [show] for full parameter documentation.
  ///
  /// Returns an [OverlayCompleter] for managing the menu lifecycle.
  OverlayCompleter<T?> showMenu<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
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
    Anchor? anchor,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  });
}

/// Layer widget managing different overlay handlers for the application.
///
/// Provides centralized overlay management for popovers, tooltips, and menus
/// with customizable handlers for each type.
class OverlayManagerLayer extends StatefulWidget {
  /// Handler for popover overlays.
  final OverlayHandler popoverHandler;

  /// Handler for tooltip overlays.
  final OverlayHandler tooltipHandler;

  /// Handler for menu overlays.
  final OverlayHandler menuHandler;

  /// Child widget wrapped by overlay management.
  final Widget child;

  /// Creates an overlay manager layer.
  ///
  /// Parameters:
  /// - [popoverHandler] (OverlayHandler, required): Handler for popover overlays
  /// - [tooltipHandler] (OverlayHandler, required): Handler for tooltip overlays
  /// - [menuHandler] (OverlayHandler, required): Handler for menu overlays
  /// - [child] (Widget, required): Child widget
  const OverlayManagerLayer({
    super.key,
    required this.popoverHandler,
    required this.tooltipHandler,
    required this.menuHandler,
    required this.child,
  });

  @override
  State<OverlayManagerLayer> createState() => _OverlayManagerLayerState();
}

class _OverlayManagerLayerState extends State<OverlayManagerLayer>
    implements OverlayManager {
  @override
  Widget build(BuildContext context) {
    return Data<OverlayManager>.inherit(
      data: this,
      child: widget.child,
    );
  }

  @override
  OverlayCompleter<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
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
    Anchor? anchor,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  }) {
    return widget.popoverHandler.show(
      context: context,
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
      anchor: anchor,
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
  OverlayCompleter<T?> showTooltip<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
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
    Anchor? anchor,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  }) {
    return widget.tooltipHandler.show(
      context: context,
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
      anchor: anchor,
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
  OverlayCompleter<T?> showMenu<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AlignmentGeometry alignment = Alignment.center,
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
    Anchor? anchor,
    ValueChanged<PopoverOverlayWidgetState>? onTickFollow,
    bool allowInvertHorizontal = true,
    bool allowInvertVertical = true,
    bool dismissBackdropFocus = true,
    Duration? showDuration,
    Duration? dismissDuration,
    OverlayBarrier? overlayBarrier,
  }) {
    return widget.menuHandler.show(
      context: context,
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
      anchor: anchor,
      onTickFollow: onTickFollow,
      allowInvertHorizontal: allowInvertHorizontal,
      allowInvertVertical: allowInvertVertical,
      dismissBackdropFocus: dismissBackdropFocus,
      showDuration: showDuration,
      dismissDuration: dismissDuration,
      overlayBarrier: overlayBarrier,
    );
  }
}

/// A [ChangeNotifier] with a public [notify] method, since [notifyListeners]
/// itself is `@protected` and can't be called from an object holding a
/// [ChangeNotifier] as a field rather than extending it.
class _AnchorRepaintNotifier extends ChangeNotifier {
  void notify() => notifyListeners();
}

/// The registry entry representing a registered [OverlayAnchor].
class OverlayAnchorEntry {
  /// The [RenderBox] of the registered anchor.
  final RenderBox renderBox;

  /// The [BuildContext] (Element) of the registered anchor.
  final BuildContext context;

  /// Creates an [OverlayAnchorEntry].
  const OverlayAnchorEntry({
    required this.renderBox,
    required this.context,
  });
}

/// Global registry for all [OverlayAnchor] widgets.
class OverlayAnchorRegistry {
  static final Map<Object, OverlayAnchorEntry> _anchors = {};

  /// Registers an [OverlayAnchorEntry] with the given key.
  static void register(Object key, OverlayAnchorEntry entry) {
    _anchors[key] = entry;
  }

  /// Unregisters the entry for the given key.
  static void unregister(Object key) {
    _anchors.remove(key);
  }

  /// Finds the registered entry for the given key.
  static OverlayAnchorEntry? find(Object key) {
    return _anchors[key];
  }
}

/// A widget that acts as a generalized anchor for overlays.
///
/// It registers its [RenderBox] and [BuildContext] dynamically in the global
/// [OverlayAnchorRegistry] using an arbitrary key (see [LinkedAnchor]).
class OverlayAnchor extends SingleChildRenderObjectWidget {
  /// The unique key representing this anchor.
  final Object anchor;

  /// Creates an [OverlayAnchor].
  const OverlayAnchor({
    super.key,
    required this.anchor,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderOverlayAnchor(
      anchor: anchor,
      anchorContext: context,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderOverlayAnchor renderObject) {
    renderObject.update(
      anchor: anchor,
      anchorContext: context,
    );
  }
}

/// The render object for [OverlayAnchor].
///
/// Handles construction, updates, and automatic unregistration when detached.
/// Implements [Listenable] directly (backed by a private [ChangeNotifier])
/// so [LinkedAnchor] subscriptions can listen for repaints without an extra
/// indirection; notified whenever this render object repaints (see
/// [markNeedsPaint]) or is removed from the tree (see [detach]).
class RenderOverlayAnchor extends RenderProxyBox implements Listenable {
  Object _anchor;
  BuildContext _anchorContext;
  final _AnchorRepaintNotifier _notifier = _AnchorRepaintNotifier();
  bool _notifierDisposed = false;

  /// Creates a [RenderOverlayAnchor].
  RenderOverlayAnchor({
    required Object anchor,
    required BuildContext anchorContext,
    RenderBox? child,
  })  : _anchor = anchor,
        _anchorContext = anchorContext,
        super(child);

  @override
  void addListener(VoidCallback listener) => _notifier.addListener(listener);

  @override
  void removeListener(VoidCallback listener) =>
      _notifier.removeListener(listener);

  @override
  void markNeedsPaint() {
    super.markNeedsPaint();
    if (!_notifierDisposed) _notifier.notify();
  }

  /// Updates properties and registry.
  void update({
    required Object anchor,
    required BuildContext anchorContext,
  }) {
    if (_anchor != anchor) {
      OverlayAnchorRegistry.unregister(_anchor);
      _anchor = anchor;
    }
    _anchorContext = anchorContext;
    if (attached) {
      _register();
    }
  }

  void _register() {
    OverlayAnchorRegistry.register(
      _anchor,
      OverlayAnchorEntry(
        renderBox: this,
        context: _anchorContext,
      ),
    );
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _register();
  }

  @override
  void detach() {
    OverlayAnchorRegistry.unregister(_anchor);
    // Deferred past this frame's build/layout/paint: detach() runs during
    // tree teardown, and a listener reacting synchronously would trip
    // Flutter's "build scheduled during build" assertion. dispose() runs
    // synchronously right after detach(), so _notifier is disposed here
    // (once the detach is confirmed permanent) instead of in dispose().
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _notifier.notify();
      if (!attached) {
        _notifierDisposed = true;
        _notifier.dispose();
      }
    });
    super.detach();
  }
}
