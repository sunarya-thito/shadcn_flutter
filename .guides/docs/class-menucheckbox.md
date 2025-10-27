---
title: "Class: MenuCheckbox"
description: "Reference for MenuCheckbox"
---

```dart
class MenuCheckbox extends StatelessWidget implements MenuItem {
  final bool value;
  final ContextedValueChanged<bool>? onChanged;
  final Widget child;
  final Widget? trailing;
  final bool enabled;
  final bool autoClose;
  const MenuCheckbox({super.key, this.value = false, this.onChanged, required this.child, this.trailing, this.enabled = true, this.autoClose = true});
  bool get hasLeading;
  PopoverController? get popoverController;
  Widget build(BuildContext context);
}
```
