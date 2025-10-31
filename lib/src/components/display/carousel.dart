import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Size constraint for the carousel.
abstract class CarouselSizeConstraint {
  /// Creates a carousel size constraint.
  const CarouselSizeConstraint();

  /// Creates a fixed carousel size constraint.
  const factory CarouselSizeConstraint.fixed(double size) =
      CarouselFixedConstraint;

  /// Creates a fractional carousel size constraint.
  const factory CarouselSizeConstraint.fractional(double fraction) =
      CarouselFractionalConstraint;
}

/// A fixed carousel size constraint.
class CarouselFixedConstraint extends CarouselSizeConstraint {
  /// The size of the constraint.
  final double size;

  /// Creates a fixed carousel size constraint.
  const CarouselFixedConstraint(this.size)
      : assert(size > 0, 'size must be greater than 0');
}

/// A fractional carousel size constraint.
class CarouselFractionalConstraint extends CarouselSizeConstraint {
  /// The fraction of the constraint.
  final double fraction;

  /// Creates a fractional carousel size constraint.
  const CarouselFractionalConstraint(this.fraction)
      : assert(fraction > 0, 'fraction must be greater than 0');
}

/// A carousel layout.
abstract class CarouselTransition {
  /// Creates a carousel layout.
  const CarouselTransition();

  /// Creates a sliding carousel layout.
  const factory CarouselTransition.sliding({double gap}) =
      SlidingCarouselTransition;

  /// Creates a fading carousel layout.
  const factory CarouselTransition.fading() = FadingCarouselTransition;

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

/// A sliding carousel transition.
class SlidingCarouselTransition extends CarouselTransition {
  /// The gap between the carousel items.
  final double gap;

  /// Creates a sliding carousel transition.
  const SlidingCarouselTransition({this.gap = 0});

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

/// Builds a carousel item.
/// The [index] is the index of the item.
typedef CarouselItemBuilder = Widget Function(BuildContext context, int index);

/// A controller for the carousel.
class CarouselController extends Listenable {
  final AnimationQueueController _controller = AnimationQueueController();

  /// Whether the carousel should animate.
  bool get shouldAnimate => _controller.shouldTick;

  /// The current value of the controller.
  double get value => _controller.value;

  /// Jumps to the next item.
  void next() {
    _controller.value = (_controller.value + 1).roundToDouble();
  }

  /// Jumps to the previous item.
  void previous() {
    _controller.value = (_controller.value - 1).roundToDouble();
  }

  /// Animates to the next item.
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

  /// Animates to the previous item.
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

  /// Snaps the current value to the nearest integer.
  void snap() {
    _controller.value = _controller.value.roundToDouble();
  }

  /// Animates the current value to the nearest integer.
  void animateSnap(Duration duration, [Curve curve = Curves.easeInOut]) {
    _controller.push(
      AnimationRequest(_controller.value.roundToDouble(), duration, curve),
    );
  }

  /// Jumps to the specified value.
  void jumpTo(double value) {
    _controller.value = value;
  }

  /// Animates to the specified value.
  void animateTo(
    double value,
    Duration duration, [
    Curve curve = Curves.linear,
  ]) {
    _controller.push(AnimationRequest(value, duration, curve), false);
  }

  /// Animates to the specified value.
  double getCurrentIndex(int? itemCount) {
    if (itemCount == null) {
      return _controller.value;
    } else {
      return wrapDouble(_controller.value, 0, itemCount.toDouble());
    }
  }

  /// Animates to the specified value.
  void tick(Duration delta) {
    _controller.tick(delta);
  }

  @override
  void addListener(VoidCallback listener) {
    _controller.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _controller.removeListener(listener);
  }

  /// Disposes the controller.
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

  /// Creates a copy of this theme with the given fields replaced.
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
