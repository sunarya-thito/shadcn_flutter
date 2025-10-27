---
title: "Class: MenuLabel"
description: "Reference for MenuLabel"
---

```dart
class MenuLabel extends StatelessWidget implements MenuItem {
  final Widget child;
  final Widget? trailing;
  final Widget? leading;
  const MenuLabel({super.key, required this.child, this.trailing, this.leading});
  bool get hasLeading;
  PopoverController? get popoverController;
  Widget build(BuildContext context);
}
```
