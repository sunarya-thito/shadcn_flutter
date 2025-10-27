---
title: "Class: Window"
description: "A comprehensive windowing system for creating desktop-like window interfaces."
---

```dart
/// A comprehensive windowing system for creating desktop-like window interfaces.
///
/// **EXPERIMENTAL COMPONENT** - This component is in active development and APIs may change.
///
/// Provides a complete window management solution with draggable, resizable windows
/// that support minimizing, maximizing, and snapping to screen edges. Designed for
/// desktop-style applications requiring multiple simultaneous content areas.
///
/// Core Features:
/// - **Window Management**: Create, control, and destroy floating windows
/// - **Interactive Behaviors**: Drag, resize, minimize, maximize, close operations
/// - **Snapping System**: Intelligent edge snapping and window positioning
/// - **Layering Control**: Always-on-top and z-order management
/// - **Constraint System**: Size and position limits with validation
/// - **Theme Integration**: Full shadcn_flutter theme and styling support
///
/// Architecture:
/// - **Window**: Immutable window configuration and factory
/// - **WindowController**: Reactive state management for window properties
/// - **WindowWidget**: Stateful widget that renders the actual window
/// - **WindowNavigator**: Container managing multiple windows
///
/// The system supports both controlled (external state management) and 
/// uncontrolled (internal state management) modes for different use cases.
///
/// Usage Patterns:
/// 1. **Simple Window**: Basic window with default behaviors
/// 2. **Controlled Window**: External state management with WindowController
/// 3. **Window Navigator**: Multiple windows with shared management
///
/// Example:
/// ```dart
/// // Simple window
/// final window = Window(
///   title: Text('My Window'),
///   content: MyContent(),
///   bounds: Rect.fromLTWH(100, 100, 800, 600),
///   resizable: true,
///   draggable: true,
/// );
///
/// // Controlled window
/// final controller = WindowController(initialState);
/// final controlledWindow = Window.controlled(
///   controller: controller,
///   title: Text('Controlled Window'),
///   content: MyContent(),
/// );
/// ```
class Window {
  final Widget? title;
  final Widget? actions;
  final Widget? content;
  final WindowController? controller;
  final Rect? bounds;
  final Rect? maximized;
  final bool? minimized;
  final bool? alwaysOnTop;
  final bool? enableSnapping;
  final bool? resizable;
  final bool? draggable;
  final bool? closable;
  final bool? maximizable;
  final bool? minimizable;
  final BoxConstraints? constraints;
  final ValueNotifier<bool> closed;
  Window.controlled({this.title, this.actions = const WindowActions(), this.content, required this.controller});
  Window({this.title, this.actions = const WindowActions(), this.content, bool this.resizable = true, bool this.draggable = true, bool this.closable = true, bool this.maximizable = true, bool this.minimizable = true, bool this.enableSnapping = true, required this.bounds, this.maximized, bool this.minimized = false, bool this.alwaysOnTop = false, BoxConstraints this.constraints = kDefaultWindowConstraints});
  WindowHandle get handle;
  bool get mounted;
}
```
