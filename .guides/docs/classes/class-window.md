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
  /// Title widget displayed in the window's title bar.
  final Widget? title;
  /// Custom action widgets displayed in the title bar (e.g., minimize, maximize, close buttons).
  final Widget? actions;
  /// Main content widget displayed in the window body.
  final Widget? content;
  /// Controller for programmatic window management (position, size, state).
  final WindowController? controller;
  /// Initial bounds (position and size) of the window.
  final Rect? bounds;
  /// Bounds when window is in maximized state.
  final Rect? maximized;
  /// Whether the window starts in minimized state.
  final bool? minimized;
  /// Whether the window should always appear on top of other windows.
  final bool? alwaysOnTop;
  /// Whether window snapping is enabled (snap to edges or other windows).
  final bool? enableSnapping;
  /// Whether the window can be resized by dragging edges.
  final bool? resizable;
  /// Whether the window can be dragged by its title bar.
  final bool? draggable;
  /// Whether the window can be closed via the close button.
  final bool? closable;
  /// Whether the window can be maximized.
  final bool? maximizable;
  /// Whether the window can be minimized.
  final bool? minimizable;
  /// Size constraints for the window (min/max width and height).
  final BoxConstraints? constraints;
  /// Notifier that indicates whether the window has been closed.
  ///
  /// External code can listen to this notifier to react to window close events.
  final ValueNotifier<bool> closed;
  /// Creates a controlled window with behavior managed by a [WindowController].
  ///
  /// This constructor creates a window whose state (position, size, minimized,
  /// maximized) is entirely controlled programmatically through the provided
  /// controller. All state properties are null and managed via the controller.
  ///
  /// Parameters:
  /// - [title] (Widget?): Title widget for the title bar
  /// - [actions] (Widget?): Custom action widgets, defaults to `WindowActions()`
  /// - [content] (Widget?): Main content widget
  /// - [controller] (WindowController, required): Controller for programmatic management
  ///
  /// Example:
  /// ```dart
  /// Window.controlled(
  ///   controller: myWindowController,
  ///   title: Text('Controlled Window'),
  ///   content: MyContentWidget(),
  /// )
  /// ```
  Window.controlled({this.title, this.actions = const WindowActions(), this.content, required this.controller});
  /// Creates a window with explicit state and configuration.
  ///
  /// This constructor creates a window with directly specified state properties
  /// rather than using a controller. The window's initial position, size, and
  /// capabilities are defined through the constructor parameters.
  ///
  /// Parameters:
  /// - [title] (Widget?): Title widget for the title bar
  /// - [actions] (Widget?): Custom action widgets, defaults to `WindowActions()`
  /// - [content] (Widget?): Main content widget
  /// - [resizable] (bool): Whether window can be resized, defaults to true
  /// - [draggable] (bool): Whether window can be dragged, defaults to true
  /// - [closable] (bool): Whether window can be closed, defaults to true
  /// - [maximizable] (bool): Whether window can be maximized, defaults to true
  /// - [minimizable] (bool): Whether window can be minimized, defaults to true
  /// - [enableSnapping] (bool): Whether snapping is enabled, defaults to true
  /// - [bounds] (Rect, required): Initial window bounds (position and size)
  /// - [maximized] (Rect?): Bounds when maximized
  /// - [minimized] (bool): Whether starts minimized, defaults to false
  /// - [alwaysOnTop] (bool): Whether always on top, defaults to false
  /// - [constraints] (BoxConstraints): Size constraints, defaults to `kDefaultWindowConstraints`
  ///
  /// Example:
  /// ```dart
  /// Window(
  ///   title: Text('My Window'),
  ///   bounds: Rect.fromLTWH(100, 100, 400, 300),
  ///   resizable: true,
  ///   content: MyContentWidget(),
  /// )
  /// ```
  Window({this.title, this.actions = const WindowActions(), this.content, bool this.resizable = true, bool this.draggable = true, bool this.closable = true, bool this.maximizable = true, bool this.minimizable = true, bool this.enableSnapping = true, required this.bounds, this.maximized, bool this.minimized = false, bool this.alwaysOnTop = false, BoxConstraints this.constraints = kDefaultWindowConstraints});
  /// Gets a handle to the window's internal state.
  ///
  /// Provides access to the window's state for programmatic control.
  /// The window must be mounted (added to the widget tree) before accessing
  /// this handle.
  ///
  /// Throws [AssertionError] if the window is not mounted.
  ///
  /// Returns [WindowHandle] for controlling the window state.
  WindowHandle get handle;
  /// Indicates whether the window is currently mounted in the widget tree.
  ///
  /// A window is mounted when it has been added to the widget tree and has
  /// an associated build context. Unmounted windows cannot be controlled or
  /// accessed.
  ///
  /// Returns true if window is mounted, false otherwise.
  bool get mounted;
}
```
