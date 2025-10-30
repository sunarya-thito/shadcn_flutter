---
title: "Class: MenuGap"
description: "Spacing gap between menu items."
---

```dart
/// Spacing gap between menu items.
///
/// Creates empty vertical or horizontal space within a menu, based on
/// the menu's direction. Useful for visually grouping related items.
class MenuGap extends StatelessWidget implements MenuItem {
  /// Size of the gap in logical pixels.
  final double size;
  /// Creates a menu gap.
  ///
  /// Parameters:
  /// - [size] (double, required): Gap size in logical pixels
  const MenuGap(this.size, {super.key});
  Widget build(BuildContext context);
  bool get hasLeading;
  PopoverController? get popoverController;
}
```
