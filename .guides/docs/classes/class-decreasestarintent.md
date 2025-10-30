---
title: "Class: DecreaseStarIntent"
description: "Intent for decreasing the star rating value via keyboard shortcuts."
---

```dart
/// Intent for decreasing the star rating value via keyboard shortcuts.
///
/// Used with Flutter's shortcuts and actions system to handle keyboard
/// input for decrementing the rating. Typically bound to left arrow key.
class DecreaseStarIntent extends Intent {
  /// The step size to decrease the rating by.
  final double step;
  /// Creates a [DecreaseStarIntent].
  const DecreaseStarIntent(this.step);
}
```
