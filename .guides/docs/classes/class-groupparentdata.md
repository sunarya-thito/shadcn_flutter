---
title: "Class: GroupParentData"
description: "Parent data for children of [GroupWidget]."
---

```dart
/// Parent data for children of [GroupWidget].
///
/// Stores positioning and sizing information for each child widget within
/// a [GroupWidget]. These values are set by [GroupPositioned].
class GroupParentData extends ContainerBoxParentData<RenderBox> {
  /// Distance from the top edge of the group.
  double? top;
  /// Distance from the left edge of the group.
  double? left;
  /// Distance from the right edge of the group.
  double? right;
  /// Distance from the bottom edge of the group.
  double? bottom;
  /// Explicit width of the child.
  double? width;
  /// Explicit height of the child.
  double? height;
}
```
