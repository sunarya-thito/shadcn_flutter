---
title: "Class: MenuDivider"
description: "Visual divider between menu items."
---

```dart
/// Visual divider between menu items.
///
/// Renders a horizontal or vertical line to separate groups of menu items.
/// Automatically adapts direction based on the parent menu's orientation.
///
/// Example:
/// ```dart
/// MenuGroup(
///   children: [
///     MenuButton(child: Text('Cut')),
///     MenuButton(child: Text('Copy')),
///     MenuDivider(), // Separator
///     MenuButton(child: Text('Paste')),
///   ],
/// )
/// ```
class MenuDivider extends StatelessWidget implements MenuItem {
  /// Creates a menu divider.
  const MenuDivider({super.key});
  Widget build(BuildContext context);
  bool get hasLeading;
  PopoverController? get popoverController;
}
```
