import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter/rendering.dart';

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

/// A registry mapping anchor keys to their [OverlayAnchor] entries.
///
/// By default anchors register with the process-wide [global] registry, so keys
/// must be globally unique. Wrap a subtree in an [OverlayAnchorScope] to give it
/// its own registry — then keys only need to be unique within that scope, and
/// the same key can be reused in sibling scopes (e.g. one per list item, tab, or
/// route). [OverlayAnchor] and [LinkedAnchor] both resolve their registry from
/// the nearest scope via [of].
class OverlayAnchorRegistry {
  /// The process-wide fallback registry, used when there's no enclosing
  /// [OverlayAnchorScope]. Has no [parent].
  static final OverlayAnchorRegistry global = OverlayAnchorRegistry();

  /// The enclosing scope's registry. [find] falls back to it (and so on up to
  /// [global]) when a key isn't registered in this scope, so an inner scope can
  /// resolve anchors declared by an outer one. Null for [global]. Set by the
  /// owning [OverlayAnchorScope]; registrations always stay local.
  OverlayAnchorRegistry? parent;

  /// Creates an [OverlayAnchorRegistry], optionally chained to a [parent].
  OverlayAnchorRegistry({this.parent});

  final Map<Object, OverlayAnchorEntry> _anchors = {};

  /// The registry for [context]'s nearest [OverlayAnchorScope], or [global] if
  /// there is none. Does not create an inherited-widget dependency, so it is
  /// safe to call outside of build (e.g. while showing an overlay).
  static OverlayAnchorRegistry of(BuildContext context) =>
      Data.maybeFind<OverlayAnchorRegistry>(context) ?? global;

  /// Registers an [OverlayAnchorEntry] with the given key in this registry.
  void register(Object key, OverlayAnchorEntry entry) {
    _anchors[key] = entry;
  }

  /// Unregisters the entry for the given key from this registry.
  void unregister(Object key) {
    _anchors.remove(key);
  }

  /// Finds the entry for [key], falling back to [parent] (and up the chain to
  /// [global]) when it isn't registered in this scope.
  OverlayAnchorEntry? find(Object key) {
    return _anchors[key] ?? parent?.find(key);
  }
}

/// Provides a local [OverlayAnchorRegistry] to its subtree, so [OverlayAnchor]
/// keys only need to be unique within this scope rather than globally.
///
/// Place a scope around each repeated region (list item, tab, dialog, route)
/// that reuses the same anchor keys. Both the [OverlayAnchor] and the code that
/// opens a [LinkedAnchor]-based overlay must sit under the same scope for them
/// to connect.
class OverlayAnchorScope extends StatefulWidget {
  /// The subtree that shares this scope's registry.
  final Widget child;

  /// Creates an [OverlayAnchorScope].
  const OverlayAnchorScope({super.key, required this.child});

  @override
  State<OverlayAnchorScope> createState() => _OverlayAnchorScopeState();
}

class _OverlayAnchorScopeState extends State<OverlayAnchorScope> {
  final OverlayAnchorRegistry _registry = OverlayAnchorRegistry();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Chain to the enclosing scope (or the global registry) so a lookup that
    // misses here falls back outward. maybeOf establishes a dependency, so this
    // re-resolves if an ancestor scope is inserted/removed.
    _registry.parent = Data.maybeOf<OverlayAnchorRegistry>(context) ??
        OverlayAnchorRegistry.global;
  }

  @override
  Widget build(BuildContext context) {
    return Data<OverlayAnchorRegistry>.inherit(
      data: _registry,
      child: widget.child,
    );
  }
}

/// A widget that acts as a generalized anchor for overlays.
///
/// It registers its [RenderBox] and [BuildContext] dynamically in the nearest
/// [OverlayAnchorRegistry] (see [OverlayAnchorScope]) using an arbitrary key
/// (see [LinkedAnchor]).
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
      registry: OverlayAnchorRegistry.of(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderOverlayAnchor renderObject) {
    renderObject.update(
      anchor: anchor,
      anchorContext: context,
      registry: OverlayAnchorRegistry.of(context),
    );
  }
}

/// The render object for [OverlayAnchor].
///
/// Handles construction, updates, and automatic unregistration when detached.
/// Overlays anchored to it read its live on-screen position directly through
/// [RenderObject.getTransformTo] during compositing — see the movement detector
/// in `anchor.dart` — so it needs no special layer of its own.
class RenderOverlayAnchor extends RenderProxyBox {
  Object _anchor;
  BuildContext _anchorContext;
  OverlayAnchorRegistry _registry;

  /// Creates a [RenderOverlayAnchor].
  RenderOverlayAnchor({
    required Object anchor,
    required BuildContext anchorContext,
    required OverlayAnchorRegistry registry,
    RenderBox? child,
  })  : _anchor = anchor,
        _anchorContext = anchorContext,
        _registry = registry,
        super(child);

  /// Updates properties and registry.
  void update({
    required Object anchor,
    required BuildContext anchorContext,
    required OverlayAnchorRegistry registry,
  }) {
    if (_anchor != anchor || !identical(_registry, registry)) {
      // Drop the old registration before moving to a new key or scope.
      _registry.unregister(_anchor);
      _anchor = anchor;
      _registry = registry;
    }
    _anchorContext = anchorContext;
    if (attached) {
      _register();
    }
  }

  void _register() {
    _registry.register(
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
    _registry.unregister(_anchor);
    super.detach();
  }
}
