---
title: "Class: OverlayAnchor"
description: "A widget that acts as a generalized anchor for overlays.   It registers its [RenderBox] and [BuildContext] dynamically in the nearest  [OverlayAnchorRegistry] (see [OverlayAnchorScope]) using an arbitrary key  (see [LinkedAnchor])."
---

```dart
/// A widget that acts as a generalized anchor for overlays.
///
/// It registers its [RenderBox] and [BuildContext] dynamically in the nearest
/// [OverlayAnchorRegistry] (see [OverlayAnchorScope]) using an arbitrary key
/// (see [LinkedAnchor]).
class OverlayAnchor extends SingleChildRenderObjectWidget {
  /// The unique key representing this anchor.
  final Object anchor;
  /// Creates an [OverlayAnchor].
  const OverlayAnchor({super.key, required this.anchor, required Widget super.child});
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, covariant RenderOverlayAnchor renderObject);
}
```
