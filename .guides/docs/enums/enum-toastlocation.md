---
title: "Enum: ToastLocation"
description: "Screen position enumeration for toast notification placement."
---

```dart
/// Screen position enumeration for toast notification placement.
///
/// ToastLocation defines six standard positions around the screen edges where
/// toast notifications can appear. Each location includes alignment information
/// for both the toast container and the stacking direction of multiple toasts.
///
/// The enum ensures consistent positioning behavior across different screen
/// sizes and orientations while providing intuitive placement options for
/// various UI patterns and user experience requirements.
enum ToastLocation {
  /// Top-left corner with downward stacking.
  ///
  /// Toasts appear in the top-left area with new toasts stacking below existing ones.
  /// Suitable for notifications that shouldn't interfere with main content areas.
  topLeft,
  /// Top-center with downward stacking.
  ///
  /// Toasts appear centered at the top with new toasts stacking below existing ones.
  /// Ideal for important notifications that need prominent visibility.
  topCenter,
  /// Top-right corner with downward stacking.
  ///
  /// Toasts appear in the top-right area with new toasts stacking below existing ones.
  /// Common choice for status updates and non-critical notifications.
  topRight,
  /// Bottom-left corner with upward stacking.
  ///
  /// Toasts appear in the bottom-left area with new toasts stacking above existing ones.
  /// Useful for contextual actions and secondary notifications.
  bottomLeft,
  /// Bottom-center with upward stacking.
  ///
  /// Toasts appear centered at the bottom with new toasts stacking above existing ones.
  /// Popular for confirmation messages and user action feedback.
  bottomCenter,
  /// Bottom-right corner with upward stacking.
  ///
  /// Toasts appear in the bottom-right area with new toasts stacking above existing ones.
  /// Default location providing unobtrusive notification placement.
  bottomRight,
}
```
