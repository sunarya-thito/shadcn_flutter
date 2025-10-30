---
title: "Mixin: WindowNavigatorHandle"
description: "Mixin providing window management capabilities for WindowNavigator state."
---

```dart
/// Mixin providing window management capabilities for WindowNavigator state.
///
/// This mixin defines the interface for managing multiple windows in a
/// window navigator. It provides methods for adding, removing, focusing,
/// and managing window states.
///
/// Implementations must provide these core window management operations:
/// - Adding and removing windows from the navigator
/// - Managing window focus and z-order
/// - Controlling always-on-top behavior
/// - Querying window focus state and window list
///
/// See also:
/// - [WindowNavigator], the widget that uses this mixin
/// - [Window], the window objects being managed
mixin WindowNavigatorHandle on State<WindowNavigator> {
  /// Adds a new window to the navigator.
  ///
  /// The window is added to the navigator's window list and typically
  /// appears at the top of the window stack with focus.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to add
  void pushWindow(Window window);
  /// Brings a window to the front and gives it focus.
  ///
  /// Moves the specified window to the top of the window stack and
  /// sets it as the focused window for keyboard input and user interaction.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to focus
  void focusWindow(Window window);
  /// Removes focus from a window without closing it.
  ///
  /// The window remains in the navigator but loses focus. Another window
  /// may receive focus, or no window may be focused.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to unfocus
  void unfocusWindow(Window window);
  /// Sets whether a window should always appear on top.
  ///
  /// Always-on-top windows remain above other windows even when they
  /// lose focus. Useful for tool palettes and notification windows.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to modify
  /// - [value] (bool, required): True to set always-on-top, false to disable
  void setAlwaysOnTop(Window window, bool value);
  /// Removes a window from the navigator.
  ///
  /// The window is removed from the navigator's window list and destroyed.
  /// If the window was focused, focus may move to another window.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to remove
  void removeWindow(Window window);
  /// Checks if a window is currently focused.
  ///
  /// Parameters:
  /// - [window] (Window, required): The window to check
  ///
  /// Returns true if the window is focused, false otherwise.
  bool isFocused(Window window);
  /// Gets the list of all windows in the navigator.
  ///
  /// Returns an ordered list of windows, typically in z-order from
  /// bottom to top.
  List<Window> get windows;
}
```
