---
title: "Class: HoverActivity"
description: "A widget that tracks the hover state of the mouse cursor  and will call the [onHover] with period of [debounceDuration] when the cursor is hovering over the child widget."
---

```dart
/// A widget that tracks the hover state of the mouse cursor
/// and will call the [onHover] with period of [debounceDuration] when the cursor is hovering over the child widget.
class HoverActivity extends StatefulWidget {
  final Widget child;
  final VoidCallback? onHover;
  final VoidCallback? onExit;
  final VoidCallback? onEnter;
  final Duration? debounceDuration;
  final HitTestBehavior? hitTestBehavior;
  const HoverActivity({super.key, required this.child, this.onHover, this.onExit, this.onEnter, this.hitTestBehavior, this.debounceDuration});
  State<HoverActivity> createState();
}
```
