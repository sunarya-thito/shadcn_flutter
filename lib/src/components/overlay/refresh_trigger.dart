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
  TriggerStage _stage = TriggerStage.idle;

  double _calculateSafeExtent(double extent) {
    return extent;
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
    if (notification is ScrollStartNotification) {
      setState(() {
        _scrolling = true;
      });
    }
    return false;
  }

  bool _handleOverscrollNotification(
      OverscrollIndicatorNotification notification) {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: _handleOverscrollNotification,
        child: AnimatedValueBuilder.animation(
          // value: _currentExtent,
          value: _stage == TriggerStage.refreshing ||
                  _stage == TriggerStage.completed
              ? widget.minExtent
              : _currentExtent,
          duration: _scrolling ? Duration.zero : kDefaultDuration,
          curve: Curves.easeInOut,
          builder: (context, animation) {
            Tween<double> tween = Tween<double>(
              begin: 0.0,
              end: widget.minExtent,
            );
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
                                    ? Offset(0,
                                        _calculateSafeExtent(animation.value))
                                    : Offset(
                                        _calculateSafeExtent(animation.value),
                                        0),
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
