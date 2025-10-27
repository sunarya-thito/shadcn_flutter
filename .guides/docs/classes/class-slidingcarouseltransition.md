---
title: "Class: SlidingCarouselTransition"
description: "A sliding carousel transition."
---

```dart
/// A sliding carousel transition.
class SlidingCarouselTransition extends CarouselTransition {
  /// The gap between the carousel items.
  final double gap;
  /// Creates a sliding carousel transition.
  const SlidingCarouselTransition({this.gap = 0});
  List<Widget> layout(BuildContext context, {required double progress, required BoxConstraints constraints, required CarouselAlignment alignment, required Axis direction, required CarouselSizeConstraint sizeConstraint, required double progressedIndex, required int? itemCount, required CarouselItemBuilder itemBuilder, required bool wrap, required bool reverse});
}
```
