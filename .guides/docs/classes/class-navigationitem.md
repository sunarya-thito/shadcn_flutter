---
title: "Class: NavigationItem"
description: "Reference for NavigationItem"
---

```dart
class NavigationItem extends AbstractNavigationButton {
  final AbstractButtonStyle? selectedStyle;
  final bool? selected;
  final ValueChanged<bool>? onChanged;
  final int? index;
  const NavigationItem({super.key, this.selectedStyle, this.selected, this.onChanged, super.label, super.spacing, super.style, super.alignment, this.index, super.enabled, super.overflow, super.marginAlignment, required super.child});
  bool get selectable;
  State<AbstractNavigationButton> createState();
}
```
