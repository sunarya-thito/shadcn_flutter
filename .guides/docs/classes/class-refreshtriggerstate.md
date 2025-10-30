---
title: "Class: RefreshTriggerState"
description: "State for the refresh trigger widget."
---

```dart
/// State for the refresh trigger widget.
///
/// Manages the refresh lifecycle, gesture detection, and animation coordination
/// for pull-to-refresh functionality.
class RefreshTriggerState extends State<RefreshTrigger> with SingleTickerProviderStateMixin {
  void didChangeDependencies();
  void didUpdateWidget(RefreshTrigger oldWidget);
  /// Triggers a refresh programmatically.
  ///
  /// Initiates the refresh animation and invokes the provided callback or
  /// widget's [onRefresh] callback. Can be called from parent widgets to
  /// trigger refresh without user gesture.
  ///
  /// Parameters:
  /// - [refreshCallback]: Optional callback to use instead of widget's onRefresh
  ///
  /// Returns a Future that completes when refresh finishes.
  Future<void> refresh([FutureVoidCallback? refreshCallback]);
  Widget build(BuildContext context);
}
```
