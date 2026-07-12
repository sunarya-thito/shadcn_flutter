import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Describes an anchor point that overlays (popovers, menus, tooltips) can
/// position themselves relative to, and optionally track as it moves.
abstract class Anchor {
  /// Creates an [Anchor].
  const Anchor();

  /// Starts a live subscription to this anchor's position/visibility.
  AnchorSubscription subscribe();

  /// Fills in any defaults this anchor needs from [context] — the
  /// [BuildContext] of whatever `show()` call is about to use this anchor.
  ///
  /// The base implementation just returns `this` (most anchors don't need
  /// anything from the calling context); [ContextAnchor] overrides this to
  /// substitute [context] when it wasn't given one explicitly.
  Anchor resolve(BuildContext context) => this;
}

/// A live handle on an [Anchor]'s position/visibility, obtained via
/// [Anchor.subscribe]. [Listenable] listeners are notified whenever the
/// anchor may have moved, resized, or changed visibility. There's no
/// explicit dispose method — implementations stop their internal work once
/// the last listener is removed.
abstract class AnchorSubscription implements Listenable {
  /// Whether the anchor currently resolves to a live, mounted render object.
  bool get isVisible;

  /// The anchor's current box size, or null if not currently resolvable.
  Size? get anchorSize;

  /// Computes the transform that maps a point in the anchor's local
  /// coordinate space into [source]'s local coordinate space.
  ///
  /// [source] and the anchor are generally not ancestor/descendant of each
  /// other (the anchor lives in the "normal" widget tree, [source] lives in
  /// a separate overlay-entry render tree), so [RenderObject.getTransformTo]
  /// can't be used directly between them.
  Matrix4 computeTransform(RenderObject source);
}

/// Computes the transform from [anchorBox]'s local coordinate space into
/// [source]'s local coordinate space, for two render objects that aren't
/// necessarily ancestor/descendant of each other.
Matrix4 anchorTransformRelativeTo(RenderBox anchorBox, RenderObject source) {
  final Matrix4 anchorToGlobal = anchorBox.getTransformTo(null);
  final Matrix4 sourceToGlobal = source.getTransformTo(null);
  final Matrix4 globalToSource = Matrix4.copy(sourceToGlobal)..invert();
  return globalToSource.multiplied(anchorToGlobal);
}

/// An [Anchor] resolved from a plain [BuildContext].
///
/// If [context] is null (`const ContextAnchor()`), it's resolved by the
/// consumer (e.g. [PopoverOverlayHandler.show]) to whatever [BuildContext]
/// the `show()` call itself received.
class ContextAnchor extends Anchor {
  /// The context to anchor to, or null to use the consumer's own context.
  final BuildContext? context;

  /// Creates a [ContextAnchor].
  const ContextAnchor([this.context]);

  @override
  AnchorSubscription subscribe() => _ContextAnchorSubscription(context);

  @override
  Anchor resolve(BuildContext context) =>
      this.context == null ? ContextAnchor(context) : this;
}

/// An [Anchor] resolved dynamically through [OverlayAnchorRegistry], via the
/// key an [OverlayAnchor] widget was registered with.
class LinkedAnchor extends Anchor {
  /// The registry key, matching an [OverlayAnchor.anchor].
  final Object key;

  /// Creates a [LinkedAnchor].
  const LinkedAnchor(this.key);

  @override
  AnchorSubscription subscribe() => _LinkedAnchorSubscription(key);
}

/// [ContextAnchor]'s subscription. There's no reliable "about to move/be
/// removed" hook for an arbitrary [BuildContext], so this polls every frame
/// via a standalone [Ticker] (not tied to any [TickerProvider]/vsync) while
/// it has listeners; the ticker itself doesn't recompute anything, it just
/// prompts listeners to re-check [isVisible]/[anchorSize]/[computeTransform].
class _ContextAnchorSubscription extends ChangeNotifier
    implements AnchorSubscription {
  final BuildContext? context;
  late final Ticker _ticker;

  _ContextAnchorSubscription(this.context) {
    _ticker = Ticker(_onTick);
  }

  void _onTick(Duration elapsed) => notifyListeners();

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    if (hasListeners && !_ticker.isActive) _ticker.start();
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (!hasListeners && _ticker.isActive) _ticker.stop();
  }

  RenderBox? get _box {
    final ctx = context;
    if (ctx == null || !ctx.mounted) return null;
    return ctx.findRenderObject() as RenderBox?;
  }

  @override
  bool get isVisible => _box != null;

  @override
  Size? get anchorSize {
    final box = _box;
    if (box == null || !box.attached || !box.hasSize) return null;
    return box.size;
  }

  @override
  Matrix4 computeTransform(RenderObject source) {
    final box = _box;
    if (box == null || !box.attached) return Matrix4.identity();
    return anchorTransformRelativeTo(box, source);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}

/// [LinkedAnchor]'s subscription. Event-driven (no ticker): it forwards
/// listener registration directly onto the currently-registered
/// [RenderOverlayAnchor] for [key], re-resolving from
/// [OverlayAnchorRegistry] every time it (re)binds so it self-heals if the
/// registered render object is swapped for a new instance.
class _LinkedAnchorSubscription extends ChangeNotifier
    implements AnchorSubscription {
  final Object key;
  RenderOverlayAnchor? _bound;

  _LinkedAnchorSubscription(this.key);

  RenderOverlayAnchor? get _liveAnchor {
    final box = OverlayAnchorRegistry.find(key)?.renderBox;
    return box is RenderOverlayAnchor ? box : null;
  }

  void _rebind() {
    final current = _liveAnchor;
    if (identical(current, _bound)) return;
    _bound?.removeListener(_handleAnchorRepaint);
    _bound = current;
    _bound?.addListener(_handleAnchorRepaint);
  }

  void _handleAnchorRepaint() {
    _rebind();
    notifyListeners();
  }

  @override
  void addListener(VoidCallback listener) {
    final wasEmpty = !hasListeners;
    super.addListener(listener);
    if (wasEmpty) _rebind();
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (!hasListeners) {
      _bound?.removeListener(_handleAnchorRepaint);
      _bound = null;
    }
  }

  @override
  bool get isVisible {
    final entry = OverlayAnchorRegistry.find(key);
    return entry != null && entry.context.mounted;
  }

  @override
  Size? get anchorSize {
    final box = OverlayAnchorRegistry.find(key)?.renderBox;
    if (box == null || !box.attached || !box.hasSize) return null;
    return box.size;
  }

  @override
  Matrix4 computeTransform(RenderObject source) {
    final box = OverlayAnchorRegistry.find(key)?.renderBox;
    if (box == null || !box.attached) return Matrix4.identity();
    return anchorTransformRelativeTo(box, source);
  }

  @override
  void dispose() {
    _bound?.removeListener(_handleAnchorRepaint);
    _bound = null;
    super.dispose();
  }
}
