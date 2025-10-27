---
title: "Class: CarouselTransition"
description: "A carousel layout."
---

```dart
/// A carousel layout.
abstract class CarouselTransition {
  /// Creates a carousel layout.
  const CarouselTransition();
  /// Creates a sliding carousel layout.
  factory CarouselTransition.sliding({double gap});
  /// Creates a fading carousel layout.
  factory CarouselTransition.fading();
  /// Layouts the carousel items.
  /// * [context] is the build context.
  /// * [progress] is the progress of the carousel.
  /// * [constraints] is the constraints of the carousel.
  /// * [alignment] is the alignment of the carousel.
  /// * [direction] is the direction of the carousel.
  /// * [sizeConstraint] is the size constraint of the carousel.
  /// * [progressedIndex] is the progressed index of the carousel.
  /// * [itemCount] is the item count of the carousel.
  /// * [itemBuilder] is the item builder of the carousel.
  /// * [wrap] is whether the carousel should wrap.
  /// * [reverse] is whether the carousel should reverse.
  List<Widget> layout(BuildContext context, {required double progress, required BoxConstraints constraints, required CarouselAlignment alignment, required Axis direction, required CarouselSizeConstraint sizeConstraint, required double progressedIndex, required int? itemCount, required CarouselItemBuilder itemBuilder, required bool wrap, required bool reverse});
}
```
