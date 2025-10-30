---
title: "Class: ToastEntry"
description: "Configuration for a single toast notification."
---

```dart
/// Configuration for a single toast notification.
///
/// Encapsulates all properties needed to display and manage a toast,
/// including builder, location, timing, and dismissal behavior.
class ToastEntry {
  /// Builder function to create the toast widget.
  final ToastBuilder builder;
  /// Position where the toast should appear.
  final ToastLocation location;
  /// Whether the toast can be dismissed by user interaction.
  ///
  /// Defaults to true. When false, toast only closes after duration expires.
  final bool dismissible;
  /// Animation curve for entry/exit transitions.
  final Curve curve;
  /// Duration for entry/exit animations.
  final Duration duration;
  /// Captured theme data to apply to the toast.
  final CapturedThemes? themes;
  /// Captured inherited widget data to apply to the toast.
  final CapturedData? data;
  /// Callback invoked when toast is closed.
  final VoidCallback? onClosed;
  /// How long the toast remains visible before auto-dismissing.
  ///
  /// Defaults to 5 seconds. If null, toast remains indefinitely.
  final Duration? showDuration;
  /// Creates a toast entry configuration.
  ToastEntry({required this.builder, required this.location, this.dismissible = true, this.curve = Curves.easeInOut, this.duration = kDefaultDuration, required this.themes, required this.data, this.onClosed, this.showDuration = const Duration(seconds: 5)});
}
```
