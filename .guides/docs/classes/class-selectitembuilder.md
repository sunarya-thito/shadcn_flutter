---
title: "Class: SelectItemBuilder"
description: "Reference for SelectItemBuilder"
---

```dart
class SelectItemBuilder extends SelectItemDelegate {
  final SelectItemWidgetBuilder builder;
  final int? childCount;
  const SelectItemBuilder({required this.builder, this.childCount});
  Widget build(BuildContext context, int index);
  int? get estimatedChildCount;
  bool shouldRebuild(covariant SelectItemBuilder oldDelegate);
}
```
