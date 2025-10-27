---
title: "Class: DrawerOverlayCompleter"
description: "Reference for DrawerOverlayCompleter"
---

```dart
class DrawerOverlayCompleter<T> extends OverlayCompleter<T> {
  DrawerOverlayCompleter(this._entry);
  Future<void> get animationFuture;
  void dispose();
  AnimationController? get animationController;
  Future<T> get future;
  bool get isAnimationCompleted;
  bool get isCompleted;
  void remove();
}
```
