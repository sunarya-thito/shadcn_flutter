---
title: "Mixin: WindowHandle"
description: "Interface for controlling window state and behavior."
---

```dart
/// Interface for controlling window state and behavior.
///
/// Mixin that provides access to window properties and operations.
/// Implemented by window state classes to manage window lifecycle.
mixin WindowHandle on State<WindowWidget> {
  /// Gets the current window bounds.
  Rect get bounds;
  /// Sets the window bounds.
  set bounds(Rect value);
  /// Gets the maximized bounds, or null if not maximized.
  Rect? get maximized;
  /// Sets the maximized bounds.
  set maximized(Rect? value);
  /// Whether the window is minimized.
  bool get minimized;
  /// Sets the minimized state.
  set minimized(bool value);
  /// Whether the window has focus.
  bool get focused;
  /// Sets the focused state.
  set focused(bool value);
  /// Closes the window.
  void close();
  /// Whether the window stays on top of other windows.
  bool get alwaysOnTop;
  /// Sets the always-on-top state.
  set alwaysOnTop(bool value);
  /// Whether the window can be resized.
  bool get resizable;
  /// Whether the window can be dragged.
  bool get draggable;
  /// Whether the window can be closed.
  bool get closable;
  /// Whether the window can be maximized.
  bool get maximizable;
  /// Whether the window can be minimized.
  bool get minimizable;
  /// Whether window snapping is enabled.
  bool get enableSnapping;
  /// Sets the resizable state.
  set resizable(bool value);
  /// Sets the draggable state.
  set draggable(bool value);
  /// Sets the closable state.
  set closable(bool value);
  /// Sets the maximizable state.
  set maximizable(bool value);
  /// Sets the minimizable state.
  set minimizable(bool value);
  /// Sets the snapping enabled state.
  set enableSnapping(bool value);
  /// Gets the window controller.
  WindowController get controller;
}
```
