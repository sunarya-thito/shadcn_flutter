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
