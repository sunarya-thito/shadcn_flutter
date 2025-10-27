---
title: "Class: NavigationMenuState"
description: "Reference for NavigationMenuState"
---

```dart
class NavigationMenuState extends State<NavigationMenu> {
  static const Duration kDebounceDuration = Duration(milliseconds: 200);
  bool isActive(NavigationMenuItemState item);
  void dispose();
  NavigationMenuItemState? findByWidget(Widget widget);
  Widget buildContent(int index);
  void close();
  Widget buildPopover(BuildContext context);
  EdgeInsets? requestMargin();
  Widget build(BuildContext context);
}
```
