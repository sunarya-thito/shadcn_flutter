---
title: "Class: MenuRadioGroup"
description: "Reference for MenuRadioGroup"
---

```dart
class MenuRadioGroup<T> extends StatelessWidget implements MenuItem {
  final T? value;
  final ContextedValueChanged<T>? onChanged;
  final List<Widget> children;
  const MenuRadioGroup({super.key, required this.value, required this.onChanged, required this.children});
  bool get hasLeading;
  PopoverController? get popoverController;
  Widget build(BuildContext context);
}
```
