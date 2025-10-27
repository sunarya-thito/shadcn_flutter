---
title: "Class: NavigationControlData"
description: "Reference for NavigationControlData"
---

```dart
class NavigationControlData {
  final NavigationContainerType containerType;
  final NavigationLabelType parentLabelType;
  final NavigationLabelPosition parentLabelPosition;
  final NavigationLabelSize parentLabelSize;
  final EdgeInsets parentPadding;
  final Axis direction;
  final int? selectedIndex;
  final int childCount;
  final ValueChanged<int> onSelected;
  final bool expanded;
  final double spacing;
  final bool keepCrossAxisSize;
  final bool keepMainAxisSize;
  Axis get labelDirection;
  NavigationControlData({required this.containerType, required this.parentLabelType, required this.parentLabelPosition, required this.parentLabelSize, required this.parentPadding, required this.direction, required this.selectedIndex, required this.onSelected, required this.expanded, required this.childCount, required this.spacing, required this.keepCrossAxisSize, required this.keepMainAxisSize});
  bool operator ==(Object other);
  int get hashCode;
}
```
