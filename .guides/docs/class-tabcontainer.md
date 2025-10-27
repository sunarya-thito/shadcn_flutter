---
title: "Class: TabContainer"
description: "Reference for TabContainer"
---

```dart
class TabContainer extends StatelessWidget {
  final int selected;
  final ValueChanged<int>? onSelect;
  final List<TabChild> children;
  final TabBuilder? builder;
  final TabChildBuilder? childBuilder;
  const TabContainer({super.key, required this.selected, required this.onSelect, required this.children, this.builder, this.childBuilder});
  Widget build(BuildContext context);
}
```
