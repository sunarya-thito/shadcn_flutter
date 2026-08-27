---
title: "Class: LinkedAnchor"
description: "An [Anchor] resolved dynamically through an [OverlayAnchorRegistry], via the  key an [OverlayAnchor] widget was registered with.   The registry is resolved from the [BuildContext] passed to a `show()` call  (see [resolve]) so the anchor connects to the nearest [OverlayAnchorScope];  pass [registry] explicitly to target a specific one."
---

```dart
/// An [Anchor] resolved dynamically through an [OverlayAnchorRegistry], via the
/// key an [OverlayAnchor] widget was registered with.
///
/// The registry is resolved from the [BuildContext] passed to a `show()` call
/// (see [resolve]) so the anchor connects to the nearest [OverlayAnchorScope];
/// pass [registry] explicitly to target a specific one.
class LinkedAnchor extends Anchor {
  /// The registry key, matching an [OverlayAnchor.anchor].
  final Object key;
  /// The registry this anchor is bound to. When null it is filled in by
  /// [resolve] from the calling context's nearest [OverlayAnchorScope].
  final OverlayAnchorRegistry? registry;
  /// Creates a [LinkedAnchor].
  const LinkedAnchor(this.key, {this.registry});
  Anchor resolve(BuildContext context);
  AnchorSubscription subscribe();
}
```
