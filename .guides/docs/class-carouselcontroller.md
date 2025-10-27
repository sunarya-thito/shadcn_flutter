---
title: "Class: CarouselController"
description: "A controller for the carousel."
---

```dart
/// A controller for the carousel.
class CarouselController extends Listenable {
  /// Whether the carousel should animate.
  bool get shouldAnimate;
  /// The current value of the controller.
  double get value;
  /// Jumps to the next item.
  void next();
  /// Jumps to the previous item.
  void previous();
  /// Animates to the next item.
  void animateNext(Duration duration, [Curve curve = Curves.easeInOut]);
  /// Animates to the previous item.
  void animatePrevious(Duration duration, [Curve curve = Curves.easeInOut]);
  /// Snaps the current value to the nearest integer.
  void snap();
  /// Animates the current value to the nearest integer.
  void animateSnap(Duration duration, [Curve curve = Curves.easeInOut]);
  /// Jumps to the specified value.
  void jumpTo(double value);
  /// Animates to the specified value.
  void animateTo(double value, Duration duration, [Curve curve = Curves.linear]);
  /// Animates to the specified value.
  double getCurrentIndex(int? itemCount);
  /// Animates to the specified value.
  void tick(Duration delta);
  void addListener(VoidCallback listener);
  void removeListener(VoidCallback listener);
  /// Disposes the controller.
  void dispose();
}
```
