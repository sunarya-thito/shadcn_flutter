import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Abstract base class for defining size constraints in carousel layouts.
/// 
/// CarouselSizeConstraint provides a flexible system for controlling how
/// carousel items are sized within their container. It supports both fixed
/// pixel-based sizing and fractional sizing relative to the available space.
/// 
/// The constraint system enables responsive carousel layouts that adapt to
/// different screen sizes and orientations while maintaining consistent
/// item proportions.
/// 
/// Example:
/// ```dart
/// // Fixed size constraint - items are always 200px wide
/// final fixed = CarouselSizeConstraint.fixed(200.0);
/// 
/// // Fractional constraint - items take 80% of available width
/// final fractional = CarouselSizeConstraint.fractional(0.8);
/// ```
abstract class CarouselSizeConstraint {
  /// Creates a carousel size constraint.
  const CarouselSizeConstraint();

  /// Creates a fixed carousel size constraint.
  /// 
  /// Items will have a fixed pixel size regardless of the container dimensions.
  /// Useful when you need consistent absolute sizing across different screens.
  /// 
  /// Parameters:
  /// - [size] (double): The fixed size in logical pixels
  const factory CarouselSizeConstraint.fixed(double size) =
      CarouselFixedConstraint;

  /// Creates a fractional carousel size constraint.
  /// 
  /// Items will be sized as a fraction of the available container space.
  /// Enables responsive layouts that adapt to different screen sizes.
  /// 
  /// Parameters:
  /// - [fraction] (double): Fraction of container size (0.0 to 1.0+)
  const factory CarouselSizeConstraint.fractional(double fraction) =
      CarouselFractionalConstraint;
}

/// A size constraint that specifies a fixed pixel size for carousel items.
/// 
/// CarouselFixedConstraint provides absolute sizing control, making carousel
/// items maintain consistent pixel dimensions regardless of the container size.
/// This is useful for maintaining specific design requirements or when working
/// with fixed-size content like images or cards.
/// 
/// Example:
/// ```dart
/// final constraint = CarouselFixedConstraint(150.0);
/// // All carousel items will be 150 logical pixels wide/high
/// ```
class CarouselFixedConstraint extends CarouselSizeConstraint {
  /// The fixed size for carousel items in logical pixels.
  /// 
  /// Must be greater than 0. This value is used directly as the width (for
  /// horizontal carousels) or height (for vertical carousels) of each item.
  final double size;

  /// Creates a fixed carousel size constraint.
  /// 
  /// Parameters:
  /// - [size] (double): The fixed size in logical pixels (must be > 0)
  /// 
  /// Throws:
  /// - AssertionError if size is not greater than 0
  const CarouselFixedConstraint(this.size)
      : assert(size > 0, 'size must be greater than 0');
}

/// A size constraint that specifies a fractional size relative to the container.
/// 
/// CarouselFractionalConstraint enables responsive carousel layouts by sizing
/// items as a percentage of the available container space. This allows carousels
/// to adapt naturally to different screen sizes and orientations.
/// 
/// Example:
/// ```dart
/// final constraint = CarouselFractionalConstraint(0.7);
/// // Each carousel item takes 70% of the container width/height
/// ```
class CarouselFractionalConstraint extends CarouselSizeConstraint {
  /// The fraction of container space each item should occupy.
  /// 
  /// Must be greater than 0. Values less than 1.0 create items smaller than
  /// the container, while values greater than 1.0 create items larger than
  /// the container (useful for creating bleeding/peek effects).
  final double fraction;

  /// Creates a fractional carousel size constraint.
  /// 
  /// Parameters:
  /// - [fraction] (double): Fraction of container size (must be > 0)
  /// 
  /// Throws:
  /// - AssertionError if fraction is not greater than 0
  /// 
  /// Example:
  /// ```dart
  /// // Items take 80% of available space
  /// CarouselFractionalConstraint(0.8)
  /// 
  /// // Items are larger than container for peek effect
  /// CarouselFractionalConstraint(1.2)
  /// ```
  const CarouselFractionalConstraint(this.fraction)
      : assert(fraction > 0, 'fraction must be greater than 0');
}

