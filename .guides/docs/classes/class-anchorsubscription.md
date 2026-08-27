---
title: "Class: AnchorSubscription"
description: "A live handle on an [Anchor]'s position/visibility, obtained via  [Anchor.subscribe]. [Listenable] listeners are notified whenever the  anchor may have moved, resized, or changed visibility. There's no  explicit dispose method — implementations stop their internal work once  the last listener is removed."
---

```dart
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
  /// Whether this subscription supports tracking the anchor through the
  /// compositing pipeline (see [currentAnchorBox]).
  ///
  /// When true, the popover positions itself against the anchor's live position
  /// every scene build — zero-lag, and with margin/invert re-evaluated during
  /// scroll — instead of relying on a per-frame ticker + re-layout. Defaults to
  /// false; [_LinkedAnchorSubscription] enables it.
  bool get supportsCompositeTracking;
  /// The anchor's currently-registered [RenderBox], or null if it can't be
  /// resolved right now. Read at composite time by the popover's layout to
  /// measure the anchor's live on-screen position. Only meaningful when
  /// [supportsCompositeTracking] is true.
  RenderBox? get currentAnchorBox;
}
```
