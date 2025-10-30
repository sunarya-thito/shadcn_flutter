---
title: "Class: WindowController"
description: "Reactive controller for managing window state and operations."
---

```dart
/// Reactive controller for managing window state and operations.
///
/// Provides programmatic control over window properties with automatic UI updates
/// through [ValueNotifier] pattern. Handles window state management, validation,
/// and coordination with the window widget lifecycle.
///
/// Key Capabilities:
/// - **Reactive Updates**: Automatic UI refresh when state changes
/// - **Property Management**: Convenient getters/setters for window properties
/// - **Lifecycle Handling**: Mount/unmount detection and validation
/// - **State Validation**: Ensures state consistency and constraint compliance
/// - **Handle Management**: Coordination with underlying window implementation
///
/// Usage Pattern:
/// 1. Create controller with initial window configuration
/// 2. Pass to Window.controlled() constructor
/// 3. Modify properties programmatically (bounds, minimized, etc.)
/// 4. UI automatically updates to reflect changes
/// 5. Listen to controller for state change notifications
///
/// Example:
/// ```dart
/// final controller = WindowController(
///   bounds: Rect.fromLTWH(100, 100, 800, 600),
///   resizable: true,
///   draggable: true,
/// );
///
/// // Programmatic control
/// controller.bounds = Rect.fromLTWH(200, 200, 900, 700);
/// controller.minimized = true;
/// controller.maximized = Rect.fromLTWH(0, 0, 1920, 1080);
///
/// // Listen for changes
/// controller.addListener(() {
///   print('Window state changed: ${controller.value}');
/// });
/// ```
class WindowController extends ValueNotifier<WindowState> {
  /// Creates a [WindowController].
  ///
  /// Parameters:
  /// - [bounds] (`Rect`, required): Initial window bounds.
  /// - [maximized] (`Rect?`, optional): Maximized bounds, or null if not maximized.
  /// - [minimized] (`bool`, default: `false`): Initial minimized state.
  /// - [focused] (`bool`, default: `false`): Initial focused state.
  /// - [closable] (`bool`, default: `true`): Whether window can be closed.
  /// - [resizable] (`bool`, default: `true`): Whether window can be resized.
  /// - [draggable] (`bool`, default: `true`): Whether window can be dragged.
  /// - [maximizable] (`bool`, default: `true`): Whether window can be maximized.
  /// - [minimizable] (`bool`, default: `true`): Whether window can be minimized.
  /// - [enableSnapping] (`bool`, default: `true`): Whether window snapping is enabled.
  /// - [constraints] (`BoxConstraints`, default: `kDefaultWindowConstraints`): Size constraints.
  WindowController({required Rect bounds, Rect? maximized, bool minimized = false, bool focused = false, bool closable = true, bool resizable = true, bool draggable = true, bool maximizable = true, bool minimizable = true, bool enableSnapping = true, BoxConstraints constraints = kDefaultWindowConstraints});
  /// Whether the controller is currently attached to a window widget.
  ///
  /// Returns `true` if the controller is mounted within a window widget
  /// and can safely access [attachedState]. Returns `false` otherwise.
  bool get mounted;
  /// The window handle this controller is attached to.
  ///
  /// Provides access to the underlying window implementation for advanced
  /// operations. Only accessible when [mounted] is `true`.
  ///
  /// Throws an assertion error if accessed when not mounted.
  WindowHandle get attachedState;
  /// Current position and size of the window.
  ///
  /// Setting this property updates the window bounds and triggers a UI refresh.
  /// The setter is a no-op if the new value equals the current value.
  Rect get bounds;
  /// Updates the window bounds.
  ///
  /// Changes take effect immediately and trigger listener notifications.
  set bounds(Rect value);
  /// Maximized bounds, or `null` if the window is not maximized.
  ///
  /// When non-null, indicates the window is in maximized state.
  Rect? get maximized;
  /// Sets the maximized state and bounds.
  ///
  /// Pass a [Rect] to maximize the window to those bounds.
  /// Pass `null` to restore the window from maximized state.
  set maximized(Rect? value);
  /// Whether the window is currently minimized.
  ///
  /// When `true`, the window is hidden from view (e.g., in taskbar).
  bool get minimized;
  /// Sets the minimized state.
  ///
  /// Set to `true` to minimize the window, `false` to restore it.
  set minimized(bool value);
  /// Whether the window always appears on top of other windows.
  bool get alwaysOnTop;
  /// Sets the always-on-top behavior.
  ///
  /// When `true`, the window renders above other windows regardless of focus.
  set alwaysOnTop(bool value);
  /// Whether the window can be closed.
  bool get closable;
  /// Sets whether the window can be closed.
  ///
  /// When `false`, the close button is disabled or hidden.
  set closable(bool value);
  /// Whether the window can be resized by dragging edges/corners.
  bool get resizable;
  /// Sets whether the window can be resized.
  set resizable(bool value);
  /// Whether the window can be moved by dragging the title bar.
  bool get draggable;
  /// Sets whether the window can be dragged.
  set draggable(bool value);
  /// Whether the window can be maximized.
  bool get maximizable;
  /// Sets whether the window can be maximized.
  ///
  /// When `false`, the maximize button is disabled or hidden.
  set maximizable(bool value);
  /// Whether the window can be minimized.
  bool get minimizable;
  /// Sets whether the window can be minimized.
  ///
  /// When `false`, the minimize button is disabled or hidden.
  set minimizable(bool value);
  /// Whether edge snapping is enabled for the window.
  bool get enableSnapping;
  /// Sets whether edge snapping is enabled.
  ///
  /// When `true`, dragging near screen edges triggers snap behavior.
  set enableSnapping(bool value);
  /// Size constraints for the window.
  ///
  /// Defines min/max width and height limits for resizing.
  BoxConstraints get constraints;
  /// Sets the size constraints for the window.
  set constraints(BoxConstraints value);
}
```
