---
title: "Class: CarouselDotIndicator"
description: "A dot indicator for the carousel."
---

```dart
/// A dot indicator for the carousel.
class CarouselDotIndicator extends StatelessWidget {
  /// The item count of the carousel.
  final int itemCount;
  /// The carousel controller.
  final CarouselController controller;
  /// The speed of the value change.
  final Duration speed;
  /// The curve of the value change.
  final Curve curve;
  /// Creates a dot indicator for the carousel.
  const CarouselDotIndicator({super.key, required this.itemCount, required this.controller, this.speed = const Duration(milliseconds: 200), this.curve = Curves.easeInOut});
  Widget build(BuildContext context);
}
```