/// Abstract base class for defining carousel transition animations and layouts.
/// 
/// CarouselTransition controls how carousel items are positioned, animated,
/// and transitioned between states. Different transition types provide various
/// visual effects like sliding, fading, or custom animations.
/// 
/// The transition system enables rich carousel experiences with smooth animations
/// and flexible layout options. Each transition type handles the mathematical
/// calculations for item positioning based on the carousel's current progress.
/// 
/// Example:
/// ```dart
/// // Sliding transition with gap between items
/// final sliding = CarouselTransition.sliding(gap: 16.0);
/// 
/// // Fade transition for crossfade effect
/// final fading = CarouselTransition.fading();
/// ```
abstract class CarouselTransition {
  /// Creates a carousel transition.
  const CarouselTransition();

  /// Creates a sliding carousel transition with optional gap between items.
  /// 
  /// Items slide horizontally or vertically with smooth motion. The gap
  /// parameter adds spacing between items for visual separation.
  /// 
  /// Parameters:
  /// - [gap] (double, default: 0): Space between items in logical pixels
  const factory CarouselTransition.sliding({double gap}) =
      SlidingCarouselTransition;

  /// Creates a fading carousel transition for crossfade effects.
  /// 
  /// Items fade in/out with opacity changes rather than positional movement.
  /// Creates smooth crossfade transitions between carousel items.
  const factory CarouselTransition.fading() = FadingCarouselTransition;

  /// Calculates and layouts the carousel items based on current state.
  /// 
  /// This method is the core of the transition system, handling all the
  /// mathematical calculations for item positioning, sizing, and animation
  /// based on the carousel's progress and configuration.
  /// 
  /// Parameters:
  /// - [context] (BuildContext): Build context for theme and scaling access
  /// - [progress] (double): Current animation progress
  /// - [constraints] (BoxConstraints): Available layout space
  /// - [alignment] (CarouselAlignment): Item alignment within container
  /// - [direction] (Axis): Scroll direction (horizontal/vertical)
  /// - [sizeConstraint] (CarouselSizeConstraint): Item sizing rules
  /// - [progressedIndex] (double): Current index with fractional progress
  /// - [itemCount] (int?): Total number of items (null for infinite)
  /// - [itemBuilder] (CarouselItemBuilder): Function to build items
  /// - [wrap] (bool): Whether to wrap around at boundaries
  /// - [reverse] (bool): Whether to reverse scroll direction
  /// 
  /// Returns:
  /// A list of positioned widgets representing the visible carousel items.
  List<Widget> layout(
    BuildContext context, {
    required double progress,
    required BoxConstraints constraints,
    required CarouselAlignment alignment,
    required Axis direction,
    required CarouselSizeConstraint sizeConstraint,
    required double progressedIndex,
    required int? itemCount,
    required CarouselItemBuilder itemBuilder,
    required bool wrap,
    required bool reverse,
  });
}

/// A sliding transition that moves items horizontally or vertically with optional gaps.
/// 
/// SlidingCarouselTransition provides the classic carousel experience with smooth
/// sliding animations between items. Items move in the specified direction with
/// consistent spacing controlled by the gap parameter.
/// 
/// This transition type is ideal for traditional carousels, image galleries,
/// and content sliders where spatial relationships between items are important.
/// 
/// Example:
/// ```dart
/// // Standard sliding without gaps
/// final transition = SlidingCarouselTransition();
/// 
/// // Sliding with 20px gaps between items
/// final gappedTransition = SlidingCarouselTransition(gap: 20.0);
/// ```
class SlidingCarouselTransition extends CarouselTransition {
  /// The gap between adjacent carousel items in logical pixels.
  /// 
  /// Controls the spacing between items in the sliding direction. Larger
  /// values create more visual separation, while 0 creates seamless
  /// item transitions.
  final double gap;

  /// Creates a sliding carousel transition.
  /// 
  /// Parameters:
  /// - [gap] (double, default: 0): Space between items in logical pixels
  const SlidingCarouselTransition({this.gap = 0});

