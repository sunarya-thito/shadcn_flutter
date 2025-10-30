---
title: "Enum: TriggerStage"
description: "Lifecycle stages of a refresh trigger."
---

```dart
/// Lifecycle stages of a refresh trigger.
///
/// Represents the different states a refresh indicator can be in:
/// - [idle]: No refresh in progress, waiting for user interaction
/// - [pulling]: User is pulling but hasn't reached min extent
/// - [refreshing]: Refresh callback is executing
/// - [completed]: Refresh completed, showing completion state
enum TriggerStage {
  /// Idle state, no refresh in progress.
  idle,
  /// Pulling state, user is dragging the indicator.
  pulling,
  /// Refreshing state, async refresh operation is executing.
  refreshing,
  /// Completed state, refresh finished successfully.
  completed,
}
```
