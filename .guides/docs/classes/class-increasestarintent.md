---
title: "Class: IncreaseStarIntent"
description: "Intent for increasing the star rating value via keyboard shortcuts."
---

```dart
/// Intent for increasing the star rating value via keyboard shortcuts.
///
/// Used with Flutter's shortcuts and actions system to handle keyboard
/// input for incrementing the rating. Typically bound to right arrow key.
class IncreaseStarIntent extends Intent {
  /// The step size to increase the rating by.
  final double step;
  /// Creates an [IncreaseStarIntent].
  const IncreaseStarIntent(this.step);
}
```