  @override
  /// Layouts items with sliding positions based on progress and gap spacing.
  List<Widget> layout(
    BuildContext context, {
    required double progress,
    required BoxConstraints constraints,
    required CarouselAlignment alignment,
    required Axis direction,
    required CarouselSizeConstraint sizeConstraint,
    required double progressedIndex,
    required int? itemCount,
    required CarouselItemBuilder itemBuilder,
    required bool wrap,
    required bool reverse,
  }) {
    int additionalPreviousItems = 1;
    int additionalNextItems = 1;
    double originalSize = direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    double size;
    if (sizeConstraint is CarouselFixedConstraint) {
      size = sizeConstraint.size;
    } else if (sizeConstraint is CarouselFractionalConstraint) {
      size = originalSize * sizeConstraint.fraction;
    } else {
      size = originalSize;
    }
    double snapOffsetAlignment = (originalSize - size) * alignment.alignment;
    double gapBeforeItem = snapOffsetAlignment;
    double gapAfterItem = originalSize - size - gapBeforeItem;
    additionalPreviousItems += max(0, (gapBeforeItem / size).ceil());
    additionalNextItems += max(0, (gapAfterItem / size).ceil());
    List<_PlacedCarouselItem> items = [];
    // curving the index
    int start = progressedIndex.floor() - additionalPreviousItems;
    int end = progressedIndex.floor() + additionalNextItems;
    if (!wrap && itemCount != null) {
      start = start.clamp(0, itemCount - 1);
      end = end.clamp(0, itemCount - 1);
    }
    double currentIndex = progressedIndex + (gap / size) * progressedIndex;
    for (int i = start; i <= end; i++) {
      double index;
      if (itemCount != null) {
        index = wrapDouble(i.toDouble(), 0.0, itemCount.toDouble());
      } else {
        index = i.toDouble();
      }
      var itemIndex = reverse ? (-index).toInt() : index.toInt();
      final item = itemBuilder(context, itemIndex);
      double position = i.toDouble();
      // offset the gap
      items.add(
        _PlacedCarouselItem._(
          relativeIndex: i,
          child: item,
          position: position,
        ),
      );
    }
    if (direction == Axis.horizontal) {
      return [
        for (var item in items)
          Positioned(
            left: snapOffsetAlignment +
                (item.position - currentIndex) * size +
                (gap * item.relativeIndex),
            width: size,
            height: constraints.maxHeight,
            child: item.child,
          ),
      ];
    } else {
      return [
        for (var item in items)
          Positioned(
            top: snapOffsetAlignment +
                (item.position - currentIndex) * size +
                (gap * item.relativeIndex),
            width: constraints.maxWidth,
            height: size,
            child: item.child,
          ),
      ];
    }
  }
}

/// A fading carousel transition.
class FadingCarouselTransition extends CarouselTransition {
  /// Creates a fading carousel transition.
  const FadingCarouselTransition();

  @override
  List<Widget> layout(
    BuildContext context, {
    required double progress,
    required BoxConstraints constraints,
    required CarouselAlignment alignment,
    required Axis direction,
    required CarouselSizeConstraint sizeConstraint,
    required double progressedIndex,
    required int? itemCount,
    required CarouselItemBuilder itemBuilder,
    required bool wrap,
    required bool reverse,
  }) {
    double originalSize = direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    double size;
    if (sizeConstraint is CarouselFixedConstraint) {
      size = sizeConstraint.size;
    } else if (sizeConstraint is CarouselFractionalConstraint) {
      size = originalSize * sizeConstraint.fraction;
    } else {
      size = originalSize;
    }
    double snapOffsetAlignment = (originalSize - size) * alignment.alignment;
    List<_PlacedCarouselItem> items = [];
    // curving the index
    int start = progressedIndex.floor() - 1;
    int end = progressedIndex.floor() + 1;
    if (!wrap && itemCount != null) {
      start = start.clamp(0, itemCount - 1);
      end = end.clamp(0, itemCount - 1);
    }
    for (int i = start; i <= end; i++) {
      double index;
      if (itemCount != null) {
        index = wrapDouble(i.toDouble(), 0.0, itemCount.toDouble());
      } else {
        index = i.toDouble();
      }
      var itemIndex = reverse ? (-index).toInt() : index.toInt();
      final item = itemBuilder(context, itemIndex);
      double position = i.toDouble();
      // offset the gap
      items.add(
        _PlacedCarouselItem._(
          relativeIndex: i,
          child: item,
          position: position,
        ),
      );
    }
    if (direction == Axis.horizontal) {
      return [
        for (var item in items)
          Positioned(
            left: snapOffsetAlignment,
            width: size,
            height: constraints.maxHeight,
            child: Opacity(
              opacity: (1 - (progress - item.position).abs()).clamp(0.0, 1.0),
              child: item.child,
            ),
          ),
      ];
    } else {
      return [
        for (var item in items)
          Positioned(
            top: snapOffsetAlignment,
            width: constraints.maxWidth,
            height: size,
            child: Opacity(
              opacity: (1 - (progress - item.position).abs()).clamp(0.0, 1.0),
              child: item.child,
            ),
          ),
      ];
    }
  }
}

