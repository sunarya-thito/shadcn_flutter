---
title: "Class: MenuItem"
description: "Abstract base class for menu item widgets."
---

```dart
/// Abstract base class for menu item widgets.
///
/// All menu items (buttons, checkboxes, radio buttons, dividers, etc.) must
/// implement this interface. Menu items can be placed within menu groups and
/// support features like leading icons and popover controllers.
///
/// See also:
/// - [MenuButton], clickable menu item
/// - [MenuCheckbox], checkbox menu item
/// - [MenuRadio], radio button menu item
/// - [MenuDivider], divider between menu items
abstract class MenuItem extends Widget {
  /// Creates a menu item.
  const MenuItem({super.key});
  /// Whether this menu item has a leading widget (icon, checkbox indicator, etc.).
  bool get hasLeading;
  /// Optional popover controller for submenu functionality.
  PopoverController? get popoverController;
}
```
