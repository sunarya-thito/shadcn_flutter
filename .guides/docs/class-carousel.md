---
title: "Class: Carousel"
description: "Interactive carousel widget with automatic transitions and customizable layouts."
---

```dart
/// Interactive carousel widget with automatic transitions and customizable layouts.
///
/// A high-level carousel widget that displays a sequence of items with smooth
/// transitions between them. Supports automatic progression, manual navigation,
/// multiple transition types, and extensive customization options.
///
/// ## Features
///
/// - **Multiple transition types**: Sliding and fading transitions with customizable timing
/// - **Automatic progression**: Optional auto-play with configurable duration per item
/// - **Manual navigation**: Programmatic control through [CarouselController]
/// - **Flexible sizing**: Fixed or fractional size constraints for responsive layouts
/// - **Interactive controls**: Pause on hover, wrap-around navigation, and touch gestures
/// - **Flexible alignment**: Multiple alignment options for different layout needs
/// - **Directional support**: Horizontal or vertical carousel orientation
///
/// ## Usage Patterns
///
/// **Basic automatic carousel:**
/// ```dart
/// Carousel(
///   itemCount: images.length,
///   duration: Duration(seconds: 3),
///   itemBuilder: (context, index) => Image.asset(images[index]),
///   transition: CarouselTransition.sliding(gap: 16),
/// )
/// ```
///
/// **Controlled carousel with custom navigation:**
/// ```dart
/// final controller = CarouselController();
/// 
/// Carousel(
///   controller: controller,
///   itemCount: products.length,
///   itemBuilder: (context, index) => ProductCard(products[index]),
///   transition: CarouselTransition.fading(),
///   pauseOnHover: true,
/// )
/// ```
class Carousel extends StatefulWidget {
  /// The carousel transition.
  final CarouselTransition transition;
  /// The item builder.
  final Widget Function(BuildContext context, int index) itemBuilder;
  /// The duration of the carousel.
  final Duration? duration;
  /// The duration builder of the carousel.
  final Duration? Function(int index)? durationBuilder;
  /// The item count of the carousel.
  final int? itemCount;
  /// The carousel controller.
  final CarouselController? controller;
  /// The carousel alignment.
  final CarouselAlignment alignment;
  /// The carousel direction.
  final Axis direction;
  /// Whether the carousel should wrap.
  final bool wrap;
  /// Whether the carousel should pause on hover.
  final bool pauseOnHover;
  /// Whether the carousel should wait the item duration on start.
  final bool waitOnStart;
  /// The autoplay speed of the carousel.
  final Duration? autoplaySpeed;
  /// Whether the carousel should autoplay in reverse.
  final bool autoplayReverse;
  /// Whether the carousel is draggable.
  final bool draggable;
  /// Whether the carousel is reverse in layout direction.
  final bool reverse;
  /// The size constraint of the carousel.
  final CarouselSizeConstraint sizeConstraint;
  /// The speed of the carousel.
  final Duration speed;
  /// The curve of the carousel.
  final Curve curve;
  /// The index change callback.
  final ValueChanged<int>? onIndexChanged;
  /// Whether to disable overhead scrolling.
  final bool disableOverheadScrolling;
  /// Whether to disable dragging velocity.
  final bool disableDraggingVelocity;
  /// Creates a carousel.
  const Carousel({super.key, required this.itemBuilder, this.itemCount, this.controller, this.alignment = CarouselAlignment.center, this.direction = Axis.horizontal, this.wrap = true, this.pauseOnHover = true, this.autoplaySpeed, this.waitOnStart = false, this.draggable = true, this.reverse = false, this.autoplayReverse = false, this.sizeConstraint = const CarouselFractionalConstraint(1), this.speed = const Duration(milliseconds: 200), this.curve = Curves.easeInOut, this.duration, this.durationBuilder, this.onIndexChanged, this.disableOverheadScrolling = true, this.disableDraggingVelocity = false, required this.transition});
  State<Carousel> createState();
}
```
