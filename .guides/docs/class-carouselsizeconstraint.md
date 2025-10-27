---
title: "Class: CarouselSizeConstraint"
description: "Size constraint for the carousel."
---

```dart
/// Size constraint for the carousel.
abstract class CarouselSizeConstraint {
  /// Creates a carousel size constraint.
  const CarouselSizeConstraint();
  /// Creates a fixed carousel size constraint.
  factory CarouselSizeConstraint.fixed(double size);
  /// Creates a fractional carousel size constraint.
  factory CarouselSizeConstraint.fractional(double fraction);
}
```