/// Function signature for building carousel items based on index.
/// 
/// CarouselItemBuilder defines the callback used by carousel components to
/// construct widgets for each item position. The builder receives the build
/// context and the item index, enabling dynamic content generation.
/// 
/// The index parameter corresponds to the item's position in the carousel
/// sequence. For infinite carousels, the index can be any integer value.
/// For finite carousels, the index is constrained to the item count.
/// 
/// Example:
/// ```dart
/// CarouselItemBuilder builder = (context, index) {
///   return Container(
///     decoration: BoxDecoration(color: Colors.blue[100 * (index % 9 + 1)]),
///     child: Center(child: Text('Item $index')),
///   );
/// };
/// ```
typedef CarouselItemBuilder = Widget Function(BuildContext context, int index);

/// Controller for managing carousel state and animations.
/// 
/// CarouselController provides programmatic control over carousel position,
/// navigation, and animations. It maintains the current position as a floating-point
/// value to support smooth transitions between discrete item indices.
/// 
/// The controller uses an internal animation queue system to handle smooth
/// transitions between positions. It supports both instant jumps and animated
/// transitions with customizable timing and easing curves.
/// 
/// Example:
/// ```dart
/// final controller = CarouselController();
/// 
/// // Jump to next item instantly
/// controller.next();
/// 
/// // Animate to next item over 300ms
/// controller.animateNext(Duration(milliseconds: 300), Curves.easeOut);
/// 
/// // Jump to specific position
/// controller.value = 5.0;
/// ```
class CarouselController extends Listenable {
  final AnimationQueueController _controller = AnimationQueueController();

  /// Whether the carousel currently has active animations.
  /// 
  /// Returns true if the controller has pending or running animations that
  /// require frame updates. Used by the carousel widget to determine when
  /// to rebuild during animations.
  bool get shouldAnimate => _controller.shouldTick;

  /// The current position of the carousel as a floating-point value.
  /// 
  /// Integer values correspond to discrete item positions, while fractional
  /// values represent intermediate positions during transitions. For example,
  /// 1.5 represents halfway between items 1 and 2.
  double get value => _controller.value;

  /// Instantly jumps to the next item without animation.
  /// 
  /// Increments the current position by 1 and rounds to the nearest integer.
  /// For infinite carousels, this can continue indefinitely. For finite
  /// carousels, the carousel widget handles boundary conditions.
  /// 
  /// Example:
  /// ```dart
  /// controller.next(); // 0.0 -> 1.0
  /// ```
  void next() {
    _controller.value = (_controller.value + 1).roundToDouble();
  }

  /// Instantly jumps to the previous item without animation.
  /// 
  /// Decrements the current position by 1 and rounds to the nearest integer.
  /// For infinite carousels, this can continue indefinitely in the negative
  /// direction. For finite carousels, the carousel widget handles boundary conditions.
  /// 
  /// Example:
  /// ```dart
  /// controller.previous(); // 2.0 -> 1.0
  /// ```
  void previous() {
    _controller.value = (_controller.value - 1).roundToDouble();
  }

  /// Animates to the next item with the specified duration and curve.
  /// 
  /// Creates a smooth transition to the next carousel position. The animation
  /// replaces any currently running animations.
  /// 
  /// Parameters:
  /// - [duration] (Duration): How long the animation should take
  /// - [curve] (Curve, default: Curves.easeInOut): Easing curve for the animation
  /// 
  /// Example:
  /// ```dart
  /// // Smooth 500ms transition to next item
  /// controller.animateNext(Duration(milliseconds: 500), Curves.easeOut);
  /// ```
  void animateNext(Duration duration, [Curve curve = Curves.easeInOut]) {
    _controller.push(
      AnimationRequest(
        (_controller.value + 1).roundToDouble(),
        duration,
        curve,
      ),
      false,
    );
  }

  /// Animates to the previous item with the specified duration and curve.
  /// 
  /// Creates a smooth transition to the previous carousel position. The animation
  /// replaces any currently running animations.
  /// 
  /// Parameters:
  /// - [duration] (Duration): How long the animation should take
  /// - [curve] (Curve, default: Curves.easeInOut): Easing curve for the animation
  /// 
  /// Example:
  /// ```dart
  /// // Quick 200ms transition to previous item
  /// controller.animatePrevious(Duration(milliseconds: 200), Curves.easeIn);
  /// ```
  void animatePrevious(Duration duration, [Curve curve = Curves.easeInOut]) {
    _controller.push(
      AnimationRequest(
        (_controller.value - 1).roundToDouble(),
        duration,
        curve,
      ),
      false,
    );
  }

