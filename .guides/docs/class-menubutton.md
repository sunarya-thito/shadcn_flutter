---
title: "Class: MenuButton"
description: "Reference for MenuButton"
---

```dart
class MenuButton extends StatefulWidget implements MenuItem {
  final Widget child;
  final List<MenuItem>? subMenu;
  final ContextedCallback? onPressed;
  final Widget? trailing;
  final Widget? leading;
  final bool enabled;
  final FocusNode? focusNode;
  final bool autoClose;
  final PopoverController? popoverController;
  const MenuButton({super.key, required this.child, this.subMenu, this.onPressed, this.trailing, this.leading, this.enabled = true, this.focusNode, this.autoClose = true, this.popoverController});
  State<MenuButton> createState();
  bool get hasLeading;
}
```
