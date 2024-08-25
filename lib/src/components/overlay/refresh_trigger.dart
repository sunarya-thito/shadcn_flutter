import 'dart:async';
import 'dart:math';

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
    Key? key,
    this.minExtent = 75.0,
    this.maxExtent = 150.0,
    this.onRefresh,
    this.direction = Axis.vertical,
    this.reverse = false,
    this.indicatorBuilder = defaultIndicatorBuilder,
    this.curve = Curves.easeOutSine,
    this.completeDuration = const Duration(milliseconds: 500),
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
    final localizations = ShadcnLocalizations.of(context);
    return Center(
      child: SurfaceCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4) *
            theme.scaling,
        borderRadius: theme.radiusXl,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: stage.extent,
              builder: (context, child) {
                if (stage.stage == TriggerStage.refreshing) {
                  return Text(localizations.refreshTriggerRefreshing);
                }
                if (stage.stage == TriggerStage.completed) {
                  return Text(localizations.refreshTriggerComplete);
                }
                if (stage.extent.value < 1 ||
                    stage.stage == TriggerStage.idle) {
                  return Text(localizations.refreshTriggerPull);
                }
                return Text(localizations.refreshTriggerRelease);
              },
            ),
            if (stage.stage == TriggerStage.pulling)
              AnimatedBuilder(
                animation: stage.extent,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: (stage.extent.value * pi).clamp(0, pi),
                    child: const Icon(Icons.arrow_downward),
                  );
                },
              ),
            if (stage.stage == TriggerStage.refreshing)
              const CircularProgressIndicator(),
            if (stage.stage == TriggerStage.completed)
              AnimatedValueBuilder(
                initialValue: 0.0,
                value: 1.0,
                duration: const Duration(milliseconds: 150),
                builder: (context, value, child) {
                  return SizedBox(
                    width: 12.0 * theme.scaling,
                    height: 8.0 * theme.scaling,
                    child: CustomPaint(
                      painter: AnimatedCheckPainter(
                        progress: value,
                        color: theme.colorScheme.foreground,
                        strokeWidth: 1.5 * theme.scaling,
                      ),
                    ),
                  );
                },
              ),
          ],
        ).gap(8),
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

class _RefreshTriggerState extends State<RefreshTrigger>
    with SingleTickerProviderStateMixin {
  double _currentExtent = 0;
  bool _scrolling = false;
  TriggerStage _stage = TriggerStage.idle;

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
        left: !widget.reverse ? null : 0,
        right: !widget.reverse ? 0 : null,
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
    if (notification is ScrollStartNotification) {
      setState(() {
        _currentExtent = 0;
        _scrolling = true;
        _stage = TriggerStage.pulling;
      });
    } else if (notification is ScrollEndNotification) {
      setState(() {
        _scrolling = false;
        if (_currentExtent >= widget.minExtent) {
          _stage = TriggerStage.refreshing;
          if (widget.onRefresh != null) {
            widget.onRefresh!().then((_) {
              if (!mounted) {
                return;
              }
              setState(() {
                _stage = TriggerStage.completed;
                Future.delayed(widget.completeDuration, () {
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
        } else {
          _stage = TriggerStage.idle;
          _currentExtent = 0;
        }
      });
    } else if (notification is ScrollUpdateNotification) {
      var delta = notification.scrollDelta;
      if (delta != null && (widget.reverse ? delta < 0 : delta > 0)) {
        setState(() {
          _currentExtent -= delta;
        });
      }
    } else if (notification is OverscrollNotification) {
      setState(() {
        _currentExtent -= notification.overscroll;
      });
    }
    return false;
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
                              child: widget.indicatorBuilder(
                                context,
                                RefreshTriggerStage(
                                  _stage,
                                  tween.animate(animation),
                                  widget.direction,
                                ),
                              ),
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
