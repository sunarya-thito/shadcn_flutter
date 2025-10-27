---
title: "Class: NavigationButton"
description: "Reference for NavigationButton"
---

```dart
class NavigationButton extends AbstractNavigationButton {
  final VoidCallback? onPressed;
  const NavigationButton({super.key, this.onPressed, super.label, super.spacing, super.style, super.alignment, super.enabled, super.overflow, super.marginAlignment, required super.child});
  bool get selectable;
  State<AbstractNavigationButton> createState();
}
```
