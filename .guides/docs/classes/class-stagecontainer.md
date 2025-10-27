---
title: "Class: StageContainer"
description: "Reference for StageContainer"
---

```dart
class StageContainer extends StatelessWidget {
  final StageBreakpoint breakpoint;
  final Widget Function(BuildContext context, EdgeInsets padding) builder;
  final EdgeInsets padding;
  const StageContainer({super.key, this.breakpoint = StageBreakpoint.defaultBreakpoints, required this.builder, this.padding = const EdgeInsets.symmetric(horizontal: 72)});
  Widget build(BuildContext context);
}
```
