---
title: "Class: NavigationControlData"
description: "Data class containing navigation control configuration and state."
---

```dart
/// Data class containing navigation control configuration and state.
///
/// Manages layout, styling, and interaction settings for navigation
/// containers and their children. Used internally to coordinate
/// behavior across navigation items.
class NavigationControlData {
  /// Type of navigation container (bar, rail, etc.).
  final NavigationContainerType containerType;
  /// Label display type from parent container.
  final NavigationLabelType parentLabelType;
  /// Label position relative to icon from parent.
  final NavigationLabelPosition parentLabelPosition;
  /// Label size variant from parent.
  final NavigationLabelSize parentLabelSize;
  /// Padding applied by parent container.
  final EdgeInsets parentPadding;
  /// Layout direction (horizontal or vertical).
  final Axis direction;
  /// Currently selected item index (null if none selected).
  final int? selectedIndex;
  /// Total number of child items.
  final int childCount;
  /// Callback when an item is selected.
  final ValueChanged<int> onSelected;
  /// Whether the navigation is expanded to fill available space.
  final bool expanded;
  /// Spacing between navigation items.
  final double spacing;
  /// Whether to maintain cross-axis size constraints.
  final bool keepCrossAxisSize;
  /// Whether to maintain main-axis size constraints.
  final bool keepMainAxisSize;
  /// Computed label direction based on parent label position.
  ///
  /// Returns horizontal for start/end positions, vertical for top/bottom.
  Axis get labelDirection;
  /// Creates navigation control data.
  ///
  /// Parameters:
  /// - [containerType] (NavigationContainerType, required): Container type
  /// - [parentLabelType] (NavigationLabelType, required): Label display type
  /// - [parentLabelPosition] (NavigationLabelPosition, required): Label position
  /// - [parentLabelSize] (NavigationLabelSize, required): Label size variant
  /// - [parentPadding] (EdgeInsets, required): Container padding
  /// - [direction] (Axis, required): Layout direction
  /// - [selectedIndex] (int?): Selected item index
  /// - [onSelected] (`ValueChanged<int>`, required): Selection callback
  /// - [expanded] (bool, required): Whether expanded
  /// - [childCount] (int, required): Number of children
  /// - [spacing] (double, required): Item spacing
  /// - [keepCrossAxisSize] (bool, required): Maintain cross-axis size
  /// - [keepMainAxisSize] (bool, required): Maintain main-axis size
  NavigationControlData({required this.containerType, required this.parentLabelType, required this.parentLabelPosition, required this.parentLabelSize, required this.parentPadding, required this.direction, required this.selectedIndex, required this.onSelected, required this.expanded, required this.childCount, required this.spacing, required this.keepCrossAxisSize, required this.keepMainAxisSize});
  bool operator ==(Object other);
  int get hashCode;
}
```
