---
title: "Class: AbstractNavigationButton"
description: "Reference for AbstractNavigationButton"
---

```dart
abstract class AbstractNavigationButton extends StatefulWidget implements NavigationBarItem {
  final Widget child;
  final Widget? label;
  final double? spacing;
  final AbstractButtonStyle? style;
  final AlignmentGeometry? alignment;
  final bool? enabled;
  final NavigationOverflow overflow;
  final AlignmentGeometry? marginAlignment;
  const AbstractNavigationButton({super.key, this.spacing, this.label, this.style, this.alignment, this.enabled, this.overflow = NavigationOverflow.marquee, this.marginAlignment, required this.child});
  State<AbstractNavigationButton> createState();
}
```
