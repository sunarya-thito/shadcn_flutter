---
title: "Class: GroupPositioned"
description: "Reference for GroupPositioned"
---

```dart
class GroupPositioned extends ParentDataWidget<GroupParentData> {
  const GroupPositioned({super.key, this.top, this.left, this.right, this.bottom, this.width, this.height, required super.child});
  const GroupPositioned.fill({super.key, this.top = 0, this.left = 0, this.right = 0, this.bottom = 0, this.width, this.height, required super.child});
  GroupPositioned.fromRect({super.key, required Rect rect, required super.child});
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;
  void applyParentData(RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
}
```
