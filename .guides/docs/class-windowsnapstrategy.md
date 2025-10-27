---
title: "Class: WindowSnapStrategy"
description: "Configuration for window snapping behavior and positioning."
---

```dart
/// Configuration for window snapping behavior and positioning.
///
/// Defines how windows should snap to screen edges or specific regions,
/// including the target bounds and whether the window should be minimized
/// during the snap operation.
///
/// Example:
/// ```dart
/// WindowSnapStrategy(
///   relativeBounds: Rect.fromLTWH(0, 0, 0.5, 1), // Left half of screen
///   shouldMinifyWindow: false,
/// )
/// ```
class WindowSnapStrategy {
  final Rect relativeBounds;
  final bool shouldMinifyWindow;
  const WindowSnapStrategy({required this.relativeBounds, this.shouldMinifyWindow = true});
}
```
