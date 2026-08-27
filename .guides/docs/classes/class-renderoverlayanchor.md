---
title: "Class: RenderOverlayAnchor"
description: "The render object for [OverlayAnchor].   Handles construction, updates, and automatic unregistration when detached.  Overlays anchored to it read its live on-screen position directly through  [RenderObject.getTransformTo] during compositing — see the movement detector  in `anchor.dart` — so it needs no special layer of its own."
---

```dart
/// The render object for [OverlayAnchor].
///
/// Handles construction, updates, and automatic unregistration when detached.
/// Overlays anchored to it read its live on-screen position directly through
/// [RenderObject.getTransformTo] during compositing — see the movement detector
/// in `anchor.dart` — so it needs no special layer of its own.
class RenderOverlayAnchor extends RenderProxyBox {
  /// Creates a [RenderOverlayAnchor].
  RenderOverlayAnchor({required Object anchor, required BuildContext anchorContext, required OverlayAnchorRegistry registry, RenderBox? child});
  /// Updates properties and registry.
  void update({required Object anchor, required BuildContext anchorContext, required OverlayAnchorRegistry registry});
  void attach(PipelineOwner owner);
  void detach();
}
```
