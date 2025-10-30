---
title: "Class: WindowViewport"
description: "Data class containing viewport information for a window."
---

```dart
/// Data class containing viewport information for a window.
///
/// WindowViewport provides contextual information about a window's current
/// state within the window navigator. This data is made available to child
/// widgets through the Data inheritance mechanism.
///
/// The viewport information includes:
/// - Size of the visible area
/// - Reference to the navigator managing the window
/// - Focus and display state flags
/// - Interaction state (pointer events, minimization)
///
/// This class is typically used internally by the window system to pass
/// state information to window content and decoration widgets.
class WindowViewport {
  /// The size of the window's visible area.
  final Size size;
  /// Reference to the window navigator managing this window.
  final WindowNavigatorHandle navigator;
  /// Whether this window currently has focus.
  final bool focused;
  /// Whether this window is set to always appear on top.
  final bool alwaysOnTop;
  /// Whether this window has been closed.
  final bool closed;
  /// Whether the window is being minimized (transitioning to minimized state).
  final bool minify;
  /// Whether pointer events should be ignored for this window.
  final bool ignorePointer;
  /// Creates a window viewport data object.
  ///
  /// All parameters are required and define the current state of the window
  /// within its viewport context.
  ///
  /// Parameters:
  /// - [size] (Size, required): Visible area size
  /// - [navigator] (WindowNavigatorHandle, required): Managing navigator
  /// - [focused] (bool, required): Focus state
  /// - [alwaysOnTop] (bool, required): Always-on-top state
  /// - [closed] (bool, required): Closed state
  /// - [minify] (bool, required): Minimizing state
  /// - [ignorePointer] (bool, required): Pointer event state
  const WindowViewport({required this.size, required this.navigator, required this.focused, required this.alwaysOnTop, required this.closed, required this.minify, required this.ignorePointer});
  bool operator ==(Object other);
  int get hashCode;
}
```
