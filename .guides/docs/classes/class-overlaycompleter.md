---
title: "Class: OverlayCompleter"
description: "Abstract interface for overlay operation completion tracking."
---

```dart
/// Abstract interface for overlay operation completion tracking.
///
/// Provides lifecycle management and status tracking for overlay operations,
/// including completion state, animation state, and dismissal.
abstract class OverlayCompleter<T> {
  /// Removes the overlay from the screen.
  void remove();
  /// Disposes resources associated with the overlay.
  void dispose();
  /// Whether the overlay operation has completed.
  bool get isCompleted;
  /// Whether the overlay's animation has completed.
  bool get isAnimationCompleted;
  /// Future that completes with the overlay's result value.
  Future<T?> get future;
  /// Future that completes when the overlay animation finishes.
  Future<void> get animationFuture;
}
```
