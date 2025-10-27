---
title: "Class: CarouselTheme"
description: "Theme data for [Carousel]."
---

```dart
/// Theme data for [Carousel].
class CarouselTheme {
  final CarouselAlignment? alignment;
  final Axis? direction;
  final bool? wrap;
  final bool? pauseOnHover;
  final Duration? autoplaySpeed;
  final bool? draggable;
  final Duration? speed;
  final Curve? curve;
  const CarouselTheme({this.alignment, this.direction, this.wrap, this.pauseOnHover, this.autoplaySpeed, this.draggable, this.speed, this.curve});
  CarouselTheme copyWith({ValueGetter<CarouselAlignment?>? alignment, ValueGetter<Axis?>? direction, ValueGetter<bool?>? wrap, ValueGetter<bool?>? pauseOnHover, ValueGetter<Duration?>? autoplaySpeed, ValueGetter<bool?>? draggable, ValueGetter<Duration?>? speed, ValueGetter<Curve?>? curve});
  bool operator ==(Object other);
  int get hashCode;
}
```
