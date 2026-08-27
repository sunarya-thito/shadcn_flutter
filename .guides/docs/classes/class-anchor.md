---
title: "Class: Anchor"
description: "Describes an anchor point that overlays (popovers, menus, tooltips) can  position themselves relative to, and optionally track as it moves."
---

```dart
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
  Anchor resolve(BuildContext context);
}
```
