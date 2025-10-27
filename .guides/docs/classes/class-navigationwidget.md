---
title: "Class: NavigationWidget"
description: "Reference for NavigationWidget"
---

```dart
class NavigationWidget extends StatelessWidget implements NavigationBarItem {
  final int? index;
  final Widget? child;
  final NavigationWidgetBuilder? builder;
  const NavigationWidget({super.key, this.index, required Widget this.child});
  const NavigationWidget.builder({super.key, this.index, required NavigationWidgetBuilder this.builder});
  bool get selectable;
  Widget build(BuildContext context);
}
```
