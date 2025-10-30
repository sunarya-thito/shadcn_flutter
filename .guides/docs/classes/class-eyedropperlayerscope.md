---
title: "Class: EyeDropperLayerScope"
description: "Provides access to eye dropper functionality in the widget tree."
---

```dart
/// Provides access to eye dropper functionality in the widget tree.
///
/// [EyeDropperLayerScope] is an abstract interface that allows widgets to
/// request color picking functionality from an ancestor [EyeDropperLayer].
/// Use the static methods to find the scope in the widget tree.
abstract class EyeDropperLayerScope {
  /// Prompts the user to pick a color from the screen.
  ///
  /// Parameters:
  /// - [historyStorage]: Optional storage for color picking history.
  ///
  /// Returns: A [Future] that completes with the picked color, or null if cancelled.
  Future<Color?> promptPickColor([ColorHistoryStorage? historyStorage]);
  /// Finds the root [EyeDropperLayerScope] in the widget tree.
  ///
  /// Searches up the tree to find the topmost eye dropper scope.
  static EyeDropperLayerScope findRoot(BuildContext context);
  /// Finds the nearest [EyeDropperLayerScope] in the widget tree.
  ///
  /// Searches up the tree to find the closest eye dropper scope.
  static EyeDropperLayerScope find(BuildContext context);
}
```
