---
title: "Class: DrawerLayerData"
description: "Data class representing a drawer overlay layer in the hierarchy."
---

```dart
/// Data class representing a drawer overlay layer in the hierarchy.
///
/// Tracks the drawer overlay state and its parent layer, enabling nested
/// drawer management and size computation across the layer stack.
class DrawerLayerData {
  /// The drawer overlay state for this layer.
  final DrawerOverlayState overlay;
  /// The parent drawer layer, null if this is the root layer.
  final DrawerLayerData? parent;
  /// Creates drawer layer data.
  ///
  /// Parameters:
  /// - [overlay] (DrawerOverlayState, required): Overlay state for this layer
  /// - [parent] (DrawerLayerData?): Parent layer in the hierarchy
  const DrawerLayerData(this.overlay, this.parent);
  /// Computes the size of this drawer layer.
  ///
  /// Delegates to the overlay state to calculate the layer dimensions.
  ///
  /// Returns the computed size or null if not available.
  Size? computeSize();
  bool operator ==(Object other);
  int get hashCode;
}
```
