---
title: "Enum: ExpandMode"
description: "Expansion behavior modes for toast notification stacks."
---

```dart
/// Expansion behavior modes for toast notification stacks.
///
/// ExpandMode controls when and how stacked toast notifications expand to
/// show multiple entries simultaneously. Different modes provide various
/// user interaction patterns for managing multiple notifications.
enum ExpandMode {
  /// Toast stack is always expanded, showing all notifications simultaneously.
  ///
  /// All stacked toasts remain visible and fully sized at all times.
  /// Provides maximum information density but requires more screen space.
  alwaysExpanded,
  /// Toast stack expands when mouse cursor hovers over the notification area.
  ///
  /// Default behavior that provides on-demand access to stacked notifications
  /// through hover interaction. Collapses automatically after hover ends.
  expandOnHover,
  /// Toast stack expands when user taps or clicks on the notification area.
  ///
  /// Provides touch-friendly interaction for mobile devices and touch screens.
  /// Requires explicit user action to reveal stacked notifications.
  expandOnTap,
  /// Toast expansion is completely disabled.
  ///
  /// Only the topmost toast is ever visible, with background toasts remaining
  /// collapsed. Provides minimal screen footprint at the cost of stack visibility.
  disabled,
}
```
