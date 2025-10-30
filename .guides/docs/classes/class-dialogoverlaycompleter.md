---
title: "Class: DialogOverlayCompleter"
description: "Completer that manages the lifecycle of a dialog overlay."
---

```dart
/// Completer that manages the lifecycle of a dialog overlay.
///
/// Provides control over dialog animations, completion status, and disposal.
/// Wraps a [DialogRoute] to offer a consistent interface for managing
/// dialog lifecycles through the overlay system.
///
/// Features:
/// - Animation state monitoring
/// - Future-based completion handling
/// - Proper resource disposal
/// - Route management integration
///
/// Example:
/// ```dart
/// final completer = DialogOverlayCompleter(dialogRoute);
/// await completer.future; // Wait for dialog completion
/// completer.remove(); // Programmatically close dialog
/// ```
class DialogOverlayCompleter<T> extends OverlayCompleter<T> {
  /// The dialog route managed by this completer.
  final DialogRoute<T> route;
  /// Creates a [DialogOverlayCompleter].
  ///
  /// Parameters:
  /// - [route] (`DialogRoute<T>`, required): the dialog route to manage
  ///
  /// Example:
  /// ```dart
  /// DialogOverlayCompleter(myDialogRoute)
  /// ```
  DialogOverlayCompleter(this.route);
  Future<void> get animationFuture;
  void dispose();
  Future<T> get future;
  bool get isAnimationCompleted;
  bool get isCompleted;
  void remove();
}
```
