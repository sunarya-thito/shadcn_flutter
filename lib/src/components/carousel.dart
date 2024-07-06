import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/animation.dart';

// TODO Circle Icon Button, Dot Navigation

class CarouselController extends Listenable {
  final AnimationQueueController _controller = AnimationQueueController();

  bool get shouldAnimate => _controller.shouldTick;

  double get value => _controller.value;

  void next() {
    _controller.value = (_controller.value + 1).roundToDouble();
  }

  void previous() {
    _controller.value = (_controller.value - 1).roundToDouble();
  }

  void animateNext(Duration duration, [Curve curve = Curves.easeInOut]) {
    _controller.push(
        AnimationRequest(
            (_controller.value + 1).roundToDouble(), duration, curve),
        false);
  }

  void animatePrevious(Duration duration, [Curve curve = Curves.easeInOut]) {
    _controller.push(
        AnimationRequest(
            (_controller.value - 1).roundToDouble(), duration, curve),
        false);
  }

  void snap() {
    _controller.value = _controller.value.roundToDouble();
  }

  void animateSnap(Duration duration, [Curve curve = Curves.easeInOut]) {
    _controller.push(
        AnimationRequest(_controller.value.roundToDouble(), duration, curve));
  }

  void jumpTo(double value) {
    _controller.value = value;
  }

  void animateTo(double value, Duration duration,
      [Curve curve = Curves.linear]) {
    _controller.push(AnimationRequest(value, duration, curve), false);
  }

  double getCurrentIndex(int? itemCount) {
    if (itemCount == null) {
      return _controller.value;
    } else {
      return wrapDouble(_controller.value, 0, itemCount.toDouble());
    }
  }

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

  void dispose() {
    _controller.dispose();
  }
}

enum CarouselAlignment {
  start,
  center,
  end,
}

class CarouselItem {
  final Widget child;
  final Duration? duration;

  const CarouselItem({
    required this.child,
    this.duration,
  });
}

class Carousel extends StatefulWidget {
  final CarouselItem Function(BuildContext context, int index) itemBuilder;
  final int? itemCount;
  final CarouselController? controller;
  final CarouselAlignment? snapAlignment;
  final Axis direction;
  final bool wrap;
  final bool pauseOnHover;
  final Duration? autoplayDuration;
  final bool draggable;
  final bool reverse;
  final double sizeFactor;
  final Duration speed;
  final Curve curve;
  final double gap;

  const Carousel({
    Key? key,
    required this.itemBuilder,
    this.itemCount,
    this.controller,
    this.snapAlignment,
    this.direction = Axis.horizontal,
    this.wrap = true,
    this.pauseOnHover = true,
    this.autoplayDuration,
    this.draggable = true,
    this.reverse = false,
    this.sizeFactor = 1,
    this.speed = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.gap = 0,
  })  : assert(sizeFactor > 0, 'sizeFactor must be greater than 0'),
        assert(wrap || itemCount != null,
            'itemCount must be provided if wrap is false'),
        super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel>
    with SingleTickerProviderStateMixin {
  late CarouselController _controller;
  final Map<int, Duration> _quickAccessDuration = {};
  Duration? _currentSlideDuration;
  Duration? _startTime;
  late Ticker _ticker;
  bool hovered = false;
  bool dragging = false;

  double _dragVelocity = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
    _controller = widget.controller ?? CarouselController();
    _controller.addListener(_onControllerChange);
    _dispatchControllerChange();
  }

  void _check() {
    bool shouldStart = false;
    if (_controller.shouldAnimate) {
      shouldStart = true;
    }
    if (!shouldStart) {
      if (_currentSlideDuration != null) {
        if (!widget.pauseOnHover || !hovered) {
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
    if (_currentSlideDuration != null) {
      if (_startTime == null) {
        _startTime = elapsed;
      } else {
        Duration elapsedDuration = elapsed - _startTime!;
        if (elapsedDuration >= _currentSlideDuration!) {
          _controller.animateNext(widget.autoplayDuration!, widget.curve);
          _startTime = null;
        }
      }
    }
    if (_dragVelocity.abs() > 0.0001 && !dragging) {
      _controller.jumpTo(_controller.value + _dragVelocity);
      // decrease the drag velocity (consider the delta time)
      _dragVelocity *= pow(0.3, deltaMillis / 100);
      if (_dragVelocity.abs() < 0.0001) {
        _dragVelocity = 0;
        if (widget.snapAlignment != null) {
          _controller.animateSnap(widget.speed, widget.curve);
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
    _dispatchControllerChange();
  }

  void _dispatchControllerChange() {
    double currentIndex = _controller.getCurrentIndex(widget.itemCount);
    final duration = _quickAccessDuration[currentIndex.toInt()];
    _currentSlideDuration = duration ?? widget.autoplayDuration;
    _check();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChange);
    _controller.dispose();
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
          if (widget.draggable) {
            if (widget.direction == Axis.horizontal) {
              carouselWidget =
                  buildHorizontalDragger(context, carouselWidget, constraints);
            } else {
              carouselWidget =
                  buildVerticalDragger(context, carouselWidget, constraints);
            }
          }
          return carouselWidget;
        },
      ),
    );
  }

  Widget buildHorizontalDragger(
      BuildContext context, Widget carouselWidget, BoxConstraints constraints) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: carouselWidget,
      onHorizontalDragStart: (details) {
        dragging = true;
        _dragVelocity = 0;
      },
      onHorizontalDragUpdate: (details) {
        if (widget.draggable) {
          setState(() {
            var increment = -details.primaryDelta! /
                ((constraints.maxWidth * widget.sizeFactor) + widget.gap);
            _controller.jumpTo(_controller.value + increment);
          });
        }
      },
      onHorizontalDragEnd: (details) {
        dragging = false;
        _dragVelocity = (-details.primaryVelocity! /
                ((constraints.maxWidth * widget.sizeFactor) + widget.gap)) /
            100;
        if (widget.snapAlignment != null) {
          _controller.animateSnap(widget.speed, widget.curve);
        }
        _check();
      },
    );
  }

