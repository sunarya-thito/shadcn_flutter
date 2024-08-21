import 'dart:async';

import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef RefreshIndicatorBuilder = Widget Function(
    BuildContext context, RefreshTriggerStage stage);

typedef FutureVoidCallback = Future<void> Function();

class RefreshTrigger extends StatefulWidget {
  static Widget defaultIndicatorBuilder(
      BuildContext context, RefreshTriggerStage stage) {
    return DefaultRefreshIndicator(stage: stage);
  }

  final double minExtent;
  final double? maxExtent;
  final FutureVoidCallback? onRefresh;
  final Widget child;
  final Axis direction;
  final bool reverse;
  final RefreshIndicatorBuilder indicatorBuilder;
  final Curve curve;

  const RefreshTrigger({
    Key? key,
    this.minExtent = 50.0,
    this.maxExtent = 150.0,
    this.onRefresh,
    this.direction = Axis.vertical,
    this.reverse = false,
    this.indicatorBuilder = defaultIndicatorBuilder,
    this.curve = Curves.easeOutSine,
    required this.child,
  }) : super(key: key);

  @override
  State<RefreshTrigger> createState() => _RefreshTriggerState();
}

class DefaultRefreshIndicator extends StatelessWidget {
  final RefreshTriggerStage stage;

  const DefaultRefreshIndicator({Key? key, required this.stage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SurfaceCard(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2) *
            theme.scaling,
        borderRadius: theme.radiusXl,
        child: Text(stage.stage.name),
      ),
    );
  }
}

class _RefreshTriggerState extends State<RefreshTrigger>
    with SingleTickerProviderStateMixin {
  double _currentExtent = 0;
  bool _scrolling = false;
  ScrollableState? _scrollable;
  TriggerStage _stage = TriggerStage.idle;

  double _calculateSafeExtent(double extent) {
    var maxExtent = widget.maxExtent;
    if (maxExtent != null) {
      if (extent >= widget.minExtent) {
        double relativeExtent = extent - widget.minExtent;
        double diff = maxExtent - relativeExtent;
        return extent - diff / 2;
      }
    }
    return extent;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification &&
            notification.depth == 0 &&
            _stage == TriggerStage.idle) {
          var context = notification.context;
          if (context != null) {
            // hold the scroll position
            ScrollableState? scrollable =
                Scrollable.maybeOf(context, axis: widget.direction);
            if (scrollable != null) {
              setState(() {
                _currentExtent = 0.0;
                _scrolling = true;
                _scrollable = scrollable;
                _stage = TriggerStage.pulling;
              });
            }
          }
          return true;
        }
        if (notification is ScrollEndNotification &&
            notification.depth == 0 &&
            _stage == TriggerStage.pulling) {
          setState(() {
            double currentExtent = _currentExtent;
            _scrolling = false;
            _currentExtent = 0.0;
            _scrollable = null;
            if (currentExtent >= widget.minExtent) {
              _stage = TriggerStage.refreshing;
              widget.onRefresh?.call().then((_) {
                if (mounted) {
                  setState(() {
                    _stage = TriggerStage.completed;
                    Timer(Duration(seconds: 1), () {
                      if (mounted) {
                        setState(() {
                          _stage = TriggerStage.idle;
                        });
                      }
                    });
                  });
                }
              });
            } else {
              _stage = TriggerStage.idle;
            }
          });
          return true;
        }
        if (notification is OverscrollNotification &&
            notification.depth == 0 &&
            notification.overscroll < 0) {
          if (notification.metrics.axis == widget.direction) {
            setState(() {
              _currentExtent -= notification.overscroll;
            });
          }
          return true;
        }
        if (notification is ScrollUpdateNotification &&
            notification.depth == 0 &&
            (notification.scrollDelta ?? 0) > 0 &&
            _scrollable != null) {
          if (notification.metrics.axis == widget.direction) {
            setState(() {
              _currentExtent = 0.0;
              _scrolling = false;
              _scrollable = null;
            });
            return true;
          }
        }
        return false;
      },
      child: AnimatedValueBuilder.animation(
        // value: _currentExtent,
        value: _stage == TriggerStage.refreshing ||
                _stage == TriggerStage.completed
            ? widget.minExtent
            : _currentExtent,
        duration: _scrolling ? Duration.zero : kDefaultDuration,
        curve: Curves.easeInOut,
        builder: (context, animation) {
          return Stack(
            fit: StackFit.passthrough,
            children: [
              widget.child,
              AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: ClipRect(
                        child: FractionalTranslation(
                          translation: widget.direction == Axis.vertical
                              ? const Offset(0, -1)
                              : const Offset(-1, 0),
                          child: Transform.translate(
                            offset: widget.direction == Axis.vertical
                                ? Offset(
                                    0, _calculateSafeExtent(animation.value))
                                : Offset(
                                    _calculateSafeExtent(animation.value), 0),
                            child: widget.indicatorBuilder(
                              context,
                              RefreshTriggerStage(
                                _stage,
                                animation,
                                widget.direction,
                              ),
                            ),
                          ),
                        ),
                      ));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

enum TriggerStage {
  idle,
  pulling,
  refreshing,
  completed,
}

class RefreshTriggerStage {
  final TriggerStage stage;
  final Animation<double> extent;
  final Axis direction;

  const RefreshTriggerStage(this.stage, this.extent, this.direction);
}
