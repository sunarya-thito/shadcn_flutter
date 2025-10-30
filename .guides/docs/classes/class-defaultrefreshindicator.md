---
title: "Class: DefaultRefreshIndicator"
description: "Default refresh indicator widget with platform-appropriate styling."
---

```dart
/// Default refresh indicator widget with platform-appropriate styling.
///
/// Displays a circular progress indicator that responds to pull gestures
/// and animates during the refresh lifecycle stages.
class DefaultRefreshIndicator extends StatefulWidget {
  /// Current refresh trigger stage.
  final RefreshTriggerStage stage;
  /// Creates a default refresh indicator.
  const DefaultRefreshIndicator({super.key, required this.stage});
  State<DefaultRefreshIndicator> createState();
}
```
