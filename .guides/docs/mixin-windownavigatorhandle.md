---
title: "Mixin: WindowNavigatorHandle"
description: "Reference for WindowNavigatorHandle"
---

```dart
mixin WindowNavigatorHandle on State<WindowNavigator> {
  void pushWindow(Window window);
  void focusWindow(Window window);
  void unfocusWindow(Window window);
  void setAlwaysOnTop(Window window, bool value);
  void removeWindow(Window window);
  bool isFocused(Window window);
  List<Window> get windows;
}
```
