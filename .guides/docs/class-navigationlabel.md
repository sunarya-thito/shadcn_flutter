---
title: "Class: NavigationLabel"
description: "Reference for NavigationLabel"
---

```dart
class NavigationLabel extends StatelessWidget implements NavigationBarItem {
  final Widget child;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final NavigationOverflow overflow;
  final bool floating;
  final bool pinned;
  const NavigationLabel({super.key, this.alignment, this.floating = false, this.pinned = false, this.overflow = NavigationOverflow.clip, this.padding, required this.child});
  bool get selectable;
  Widget build(BuildContext context);
  Widget buildChild(BuildContext context, NavigationControlData? data);
  Widget buildBox(BuildContext context, NavigationControlData? data);
  Widget buildSliver(BuildContext context, NavigationControlData? data);
}
```
