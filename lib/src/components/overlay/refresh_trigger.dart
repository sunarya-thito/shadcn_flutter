import 'dart:async';
import 'dart:math';

import 'package:flutter/rendering.dart';
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
  final Duration completeDuration;

  const RefreshTrigger({
    super.key,
    this.minExtent = 75.0,
    this.maxExtent = 150.0,
    this.onRefresh,
    this.direction = Axis.vertical,
    this.reverse = false,
    this.indicatorBuilder = defaultIndicatorBuilder,
    this.curve = Curves.easeOutSine,
    this.completeDuration = const Duration(milliseconds: 500),
    required this.child,
  });

  @override
  State<RefreshTrigger> createState() => RefreshTriggerState();
}

class DefaultRefreshIndicator extends StatefulWidget {
  final RefreshTriggerStage stage;

  const DefaultRefreshIndicator({super.key, required this.stage});

  @override
  State<DefaultRefreshIndicator> createState() =>
      _DefaultRefreshIndicatorState();
}

class _DefaultRefreshIndicatorState extends State<DefaultRefreshIndicator> {
  Widget buildRefreshingContent(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(localizations.refreshTriggerRefreshing)),
        const CircularProgressIndicator(),
      ],
    ).gap(8);
  }

  Widget buildCompletedContent(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = ShadcnLocalizations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(localizations.refreshTriggerComplete)),
        SizedBox(
          width: 12.0 * theme.scaling,
          height: 8.0 * theme.scaling,
          child: AnimatedValueBuilder(
              initialValue: 0.0,
              value: 1.0,
              duration: const Duration(milliseconds: 300),
              curve: const Interval(0.5, 1.0),
              builder: (context, value, _) {
                return CustomPaint(
                  painter: AnimatedCheckPainter(
                    progress: value,
                    color: theme.colorScheme.foreground,
                    strokeWidth: 1.5 * theme.scaling,
                  ),
                );
              }),
        ),
      ],
    ).gap(8);
  }

  Widget buildPullingContent(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return AnimatedBuilder(
        animation: widget.stage.extent,
        builder: (context, child) {
          double angle;
          if (widget.stage.direction == Axis.vertical) {
            // 0 -> 1 (0 -> 180)
            angle = -pi * widget.stage.extent.value.clamp(0, 1);
          } else {
            // 0 -> 1 (90 -> 270)
            angle = -pi / 2 + -pi * widget.stage.extent.value.clamp(0, 1);
          }
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.rotate(
                angle: angle,
                child: const Icon(Icons.arrow_downward),
              ),
              Flexible(
                  child: Text(widget.stage.extent.value < 1
                      ? localizations.refreshTriggerPull
                      : localizations.refreshTriggerRelease)),
              Transform.rotate(
                angle: angle,
                child: const Icon(Icons.arrow_downward),
              ),
            ],
          ).gap(8);
        });
  }

  Widget buildIdleContent(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Text(localizations.refreshTriggerPull)),
      ],
    ).gap(8);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (widget.stage.stage) {
      case TriggerStage.refreshing:
        child = buildRefreshingContent(context);
        break;
      case TriggerStage.completed:
        child = buildCompletedContent(context);
        break;
      case TriggerStage.pulling:
        child = buildPullingContent(context);
        break;
      case TriggerStage.idle:
        child = buildIdleContent(context);
        break;
    }
    final theme = Theme.of(context);
    return Center(
      child: SurfaceCard(
        padding: widget.stage.stage == TriggerStage.pulling
            ? const EdgeInsets.all(4) * theme.scaling
            : const EdgeInsets.symmetric(horizontal: 12, vertical: 4) *
                theme.scaling,
        borderRadius: theme.borderRadiusXl,
        child: CrossFadedTransition(
          child: KeyedSubtree(
            key: ValueKey(widget.stage.stage),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _RefreshTriggerTween extends Animatable<double> {
  final double minExtent;

  const _RefreshTriggerTween(this.minExtent);

  @override
  double transform(double t) {
    return t / minExtent;
  }
}

class RefreshTriggerState extends State<RefreshTrigger>
    with SingleTickerProviderStateMixin {
  double _currentExtent = 0;
  bool _scrolling = false;
  ScrollDirection _userScrollDirection = ScrollDirection.idle;
  TriggerStage _stage = TriggerStage.idle;
  Future<void>? _currentFuture;
  int _currentFutureCount = 0;

  double _calculateSafeExtent(double extent) {
    if (extent > widget.minExtent) {
      double relativeExtent = extent - widget.minExtent;
      double? maxExtent = widget.maxExtent;
      if (maxExtent == null) {
        return widget.minExtent;
      }
      double diff = (maxExtent - widget.minExtent) - relativeExtent;
      double diffNormalized = diff / (maxExtent - widget.minExtent);
      return maxExtent - _decelerateCurve(diffNormalized.clamp(0, 1)) * diff;
    }
    return extent;
  }

  double _decelerateCurve(double value) {
    return Curves.decelerate.transform(value);
  }

  Widget _wrapPositioned(Widget child) {
    if (widget.direction == Axis.vertical) {
      return Positioned(
        top: !widget.reverse ? 0 : null,
        bottom: !widget.reverse ? null : 0,
        left: 0,
        right: 0,
        child: child,
      );
    } else {
      return Positioned(
        top: 0,
        bottom: 0,
        left: widget.reverse ? null : 0,
        right: widget.reverse ? 0 : null,
        child: child,
      );
    }
  }

  Offset get _offset {
    if (widget.direction == Axis.vertical) {
      return Offset(0, widget.reverse ? 1 : -1);
    } else {
      return Offset(widget.reverse ? 1 : -1, 0);
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth != 0) {
      return false;
    }
    if (notification is ScrollEndNotification && _scrolling) {
      setState(() {
        if (_currentExtent >= widget.minExtent) {
          _scrolling = false;
          refresh();
        } else {
          _stage = TriggerStage.idle;
          _currentExtent = 0;
        }
      });
    } else if (notification is ScrollUpdateNotification) {
      var delta = notification.scrollDelta;
      if (delta != null) {
        if (_stage == TriggerStage.pulling) {
          bool forward = widget.reverse ? delta > 0 : delta < 0;
          if ((forward && _userScrollDirection == ScrollDirection.forward) ||
              (!forward && _userScrollDirection == ScrollDirection.reverse)) {
            setState(() {
              _currentExtent -= delta;
            });
          } else {
            if (_currentExtent >= widget.minExtent) {
              _scrolling = false;
              refresh();
            } else {
              setState(() {
                _currentExtent -= delta;
              });
            }
          }
        } else if (_stage == TriggerStage.idle &&
            (widget.reverse ? delta > 0 : delta < 0)) {
          setState(() {
            _currentExtent = 0;
            _scrolling = true;
            _stage = TriggerStage.pulling;
          });
        }
      }
    } else if (notification is UserScrollNotification) {
      _userScrollDirection = notification.direction;
    } else if (notification is OverscrollNotification) {
      if (_stage == TriggerStage.idle) {
        setState(() {
          _currentExtent = 0;
          _scrolling = true;
          _stage = TriggerStage.pulling;
        });
      } else {
        setState(() {
          _currentExtent -= notification.overscroll;
        });
      }
    }
    return false;
  }

  Future<void> refresh([FutureVoidCallback? refreshCallback]) async {
    _scrolling = false;
    int count = ++_currentFutureCount;
    if (_currentFuture != null) {
      await _currentFuture;
    }
    setState(() {
      _currentFuture = _refresh(refreshCallback);
    });
    return _currentFuture!.whenComplete(() {
      if (!mounted || count != _currentFutureCount) {
        return;
      }
      setState(() {
        _currentFuture = null;
        _stage = TriggerStage.completed;
        // Future.delayed works the same
        Timer(widget.completeDuration, () {
          if (!mounted) {
            return;
          }
          setState(() {
            _stage = TriggerStage.idle;
            _currentExtent = 0;
          });
        });
      });
    });
  }

  Future<void> _refresh([FutureVoidCallback? refresh]) {
    if (_stage != TriggerStage.refreshing) {
      setState(() {
        _stage = TriggerStage.refreshing;
      });
    }
    refresh ??= widget.onRefresh;
    return refresh?.call() ?? Future.value();
  }

  @override
  Widget build(BuildContext context) {
    var tween = _RefreshTriggerTween(widget.minExtent);
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: AnimatedValueBuilder.animation(
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
                child: widget.indicatorBuilder(
                  context,
                  RefreshTriggerStage(
                    _stage,
                    tween.animate(animation),
                    widget.direction,
                  ),
                ),
                builder: (context, child) {
                  return Positioned.fill(
                      child: ClipRect(
                    child: Stack(
                      children: [
                        _wrapPositioned(
                          FractionalTranslation(
                            translation: _offset,
                            child: Transform.translate(
                              offset: widget.direction == Axis.vertical
                                  ? Offset(
                                      0, _calculateSafeExtent(animation.value))
                                  : Offset(
                                      _calculateSafeExtent(animation.value), 0),
                              child: child,
                            ),
                          ),
                        ),
                      ],
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

class RefreshTriggerPhysics extends ScrollPhysics {}