  Widget buildVerticalDragger(
      BuildContext context, Widget carouselWidget, BoxConstraints constraints) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: carouselWidget,
      onVerticalDragStart: (details) {
        dragging = true;
        _dragVelocity = 0;
      },
      onVerticalDragUpdate: (details) {
        if (widget.draggable) {
          setState(() {
            var increment = -details.primaryDelta! /
                ((constraints.maxHeight * widget.sizeFactor) + widget.gap);
            _controller.jumpTo(_controller.value + increment);
          });
        }
      },
      onVerticalDragEnd: (details) {
        dragging = false;
        _dragVelocity = (-details.primaryVelocity! /
                ((constraints.maxHeight * widget.sizeFactor) + widget.gap)) /
            100;
        if (widget.snapAlignment != null) {
          _controller.animateSnap(widget.speed, widget.curve);
        }
        _check();
      },
    );
  }

  Widget buildCarousel(BuildContext context, BoxConstraints constraints) {
    _quickAccessDuration.clear();
    // count how many items can be displayed
    int additionalPreviousItems = 1;
    int additionalNextItems = 1;
    double originalSize = widget.direction == Axis.horizontal
        ? constraints.maxWidth
        : constraints.maxHeight;
    double size = originalSize * widget.sizeFactor;
    double snapOffsetAlignment = 0;
    if (widget.snapAlignment != null) {
      switch (widget.snapAlignment!) {
        case CarouselAlignment.start:
          snapOffsetAlignment = 0;
          break;
        case CarouselAlignment.center:
          snapOffsetAlignment = (originalSize - size) / 2;
          break;
        case CarouselAlignment.end:
          snapOffsetAlignment = originalSize - size;
          break;
      }
    }
    double gapBeforeItem = snapOffsetAlignment;
    double gapAfterItem = originalSize - size - gapBeforeItem;
    additionalPreviousItems += max(0, (gapBeforeItem / size).ceil());
    additionalNextItems += max(0, (gapAfterItem / size).ceil());
    List<PlacedCarouselItem> items = [];
    double progressedIndex = _controller.value;
    double currentIndex =
        progressedIndex + (widget.gap / size) * progressedIndex;
    // curving the index
    int start = progressedIndex.floor() - additionalPreviousItems;
    int end = progressedIndex.floor() + additionalNextItems;
    for (int i = start; i <= end; i++) {
      double index;
      if (widget.itemCount != null) {
        index = wrapDouble(i.toDouble(), 0.0, widget.itemCount!.toDouble());
      } else {
        index = i.toDouble();
      }
      if (!widget.wrap && (index < 0 || index >= widget.itemCount!)) {
        continue;
      }
      final item = widget.itemBuilder(
          context, widget.reverse ? (-index).toInt() : index.toInt());
      var duration = item.duration;
      if (duration != null) {
        if (widget.autoplayDuration != null) {
          duration += widget.autoplayDuration!;
        }
        _quickAccessDuration[i] = duration;
      }
      double position = i.toDouble();
      // offset the gap
      items.add(PlacedCarouselItem(
        relativeIndex: i,
        child: item.child,
        position: position,
      ));
    }
    if (widget.direction == Axis.horizontal) {
      return Stack(
        children: [
          for (var item in items)
            Positioned(
                left: snapOffsetAlignment +
                    (item.position - currentIndex) * size +
                    (widget.gap * item.relativeIndex),
                width: constraints.maxWidth * widget.sizeFactor,
                height: constraints.maxHeight,
                child: item.child),
        ],
      );
    } else {
      return Stack(
        children: [
          for (var item in items)
            Positioned(
                top: snapOffsetAlignment +
                    (item.position - currentIndex) * size +
                    (widget.gap * item.relativeIndex),
                width: constraints.maxWidth,
                height: constraints.maxHeight * widget.sizeFactor,
                child: item.child),
        ],
      );
    }
  }
}

class PlacedCarouselItem {
  final int relativeIndex;
  final Widget child;
  final double position;

  const PlacedCarouselItem({
    required this.relativeIndex,
    required this.child,
    required this.position,
  });
}