  /// Snaps the current position to the nearest integer item index.
  /// 
  /// Useful for correcting position drift or ensuring the carousel is properly
  /// aligned to discrete item positions after manual manipulation.
  /// 
  /// Example:
  /// ```dart
  /// // If controller.value is 2.3, snap() makes it 2.0
  /// // If controller.value is 2.7, snap() makes it 3.0
  /// controller.snap();
  /// ```
  void snap() {
    _controller.value = _controller.value.roundToDouble();
  }

  /// Animates the current position to the nearest integer with smooth transition.
  /// 
  /// Similar to [snap] but with smooth animation instead of instant positioning.
  /// Useful for correcting alignment issues with visual feedback.
  /// 
  /// Parameters:
  /// - [duration] (Duration): How long the snap animation should take
  /// - [curve] (Curve, default: Curves.easeInOut): Easing curve for the animation
  /// 
  /// Example:
  /// ```dart
  /// // Smoothly snap to nearest position over 200ms
  /// controller.animateSnap(Duration(milliseconds: 200));
  /// ```
  void animateSnap(Duration duration, [Curve curve = Curves.easeInOut]) {
    _controller.push(
      AnimationRequest(_controller.value.roundToDouble(), duration, curve),
    );
  }

  /// Instantly jumps to the specified position without animation.
  /// 
  /// Sets the carousel position immediately to the given value. Fractional
  /// values are supported for positioning between items.
  /// 
  /// Parameters:
  /// - [value] (double): The target position to jump to
  /// 
  /// Example:
  /// ```dart
  /// controller.jumpTo(5.5); // Jump to halfway between items 5 and 6
  /// ```
  void jumpTo(double value) {
    _controller.value = value;
  }

  /// Animates to the specified position with smooth transition.
  /// 
  /// Creates a smooth animation to the target position. The animation
  /// replaces any currently running animations.
  /// 
  /// Parameters:
  /// - [value] (double): The target position to animate to
  /// - [duration] (Duration): How long the animation should take
  /// - [curve] (Curve, default: Curves.linear): Easing curve for the animation
  /// 
  /// Example:
  /// ```dart
  /// // Animate to item 3 over 1 second with ease-out
  /// controller.animateTo(3.0, Duration(seconds: 1), Curves.easeOut);
  /// ```
  void animateTo(
    double value,
    Duration duration, [
    Curve curve = Curves.linear,
  ]) {
    _controller.push(AnimationRequest(value, duration, curve), false);
  }

  /// Gets the current index adjusted for finite carousels with wrapping.
  /// 
  /// For infinite carousels (itemCount is null), returns the raw controller value.
  /// For finite carousels, wraps the value within the valid range [0, itemCount).
  /// 
  /// Parameters:
  /// - [itemCount] (int?, optional): Total number of items in the carousel
  /// 
  /// Returns:
  /// The current index, wrapped if necessary for finite carousels.
  /// 
  /// Example:
  /// ```dart
  /// // For a 5-item carousel at position 7.0
  /// final index = controller.getCurrentIndex(5); // Returns 2.0 (7 % 5)
  /// ```
  double getCurrentIndex(int? itemCount) {
    if (itemCount == null) {
      return _controller.value;
    } else {
      return wrapDouble(_controller.value, 0, itemCount.toDouble());
    }
  }

  /// Advances animation progress by the specified time delta.
  /// 
  /// Called by the carousel widget during animation frames to update
  /// the controller's internal animation state. Should not be called
  /// directly by user code.
  /// 
  /// Parameters:
  /// - [delta] (Duration): Time elapsed since the last tick
  void tick(Duration delta) {
    _controller.tick(delta);
  }

  @override
  /// Registers a listener to be called when the controller value changes.
  void addListener(VoidCallback listener) {
    _controller.addListener(listener);
  }

  @override
  /// Removes a previously registered listener.
  void removeListener(VoidCallback listener) {
    _controller.removeListener(listener);
  }

  /// Disposes the controller and releases resources.
  /// 
  /// Should be called when the controller is no longer needed to prevent
  /// memory leaks. Typically called in the dispose method of the widget
  /// that owns the controller.
  void dispose() {
    _controller.dispose();
  }
}

/// CarouselAlignment is used to align the carousel items.
enum CarouselAlignment {
  /// Aligns the carousel items to the start.
  start(0),

