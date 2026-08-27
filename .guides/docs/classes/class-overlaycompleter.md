---
title: "Class: OverlayCompleter"
description: "Abstract interface for overlay operation completion tracking.   Provides lifecycle management and status tracking for overlay operations,  including completion state, animation state, dismissal, and (for  mechanisms that support it) live in-place configuration updates."
---

```dart
/// Abstract interface for overlay operation completion tracking.
///
/// Provides lifecycle management and status tracking for overlay operations,
/// including completion state, animation state, dismissal, and (for
/// mechanisms that support it) live in-place configuration updates.
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
  /// Closes the overlay.
  ///
  /// Parameters:
  /// - [immediate] (bool): If true, closes immediately without animation.
  ///
  /// Returns a [Future] that completes when closed. Defaults to [remove].
  Future<void> close([bool immediate = false]);
  /// Schedules overlay closure for the next frame.
  ///
  /// Useful for closing overlays from callbacks where immediate closure
  /// might cause issues with the widget tree. Defaults to [remove].
  void closeLater();
  /// Closes the overlay with a result value.
  ///
  /// Parameters:
  /// - [value] (X?): Optional result to return.
  ///
  /// Returns a [Future] that completes when closed. Defaults to [remove].
  Future<void> closeWithResult<X>([X? value]);
  /// The configuration currently applied to this overlay, if this mechanism
  /// tracks one.
  OverlayConfiguration? get config;
  /// Updates alignment, margin, follow, or other settings on the open
  /// overlay without closing and reopening it. Drawer, sheet, and dialog
  /// don't support live updates and can leave this unimplemented;
  /// [OverlayController] closes and reopens the overlay for those instead.
  set config(OverlayConfiguration? value);
}
```
