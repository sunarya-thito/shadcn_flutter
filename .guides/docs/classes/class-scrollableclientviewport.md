---
title: "Class: ScrollableClientViewport"
description: "Reference for ScrollableClientViewport"
---

```dart
class ScrollableClientViewport extends TwoDimensionalViewport {
  final bool overscroll;
  const ScrollableClientViewport({super.key, required super.verticalOffset, required super.verticalAxisDirection, required super.horizontalOffset, required super.horizontalAxisDirection, required super.delegate, required super.mainAxis, super.cacheExtent, super.clipBehavior = Clip.hardEdge, required this.overscroll});
  RenderTwoDimensionalViewport createRenderObject(BuildContext context);
}
```
