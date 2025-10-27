---
title: "Class: WindowState"
description: "Complete state configuration for a window instance."
---

```dart
/// Complete state configuration for a window instance.
///
/// Encapsulates all aspects of a window's current state including position, size,
/// visual state (minimized, maximized), capabilities (resizable, draggable), and
/// behavior settings (snapping, always on top).
///
/// Key Properties:
/// - **Position & Size**: [bounds] for current position, [maximized] for fullscreen state
/// - **Visual State**: [minimized] for taskbar state, [alwaysOnTop] for layering
/// - **Capabilities**: [resizable], [draggable], [closable], [maximizable], [minimizable]
/// - **Behavior**: [enableSnapping] for edge snapping, [constraints] for size limits
///
/// Used primarily with [WindowController] to manage window state programmatically
/// and provide reactive updates to window appearance and behavior.
///
/// Example:
/// ```dart
/// WindowState(
///   bounds: Rect.fromLTWH(100, 100, 800, 600),
///   resizable: true,
///   draggable: true,
///   enableSnapping: true,
///   constraints: BoxConstraints(minWidth: 400, minHeight: 300),
/// )
/// ```
class WindowState {
  final Rect bounds;
  final Rect? maximized;
  final bool minimized;
  final bool alwaysOnTop;
  final bool closable;
  final bool resizable;
  final bool draggable;
  final bool maximizable;
  final bool minimizable;
  final bool enableSnapping;
  final BoxConstraints constraints;
  const WindowState({required this.bounds, this.maximized, this.minimized = false, this.alwaysOnTop = false, this.closable = true, this.resizable = true, this.draggable = true, this.maximizable = true, this.minimizable = true, this.enableSnapping = true, this.constraints = kDefaultWindowConstraints});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
  WindowState withMaximized(Rect? maximized);
  WindowState copyWith({ValueGetter<Rect>? bounds, ValueGetter<bool>? minimized, ValueGetter<bool>? alwaysOnTop, ValueGetter<bool>? closable, ValueGetter<bool>? resizable, ValueGetter<bool>? draggable, ValueGetter<bool>? maximizable, ValueGetter<bool>? minimizable, ValueGetter<bool>? enableSnapping, ValueGetter<BoxConstraints>? constraints});
}
```
