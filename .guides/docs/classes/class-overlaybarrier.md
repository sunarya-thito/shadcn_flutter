---
title: "Class: OverlayBarrier"
description: "Configuration for overlay modal barriers."
---

```dart
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
  const OverlayBarrier({this.padding = EdgeInsets.zero, this.borderRadius = BorderRadius.zero, this.barrierColor});
}
```
