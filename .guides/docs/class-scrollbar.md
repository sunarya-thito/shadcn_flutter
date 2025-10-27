---
title: "Class: Scrollbar"
description: "Reference for Scrollbar"
---

```dart
class Scrollbar extends StatelessWidget {
  const Scrollbar({super.key, required this.child, this.controller, this.thumbVisibility, this.trackVisibility, this.thickness, this.radius, this.color, this.notificationPredicate, this.interactive, this.scrollbarOrientation});
  final Widget child;
  final ScrollController? controller;
  final bool? thumbVisibility;
  final bool? trackVisibility;
  final double? thickness;
  final Radius? radius;
  final Color? color;
  final bool? interactive;
  final ScrollNotificationPredicate? notificationPredicate;
  final ScrollbarOrientation? scrollbarOrientation;
  Widget build(BuildContext context);
}
```
