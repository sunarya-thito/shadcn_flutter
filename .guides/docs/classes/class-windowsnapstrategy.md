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
  /// Relative bounds where the window should snap, in screen-relative coordinates.
  ///
  /// Values range from 0.0 to 1.0, representing proportions of the screen.
  /// For example, `Rect.fromLTWH(0, 0, 0.5, 1)` represents the left half
  /// of the screen (0% to 50% horizontally, full height).
  final Rect relativeBounds;
  /// Whether the window should be minimized during the snap operation.
  ///
  /// When `true`, the window will minimize before snapping to the target
  /// position. When `false`, the window immediately snaps without minimizing.
  ///
  /// Defaults to `true`.
  final bool shouldMinifyWindow;
  /// Creates a window snap strategy with the specified bounds and behavior.
  ///
  /// Parameters:
  /// - [relativeBounds]: Target screen region (required, in 0.0-1.0 coordinates)
  /// - [shouldMinifyWindow]: Whether to minimize during snap (defaults to `true`)
  const WindowSnapStrategy({required this.relativeBounds, this.shouldMinifyWindow = true});
}
```
