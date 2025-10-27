---
title: "Class: TabContainerData"
description: "Reference for TabContainerData"
---

```dart
class TabContainerData {
  static TabContainerData of(BuildContext context);
  final int index;
  final int selected;
  final ValueChanged<int>? onSelect;
  final TabChildBuilder childBuilder;
  TabContainerData({required this.index, required this.selected, required this.onSelect, required this.childBuilder});
  bool operator ==(Object other);
  int get hashCode;
}
```
