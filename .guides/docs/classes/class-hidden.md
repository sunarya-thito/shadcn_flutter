---
title: "Class: Hidden"
description: "Reference for Hidden"
---

```dart
class Hidden extends StatelessWidget {
  final bool hidden;
  final Widget child;
  final Axis? direction;
  final bool? reverse;
  final Duration? duration;
  final Curve? curve;
  final bool? keepCrossAxisSize;
  final bool? keepMainAxisSize;
  const Hidden({super.key, required this.hidden, required this.child, this.direction, this.duration, this.curve, this.reverse, this.keepCrossAxisSize, this.keepMainAxisSize});
  Widget build(BuildContext context);
}
```
