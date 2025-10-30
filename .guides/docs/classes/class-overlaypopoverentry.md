---
title: "Class: OverlayPopoverEntry"
description: "Implementation of [OverlayCompleter] for popover overlays."
---

```dart
/// Implementation of [OverlayCompleter] for popover overlays.
///
/// Manages the lifecycle of a popover overlay entry, tracking completion
/// state and handling overlay/barrier entry disposal.
class OverlayPopoverEntry<T> implements OverlayCompleter<T> {
  /// Completer for the popover's result value.
  final Completer<T?> completer;
  /// Completer that tracks the popover's animation lifecycle.
  ///
  /// Completes when the popover's entry and exit animations finish.
  /// Used internally to coordinate animation timing and cleanup.
  final Completer<T?> animationCompleter;
  bool get isCompleted;
  /// Initializes the popover entry with overlay entries.
  ///
  /// Must be called before the popover can be displayed.
  ///
  /// Parameters:
  /// - [overlayEntry] (OverlayEntry, required): Main overlay entry
  /// - [barrierEntry] (OverlayEntry?): Optional barrier entry
  void initialize(OverlayEntry overlayEntry, [OverlayEntry? barrierEntry]);
  void remove();
  void dispose();
  Future<T?> get future;
  Future<T?> get animationFuture;
  bool get isAnimationCompleted;
}
```
