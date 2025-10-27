---
title: "Class: SelectItemList"
description: "Reference for SelectItemList"
---

```dart
class SelectItemList extends SelectItemDelegate {
  final List<Widget> children;
  const SelectItemList({required this.children});
  Widget build(BuildContext context, int index);
  int get estimatedChildCount;
  bool shouldRebuild(covariant SelectItemList oldDelegate);
}
```
