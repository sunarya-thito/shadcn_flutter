---
title: "Class: NavigationGap"
description: "Reference for NavigationGap"
---

```dart
class NavigationGap extends StatelessWidget implements NavigationBarItem {
  final double gap;
  const NavigationGap(this.gap, {super.key});
  bool get selectable;
  Widget buildBox(BuildContext context);
  Widget buildSliver(BuildContext context);
  Widget build(BuildContext context);
}
```
