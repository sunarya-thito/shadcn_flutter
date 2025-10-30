---
title: "Class: Hover"
description: "Reference for Hover"
---

```dart
class Hover extends StatefulWidget {
  final Widget child;
  final void Function(bool hovered) onHover;
  final Duration? waitDuration;
  final Duration? minDuration;
  final Duration? showDuration;
  final HitTestBehavior? hitTestBehavior;
  const Hover({super.key, required this.child, required this.onHover, this.waitDuration, this.minDuration, this.showDuration, this.hitTestBehavior});
  State<Hover> createState();
}
```
