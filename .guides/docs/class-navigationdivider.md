---
title: "Class: NavigationDivider"
description: "Reference for NavigationDivider"
---

```dart
class NavigationDivider extends StatelessWidget implements NavigationBarItem {
  final double? thickness;
  final Color? color;
  const NavigationDivider({super.key, this.thickness, this.color});
  bool get selectable;
  Widget build(BuildContext context);
}
```
