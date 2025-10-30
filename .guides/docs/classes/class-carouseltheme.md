---
title: "Class: CarouselTheme"
description: "Theme data for [Carousel]."
---

```dart
/// Theme data for [Carousel].
class CarouselTheme {
  /// The alignment of carousel items.
  final CarouselAlignment? alignment;
  /// The scroll direction (horizontal or vertical).
  final Axis? direction;
  /// Whether to wrap around to the beginning after reaching the end.
  final bool? wrap;
  /// Whether to pause autoplay on hover.
  final bool? pauseOnHover;
  /// The duration between automatic slides.
  final Duration? autoplaySpeed;
  /// Whether the carousel can be dragged.
  final bool? draggable;
  /// The transition animation speed.
  final Duration? speed;
  /// The transition animation curve.
  final Curve? curve;
  /// Creates a carousel theme.
  const CarouselTheme({this.alignment, this.direction, this.wrap, this.pauseOnHover, this.autoplaySpeed, this.draggable, this.speed, this.curve});
  /// Creates a copy of this theme with the given fields replaced.
  CarouselTheme copyWith({ValueGetter<CarouselAlignment?>? alignment, ValueGetter<Axis?>? direction, ValueGetter<bool?>? wrap, ValueGetter<bool?>? pauseOnHover, ValueGetter<Duration?>? autoplaySpeed, ValueGetter<bool?>? draggable, ValueGetter<Duration?>? speed, ValueGetter<Curve?>? curve});
  bool operator ==(Object other);
  int get hashCode;
}
```
