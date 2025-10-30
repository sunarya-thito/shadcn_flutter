---
title: "Class: ColorHistoryStorage"
description: "An abstract interface for storing and managing color history."
---

```dart
/// An abstract interface for storing and managing color history.
///
/// [ColorHistoryStorage] defines the contract for color history management,
/// including adding new colors, clearing history, and accessing recent colors.
/// Implementations should provide storage mechanisms (in-memory, persistent, etc.).
abstract class ColorHistoryStorage implements Listenable {
  /// Adds a color to the history.
  ///
  /// Parameters:
  /// - [color]: The color to add to the history.
  void addHistory(Color color);
  /// Replaces the entire color history with a new list.
  ///
  /// Parameters:
  /// - [colors]: The new list of colors to set as the history.
  void setHistory(List<Color> colors);
  /// Clears all colors from the history.
  void clear();
  /// The maximum number of colors that can be stored in the history.
  int get capacity;
  /// The list of recent colors, ordered from most to least recent.
  List<Color> get recentColors;
  /// Finds the [ColorHistoryStorage] in the widget tree.
  static ColorHistoryStorage of(BuildContext context);
}
```
