---
title: "Class: RefreshTriggerStage"
description: "Immutable snapshot of refresh trigger state."
---

```dart
/// Immutable snapshot of refresh trigger state.
///
/// Provides information about the current refresh stage and pull extent
/// to indicator builders for rendering appropriate UI.
class RefreshTriggerStage {
  /// Current stage of the refresh lifecycle.
  final TriggerStage stage;
  /// Animated pull extent value.
  ///
  /// Range depends on min/max extent configuration. Use [extentValue] for
  /// current numeric value.
  final Animation<double> extent;
  /// Direction of the pull gesture.
  final Axis direction;
  /// Whether the pull direction is reversed.
  final bool reverse;
  /// Creates a refresh trigger stage snapshot.
  const RefreshTriggerStage(this.stage, this.extent, this.direction, this.reverse);
  /// Current numeric value of the pull extent.
  ///
  /// Convenience getter for [extent.value].
  double get extentValue;
}
```
