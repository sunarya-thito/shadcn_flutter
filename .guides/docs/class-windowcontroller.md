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
  WindowController({required Rect bounds, Rect? maximized, bool minimized = false, bool focused = false, bool closable = true, bool resizable = true, bool draggable = true, bool maximizable = true, bool minimizable = true, bool enableSnapping = true, BoxConstraints constraints = kDefaultWindowConstraints});
  bool get mounted;
  WindowHandle get attachedState;
  Rect get bounds;
  set bounds(Rect value);
  Rect? get maximized;
  set maximized(Rect? value);
  bool get minimized;
  set minimized(bool value);
  bool get alwaysOnTop;
  set alwaysOnTop(bool value);
  bool get closable;
  set closable(bool value);
  bool get resizable;
  set resizable(bool value);
  bool get draggable;
  set draggable(bool value);
  bool get maximizable;
  set maximizable(bool value);
  bool get minimizable;
  set minimizable(bool value);
  bool get enableSnapping;
  set enableSnapping(bool value);
  BoxConstraints get constraints;
  set constraints(BoxConstraints value);
}
```
