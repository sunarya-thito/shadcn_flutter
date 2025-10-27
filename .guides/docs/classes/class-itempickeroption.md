---
title: "Class: ItemPickerOption"
description: "Reference for ItemPickerOption"
---

```dart
class ItemPickerOption<T> extends StatelessWidget {
  final T value;
  final Widget? label;
  final Widget child;
  final AbstractButtonStyle? style;
  final AbstractButtonStyle? selectedStyle;
  const ItemPickerOption({super.key, required this.value, required this.child, this.style, this.selectedStyle, this.label});
  Widget build(BuildContext context);
}
```
