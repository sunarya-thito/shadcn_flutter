---
title: "Mixin: WindowHandle"
description: "Reference for WindowHandle"
---

```dart
mixin WindowHandle on State<WindowWidget> {
  Rect get bounds;
  set bounds(Rect value);
  Rect? get maximized;
  set maximized(Rect? value);
  bool get minimized;
  set minimized(bool value);
  bool get focused;
  set focused(bool value);
  void close();
  bool get alwaysOnTop;
  set alwaysOnTop(bool value);
  bool get resizable;
  bool get draggable;
  bool get closable;
  bool get maximizable;
  bool get minimizable;
  bool get enableSnapping;
  set resizable(bool value);
  set draggable(bool value);
  set closable(bool value);
  set maximizable(bool value);
  set minimizable(bool value);
  set enableSnapping(bool value);
  WindowController get controller;
}
```
