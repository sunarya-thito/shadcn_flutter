---
title: "Class: TabContainerData"
description: "Internal data class holding tab container state and callbacks."
---

```dart
/// Internal data class holding tab container state and callbacks.
///
/// Provides context information to child tabs including the current
/// selection state, tab index, and selection callback. Used internally
/// by the tab system to coordinate between container and children.
///
/// Accessed via [TabContainerData.of] from within tab child widgets.
class TabContainerData {
  /// Retrieves the nearest [TabContainerData] from the widget tree.
  ///
  /// Throws an assertion error if no [TabContainer] is found in the
  /// ancestor chain, as tab children must be descendants of a tab container.
  ///
  /// Parameters:
  /// - [context]: Build context to search from
  ///
  /// Returns the container data.
  static TabContainerData of(BuildContext context);
  /// The index of this tab within the container (0-indexed).
  final int index;
  /// The index of the currently selected tab.
  final int selected;
  /// Callback to invoke when this tab should be selected.
  ///
  /// Called with the tab's index when the user interacts with the tab.
  final ValueChanged<int>? onSelect;
  /// Builder function for wrapping tab child content.
  ///
  /// Applies consistent styling or layout to tab children.
  final TabChildBuilder childBuilder;
  /// Creates tab container data.
  ///
  /// Parameters:
  /// - [index]: This tab's index (required)
  /// - [selected]: Currently selected tab index (required)
  /// - [onSelect]: Selection callback (required)
  /// - [childBuilder]: Child wrapping builder (required)
  TabContainerData({required this.index, required this.selected, required this.onSelect, required this.childBuilder});
  bool operator ==(Object other);
  int get hashCode;
}
```
