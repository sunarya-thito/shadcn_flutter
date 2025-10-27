---
title: "Class: MenuGap"
description: "Reference for MenuGap"
---

```dart
class MenuGap extends StatelessWidget implements MenuItem {
  final double size;
  const MenuGap(this.size, {super.key});
  Widget build(BuildContext context);
  bool get hasLeading;
  PopoverController? get popoverController;
}
```
