---
title: "Class: OverlayPopoverEntry"
description: "Reference for OverlayPopoverEntry"
---

```dart
class OverlayPopoverEntry<T> implements OverlayCompleter<T> {
  final Completer<T?> completer;
  final Completer<T?> animationCompleter;
  bool get isCompleted;
  void initialize(OverlayEntry overlayEntry, [OverlayEntry? barrierEntry]);
  void remove();
  void dispose();
  Future<T?> get future;
  Future<T?> get animationFuture;
  bool get isAnimationCompleted;
}
```