  /// Aligns the carousel items to the center.
  center(0.5),

  /// Aligns the carousel items to the end.
  end(1);

  /// The alignment value.
  final double alignment;

  const CarouselAlignment(this.alignment);
}

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

  const CarouselTheme({
    this.alignment,
    this.direction,
    this.wrap,
    this.pauseOnHover,
    this.autoplaySpeed,
    this.draggable,
    this.speed,
    this.curve,
  });

  CarouselTheme copyWith({
    ValueGetter<CarouselAlignment?>? alignment,
    ValueGetter<Axis?>? direction,
    ValueGetter<bool?>? wrap,
    ValueGetter<bool?>? pauseOnHover,
    ValueGetter<Duration?>? autoplaySpeed,
    ValueGetter<bool?>? draggable,
    ValueGetter<Duration?>? speed,
    ValueGetter<Curve?>? curve,
  }) {
    return CarouselTheme(
      alignment: alignment == null ? this.alignment : alignment(),
      direction: direction == null ? this.direction : direction(),
      wrap: wrap == null ? this.wrap : wrap(),
      pauseOnHover: pauseOnHover == null ? this.pauseOnHover : pauseOnHover(),
      autoplaySpeed:
          autoplaySpeed == null ? this.autoplaySpeed : autoplaySpeed(),
      draggable: draggable == null ? this.draggable : draggable(),
      speed: speed == null ? this.speed : speed(),
      curve: curve == null ? this.curve : curve(),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CarouselTheme &&
        other.alignment == alignment &&
        other.direction == direction &&
        other.wrap == wrap &&
        other.pauseOnHover == pauseOnHover &&
        other.autoplaySpeed == autoplaySpeed &&
        other.draggable == draggable &&
        other.speed == speed &&
        other.curve == curve;
  }

  @override
  int get hashCode => Object.hash(
        alignment,
        direction,
        wrap,
        pauseOnHover,
        autoplaySpeed,
        draggable,
        speed,
        curve,
      );
}

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
  const Carousel({
    super.key,
    required this.itemBuilder,
    this.itemCount,
    this.controller,
    this.alignment = CarouselAlignment.center,
    this.direction = Axis.horizontal,
    this.wrap = true,
    this.pauseOnHover = true,
    this.autoplaySpeed,
    this.waitOnStart = false,
    this.draggable = true,
    this.reverse = false,
    this.autoplayReverse = false,
    this.sizeConstraint = const CarouselFractionalConstraint(1),
    this.speed = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.duration,
    this.durationBuilder,
    this.onIndexChanged,
    this.disableOverheadScrolling = true,
    this.disableDraggingVelocity = false,
    required this.transition,
  }) : assert(
          wrap || itemCount != null,
          'itemCount must be provided if wrap is false',
        );

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with SingleTickerProviderStateMixin {
  late CarouselController _controller;
  Duration? _startTime;
  late Ticker _ticker;
  bool hovered = false;
  bool dragging = false;

  late double _lastDragValue;
  double _dragVelocity = 0;

  late int _currentIndex;

  CarouselTheme? _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = ComponentTheme.maybeOf<CarouselTheme>(context);
  }

  CarouselAlignment get _alignment => styleValue(
        widgetValue: widget.alignment,
        themeValue: _theme?.alignment,
        defaultValue: CarouselAlignment.center,
      );

  Axis get _direction => styleValue(
        widgetValue: widget.direction,
        themeValue: _theme?.direction,
        defaultValue: Axis.horizontal,
      );

  bool get _wrap => styleValue(
        widgetValue: widget.wrap,
        themeValue: _theme?.wrap,
        defaultValue: true,
      );

  bool get _pauseOnHover => styleValue(
        widgetValue: widget.pauseOnHover,
        themeValue: _theme?.pauseOnHover,
        defaultValue: true,
      );

  Duration? get _autoplaySpeed => styleValue(
        widgetValue: widget.autoplaySpeed,
        themeValue: _theme?.autoplaySpeed,
        defaultValue: null,
      );

  bool get _draggable => styleValue(
        widgetValue: widget.draggable,
        themeValue: _theme?.draggable,
        defaultValue: true,
      );

  Duration get _speed => styleValue(
        widgetValue: widget.speed,
        themeValue: _theme?.speed,
        defaultValue: const Duration(milliseconds: 200),
      );

  Curve get _curve => styleValue(
        widgetValue: widget.curve,
        themeValue: _theme?.curve,
        defaultValue: Curves.easeInOut,
      );

  Duration? get _currentSlideDuration {
    double currentIndex = _controller.getCurrentIndex(widget.itemCount);
    final int index = currentIndex.floor();
    Duration? duration = widget.durationBuilder?.call(index) ?? widget.duration;
    if (duration != null && _autoplaySpeed != null) {
      duration += _autoplaySpeed!;
    }
    return duration;
  }

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
    _controller = widget.controller ?? CarouselController();
    _controller.addListener(_onControllerChange);
    _currentIndex = _controller.getCurrentIndex(widget.itemCount).round();
    _dispatchControllerChange();
  }

  void _check() {
    bool shouldStart = false;
    if (_controller.shouldAnimate) {
      shouldStart = true;
    }
    if (!shouldStart) {
      if (_currentSlideDuration != null) {
        if (!_pauseOnHover || !hovered) {
          shouldStart = true;
        }
      }
    }
    if (!shouldStart) {
      if (_dragVelocity.abs() > 0.0001) {
        shouldStart = true;
      }
    }
    if (shouldStart) {
      if (!_ticker.isActive) {
        _lastTime = null;
        _startTime = null;
        _ticker.start();
      }
    } else {
      if (_ticker.isActive) {
        _ticker.stop();
        _startTime = null;
        _lastTime = null;
      }
    }
  }

  Duration? _lastTime;
  void _tick(Duration elapsed) {
    Duration delta = _lastTime == null ? Duration.zero : elapsed - _lastTime!;
    _lastTime = elapsed;
    int deltaMillis = delta.inMilliseconds;
    // animate the index progress
    _controller.tick(delta);
    bool shouldAutoPlay = false;
    if (_currentSlideDuration != null) {
      if (_startTime == null) {
        _startTime = elapsed;
        shouldAutoPlay = !widget.waitOnStart;
      } else {
        Duration elapsedDuration = elapsed - _startTime!;
        if (elapsedDuration >= _currentSlideDuration!) {
          shouldAutoPlay = true;
          _startTime = null;
        }
      }
    }
    if (shouldAutoPlay) {
      if (!_wrap &&
          widget.itemCount != null &&
          _controller.value >= widget.itemCount! - 1) {
        _controller.animateTo(0, _autoplaySpeed ?? _speed, _curve);
      } else if (!_wrap && widget.itemCount != null && _controller.value <= 0) {
        _controller.animateTo(
          widget.itemCount! - 1,
          _autoplaySpeed ?? _speed,
          _curve,
        );
      } else if (widget.autoplayReverse) {
        _controller.animatePrevious(_autoplaySpeed ?? _speed, _curve);
      } else {
        _controller.animateNext(_autoplaySpeed ?? _speed, _curve);
      }
    }
    if (_dragVelocity.abs() > 0.01 && !dragging) {
      var targetValue = progressedValue + _dragVelocity;
      _controller.jumpTo(targetValue);
      // decrease the drag velocity (consider the delta time)
      _dragVelocity *= pow(0.2, deltaMillis / 100);
      if (_dragVelocity.abs() < 0.01) {
        _dragVelocity = 0;
        if (widget.disableOverheadScrolling) {
          if (_lastDragValue < targetValue) {
            _controller.animateTo(
              _lastDragValue.floorToDouble() + 1,
              _speed,
              _curve,
            );
          } else {
            _controller.animateTo(
              _lastDragValue.floorToDouble() - 1,
              _speed,
              _curve,
            );
          }
        } else {
          _controller.animateSnap(_speed, _curve);
        }
      }
    }

    _check();
  }

  @override
  void didUpdateWidget(covariant Carousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_onControllerChange);
      _controller = widget.controller ?? CarouselController();
      _controller.addListener(_onControllerChange);
      _dispatchControllerChange();
    }
  }

  void _onControllerChange() {
    setState(() {});
    if (!_wrap && widget.itemCount != null) {
      if (_controller.value < 0) {
        _controller._controller.value = 0;
      } else if (_controller.value >= widget.itemCount!) {
        _controller._controller.value = widget.itemCount!.toDouble() - 1;
      }
    }
    _dispatchControllerChange();
  }

  void _dispatchControllerChange() {
    _check();
    int index = _controller.getCurrentIndex(widget.itemCount).round();
    if (index != _currentIndex) {
      _currentIndex = index;
      widget.onIndexChanged?.call(index);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChange);
    // DO NOT DISPOSE CONTROLLER
    // CONTROLLER might not belong to this state
    // Removing our  listener from the controller is enough
    // _controller.dispose();
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        hovered = true;
        _check();
      },
      onExit: (event) {
        hovered = false;
        _check();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          var carouselWidget = buildCarousel(context, constraints);
          if (_draggable) {
            if (_direction == Axis.horizontal) {
              carouselWidget = buildHorizontalDragger(
                context,
                carouselWidget,
                constraints,
              );
            } else {
              carouselWidget = buildVerticalDragger(
                context,
                carouselWidget,
                constraints,
              );
            }
          }
          return carouselWidget;
        },
      ),
    );
  }

  Widget buildHorizontalDragger(
    BuildContext context,
    Widget carouselWidget,
    BoxConstraints constraints,
  ) {
    double size;
    if (widget.sizeConstraint is CarouselFixedConstraint) {
      size = (widget.sizeConstraint as CarouselFixedConstraint).size;
    } else if (widget.sizeConstraint is CarouselFractionalConstraint) {
      size = constraints.maxHeight *
          (widget.sizeConstraint as CarouselFractionalConstraint).fraction;
    } else {
      size = constraints.maxHeight;
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: carouselWidget,
      onHorizontalDragStart: (details) {
        dragging = true;
        _lastDragValue = progressedValue;
        _dragVelocity = 0;
      },
      onHorizontalDragUpdate: (details) {
        if (_draggable) {
          setState(() {
            var increment = -details.primaryDelta! / size;
            _controller.jumpTo(progressedValue + increment);
          });
        }
      },
      onHorizontalDragEnd: (details) {
        dragging = false;
        if (widget.disableDraggingVelocity) {
          _dragVelocity = 0;
        } else {
          _dragVelocity = -details.primaryVelocity! / size / 100.0;
        }
        _controller.animateSnap(_speed, _curve);
        _check();
      },
    );
  }

  Widget buildVerticalDragger(
    BuildContext context,
    Widget carouselWidget,
    BoxConstraints constraints,
  ) {
    double size;
    if (widget.sizeConstraint is CarouselFixedConstraint) {
      size = (widget.sizeConstraint as CarouselFixedConstraint).size;
    } else if (widget.sizeConstraint is CarouselFractionalConstraint) {
      size = constraints.maxWidth *
          (widget.sizeConstraint as CarouselFractionalConstraint).fraction;
    } else {
      size = constraints.maxWidth;
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: carouselWidget,
      onVerticalDragStart: (details) {
        dragging = true;
        _lastDragValue = progressedValue;
        _dragVelocity = 0;
      },
      onVerticalDragUpdate: (details) {
        if (_draggable) {
          setState(() {
            var increment = -details.primaryDelta! / size;
            _controller.jumpTo(progressedValue + increment);
          });
        }
      },
      onVerticalDragEnd: (details) {
        dragging = false;
        if (widget.disableDraggingVelocity) {
          _dragVelocity = 0;
        } else {
          _dragVelocity = -details.primaryVelocity! / size / 100.0;
        }
        _controller.animateSnap(_speed, _curve);
        _check();
      },
    );
  }

  double get progressedValue {
    if (!_wrap && widget.itemCount != null) {
      return _controller.value.clamp(0.0, widget.itemCount!.toDouble() - 1);
    } else {
      return _controller.value;
    }
  }

  Widget buildCarousel(BuildContext context, BoxConstraints constraints) {
    return Stack(
      children: widget.transition.layout(
        context,
        progress: progressedValue,
        constraints: constraints,
        alignment: _alignment,
        direction: _direction,
        sizeConstraint: widget.sizeConstraint,
        progressedIndex: progressedValue,
        wrap: _wrap,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
        reverse: widget.reverse,
      ),
    );
  }
}

class _PlacedCarouselItem {
  final int relativeIndex;
  final Widget child;
  final double position;

  const _PlacedCarouselItem._({
    required this.relativeIndex,
    required this.child,
    required this.position,
  });
}

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
  const CarouselDotIndicator({
    super.key,
    required this.itemCount,
    required this.controller,
    this.speed = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        int value = controller.value.round() % itemCount;
        if (value < 0) {
          value += itemCount;
        }
        return DotIndicator(
          index: value,
          length: itemCount,
          onChanged: (value) {
            controller.animateTo(value.toDouble(), speed, curve);
          },
        );
      },
    );
  }
}
