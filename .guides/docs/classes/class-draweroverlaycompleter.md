---
title: "Class: DrawerOverlayCompleter"
description: "Completer for drawer overlay operations."
---

```dart
/// Completer for drawer overlay operations.
///
/// Wraps a [DrawerOverlayEntry] to provide overlay lifecycle management,
/// including animation tracking and dismissal handling.
class DrawerOverlayCompleter<T> extends OverlayCompleter<T> {
  /// Creates a drawer overlay completer.
  ///
  /// Parameters:
  /// - [_entry] (`DrawerOverlayEntry<T>`, required): The drawer entry to manage
  DrawerOverlayCompleter(this._entry);
  Future<void> get animationFuture;
  void dispose();
  /// Gets the animation controller for the drawer.
  ///
  /// Returns the external animation controller if provided, otherwise
  /// returns the internal controller from the drawer entry widget state.
  ///
  /// Returns [AnimationController] or null if not available.
  AnimationController? get animationController;
  Future<T> get future;
  bool get isAnimationCompleted;
  bool get isCompleted;
  void remove();
}
```
