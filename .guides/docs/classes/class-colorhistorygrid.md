---
title: "Class: ColorHistoryGrid"
description: "A grid widget that displays a history of previously used colors."
---

```dart
/// A grid widget that displays a history of previously used colors.
///
/// [ColorHistoryGrid] presents colors from a [ColorHistoryStorage] in a grid
/// layout, allowing users to quickly reuse recently selected colors. The grid
/// can highlight the currently selected color and supports custom layouts.
///
/// Example:
/// ```dart
/// ColorHistoryGrid(
///   storage: myColorHistory,
///   onColorPicked: (color) {
///     print('Selected from history: $color');
///   },
///   crossAxisCount: 8,
/// )
/// ```
class ColorHistoryGrid extends StatelessWidget {
  /// The storage containing the color history.
  final ColorHistoryStorage storage;
  /// Called when a color from the history is picked.
  final ValueChanged<Color>? onColorPicked;
  /// Spacing between grid items.
  final double? spacing;
  /// Number of columns in the grid.
  final int crossAxisCount;
  /// The currently selected color to highlight.
  final Color? selectedColor;
  /// Creates a [ColorHistoryGrid].
  const ColorHistoryGrid({super.key, required this.storage, this.onColorPicked, this.spacing, this.crossAxisCount = 10, this.selectedColor});
  Widget build(BuildContext context);
}
```
