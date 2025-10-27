---
title: "Class: StepNumberData"
description: "Data class providing step index context to descendant widgets."
---

```dart
/// Data class providing step index context to descendant widgets.
///
/// Used internally by the stepper to pass the current step index
/// to child widgets like [StepNumber]. Accessible via [Data.maybeOf].
///
/// Example:
/// ```dart
/// final stepData = Data.maybeOf<StepNumberData>(context);
/// final stepIndex = stepData?.stepIndex ?? 0;
/// ```
class StepNumberData {
  /// Zero-based index of the step.
  final int stepIndex;
  /// Creates [StepNumberData].
  const StepNumberData({required this.stepIndex});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
