---
title: "Class: DirectionalMenuFocusIntent"
description: "Intent for directional focus traversal within menus."
---

```dart
/// Intent for directional focus traversal within menus.
///
/// Used for arrow key navigation (up, down, left, right) within menu structures.
class DirectionalMenuFocusIntent extends Intent {
  /// Direction of focus traversal.
  final TraversalDirection direction;
  /// Creates a directional menu focus intent.
  ///
  /// Parameters:
  /// - [direction] (TraversalDirection, required): Traversal direction
  const DirectionalMenuFocusIntent(this.direction);
}
```
