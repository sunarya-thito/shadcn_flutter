---
title: "Class: OverlayCompleter"
description: "Reference for OverlayCompleter"
---

```dart
abstract class OverlayCompleter<T> {
  void remove();
  void dispose();
  bool get isCompleted;
  bool get isAnimationCompleted;
  Future<T?> get future;
  Future<void> get animationFuture;
}
```
