---
title: "Class: ToastOverlay"
description: "Abstract interface for controlling individual toast notification instances."
---

```dart
/// Abstract interface for controlling individual toast notification instances.
///
/// ToastOverlay provides methods for managing the lifecycle and state of
/// individual toast notifications after they have been displayed. Instances
/// are returned by [showToast] and passed to [ToastBuilder] functions.
///
/// The interface allows checking the current display state and programmatically
/// dismissing toast notifications, enabling responsive user interactions and
/// proper cleanup when needed.
abstract class ToastOverlay {
  /// Whether the toast notification is currently being displayed.
  ///
  /// Type: `bool`. Returns true if the toast is visible or in the process
  /// of animating in/out, false if it has been dismissed or closed.
  bool get isShowing;
  /// Programmatically dismisses the toast notification.
  ///
  /// Triggers the dismissal animation and removes the toast from the display
  /// stack. This method can be called multiple times safely - subsequent
  /// calls after dismissal will have no effect.
  ///
  /// Example:
  /// ```dart
  /// final toast = showToast(context: context, builder: (context, overlay) {
  ///   return AlertCard(
  ///     title: 'Auto-close',
  ///     trailing: IconButton(
  ///       icon: Icon(Icons.close),
  ///       onPressed: overlay.close,
  ///     ),
  ///   );
  /// });
  /// 
  /// // Close programmatically after delay
  /// Timer(Duration(seconds: 2), toast.close);
  /// ```
  void close();
}
```
