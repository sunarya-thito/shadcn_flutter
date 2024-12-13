import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableData<T> {
  final T data;
  final Matrix4 transform;
  final Size size;

  SortableData({
    required this.data,
    required this.transform,
    required this.size,
  });
}

class Sortable<T> extends StatefulWidget {
  final Predicate<SortableData<T>>? canAcceptTop;
  final Predicate<SortableData<T>>? canAcceptLeft;
  final Predicate<SortableData<T>>? canAcceptRight;
  final Predicate<SortableData<T>>? canAcceptBottom;
  final ValueChanged<SortableData<T>>? onAcceptTop;
  final ValueChanged<SortableData<T>>? onAcceptLeft;
  final ValueChanged<SortableData<T>>? onAcceptRight;
  final ValueChanged<SortableData<T>>? onAcceptBottom;
  final VoidCallback? onDragStart;
  final VoidCallback? onDragEnd;
  final VoidCallback? onDragCancel;
  final Widget child;
  final T data;
  final Widget? placeholder;
  final Widget? ghost;
  final Widget? fallback;
  final Widget? candidateFallback;
  final bool enabled;
  final HitTestBehavior behavior;
  const Sortable({
    super.key,
    this.enabled = true,
    required this.data,
    this.canAcceptTop,
    this.canAcceptLeft,
    this.canAcceptRight,
    this.canAcceptBottom,
    this.onAcceptTop,
    this.onAcceptLeft,
    this.onAcceptRight,
    this.onAcceptBottom,
    this.placeholder = const SizedBox(),
    this.ghost,
    this.fallback,
    this.candidateFallback,
    this.onDragStart,
    this.onDragEnd,
    this.onDragCancel,
    this.behavior = HitTestBehavior.deferToChild,
    required this.child,
  });

  @override
  State<Sortable<T>> createState() => _SortableState<T>();
}

class _SortableDraggingSession<T> {
  final Matrix4 transform;
  final Size size;
  final Widget ghost;
  final Widget placeholder;
  final T data;
  final ValueNotifier<Offset> offset;
  final _SortableLayerState layer;
  final RenderBox layerRenderBox;
  final Offset minOffset;
  final Offset maxOffset;
  final bool lock;
  final _SortableState<T> target;
  _SortableDraggingSession({
    required this.target,
    required this.layer,
    required this.layerRenderBox,
    required this.maxOffset,
    required this.transform,
    required this.size,
    required this.ghost,
    required this.placeholder,
    required this.data,
    required this.minOffset,
    required this.lock,
    required Offset offset,
  }) : offset = ValueNotifier(offset);
}

enum _SortableDropLocation {
  top,
  left,
  right,
  bottom,
}

_SortableDropLocation? getPosition(Offset position, Size size,
    {bool acceptTop = false,
    bool acceptLeft = false,
    bool acceptRight = false,
    bool acceptBottom = false}) {
  double dx = position.dx;
  double dy = position.dy;
  double width = size.width;
  double height = size.height;
  if (acceptTop && !acceptBottom) {
    return _SortableDropLocation.top;
  } else if (acceptBottom && !acceptTop) {
    return _SortableDropLocation.bottom;
  } else if (acceptLeft && !acceptRight) {
    return _SortableDropLocation.left;
  } else if (acceptRight && !acceptLeft) {
    return _SortableDropLocation.right;
  }
  if (acceptTop && dy <= height / 2) {
    return _SortableDropLocation.top;
  }
  if (acceptLeft && dx <= width / 2) {
    return _SortableDropLocation.left;
  }
  if (acceptRight && dx >= width / 2) {
    return _SortableDropLocation.right;
  }
  if (acceptBottom && dy >= height / 2) {
    return _SortableDropLocation.bottom;
  }
  return null;
}

class SortableDropFallback<T> extends StatefulWidget {
  final ValueChanged<SortableData<T>>? onAccept;
  final Predicate<SortableData<T>>? canAccept;
  final Widget child;

  const SortableDropFallback({
    super.key,
    required this.child,
    this.onAccept,
    this.canAccept,
  });

  @override
  State<SortableDropFallback<T>> createState() =>
      _SortableDropFallbackState<T>();
}

class _SortableDropFallbackState<T> extends State<SortableDropFallback<T>> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        MetaData(
          behavior: HitTestBehavior.translucent,
          metaData: this,
        ),
        widget.child,
      ],
    );
  }
}

class _DroppingTarget<T> {
  final _SortableState<T> source;
  final ValueNotifier<_SortableDraggingSession<T>?> candidate;
  final _SortableDropLocation location;

  _DroppingTarget({
    required this.source,
    required this.candidate,
    required this.location,
  });

  void dispose(_SortableDraggingSession<T> target) {
    if (candidate.value == target) {
      candidate.value = null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _DroppingTarget<T> &&
        other.source == source &&
        other.candidate == candidate &&
        other.location == location;
  }

  @override
  int get hashCode => Object.hash(source, candidate, location);

  @override
  String toString() => '_DroppingTarget($source, $location)';
}

class _SortableState<T> extends State<Sortable<T>>
    with AutomaticKeepAliveClientMixin {
  final ValueNotifier<_SortableDraggingSession<T>?> topCandidate =
      ValueNotifier(null);
  final ValueNotifier<_SortableDraggingSession<T>?> leftCandidate =
      ValueNotifier(null);
  final ValueNotifier<_SortableDraggingSession<T>?> rightCandidate =
      ValueNotifier(null);
  final ValueNotifier<_SortableDraggingSession<T>?> bottomCandidate =
      ValueNotifier(null);

  final ValueNotifier<_DroppingTarget<T>?> _currentTarget = ValueNotifier(null);
  final ValueNotifier<_SortableDropFallbackState<T>?> _currentFallback =
      ValueNotifier(null);

  (_SortableState<T>, Offset)? _findState(
      _SortableLayerState target, Offset globalPosition) {
    BoxHitTestResult result = BoxHitTestResult();
    RenderBox renderBox = target.context.findRenderObject() as RenderBox;
    renderBox.hitTest(result, position: globalPosition);
    for (final HitTestEntry entry in result.path) {
      if (entry.target is RenderMetaData) {
        RenderMetaData metaData = entry.target as RenderMetaData;
        if (metaData.metaData is _SortableState<T> &&
            metaData.metaData != this) {
          return (
            metaData.metaData as _SortableState<T>,
            (entry as BoxHitTestEntry).localPosition
          );
        }
      }
    }
    return null;
  }

  _SortableDropFallbackState<T>? _findFallbackState(
      _SortableLayerState target, Offset globalPosition) {
    BoxHitTestResult result = BoxHitTestResult();
    RenderBox renderBox = target.context.findRenderObject() as RenderBox;
    renderBox.hitTest(result, position: globalPosition);
    for (final HitTestEntry entry in result.path) {
      if (entry.target is RenderMetaData) {
        RenderMetaData metaData = entry.target as RenderMetaData;
        if (metaData.metaData is _SortableDropFallbackState<T> &&
            metaData.metaData != this) {
          return metaData.metaData as _SortableDropFallbackState<T>;
        }
      }
    }
    return null;
  }

  bool _dragging = false;
  _SortableDraggingSession<T>? _session;

  _ScrollableSortableLayerState? _scrollableLayer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollableLayer = Data.maybeOf<_ScrollableSortableLayerState>(context);
  }

  void _onDragStart(DragStartDetails details) {
    _SortableLayerState? layer = Data.maybeFind<_SortableLayerState>(context);
    assert(layer != null, 'Sortable must be a descendant of SortableLayer');
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    RenderBox layerRenderBox = layer!.context.findRenderObject() as RenderBox;
    Matrix4 transform = renderBox.getTransformTo(layerRenderBox);
    Size size = renderBox.size;
    Offset minOffset = MatrixUtils.transformPoint(transform, Offset.zero);
    Offset maxOffset = MatrixUtils.transformPoint(
      transform,
      Offset(size.width, size.height),
    );
    _session = _SortableDraggingSession(
      layer: layer,
      layerRenderBox: layerRenderBox,
      target: this,
      transform: transform,
      size: size,
      ghost: ListenableBuilder(
        listenable: _currentTarget,
        builder: (context, child) {
          if (_currentTarget.value != null) {
            return widget.candidateFallback ?? widget.ghost ?? widget.child;
          }
          return widget.ghost ?? widget.child;
        },
      ),
      placeholder: widget.placeholder ?? widget.child,
      data: widget.data,
      minOffset: minOffset,
      maxOffset: maxOffset,
      lock: layer.widget.lock,
      offset: Offset.zero,
    );
    layer.pushDraggingSession(_session!);
    widget.onDragStart?.call();
    setState(() {
      _dragging = true;
    });
    _scrollableLayer?._startDrag(this, details.globalPosition);
  }

  ValueNotifier<_SortableDraggingSession<T>?> _getByLocation(
      _SortableDropLocation location) {
    switch (location) {
      case _SortableDropLocation.top:
        return topCandidate;
      case _SortableDropLocation.left:
        return leftCandidate;
      case _SortableDropLocation.right:
        return rightCandidate;
      case _SortableDropLocation.bottom:
        return bottomCandidate;
    }
  }

  void _handleDrag(Offset delta) {
    Offset minOffset = _session!.minOffset;
    Offset maxOffset = _session!.maxOffset;
    if (_session != null) {
      Size size = _session!.layer.context.size!;
      if (_session!.lock) {
        double minX = -minOffset.dx;
        double maxX = size.width - maxOffset.dx;
        double minY = -minOffset.dy;
        double maxY = size.height - maxOffset.dy;
        _session!.offset.value = Offset(
          (_session!.offset.value.dx + delta.dx).clamp(
            min(minX, maxX),
            max(minX, maxX),
          ),
          (_session!.offset.value.dy + delta.dy).clamp(
            min(minY, maxY),
            max(minY, maxY),
          ),
        );
      } else {
        _session!.offset.value += delta;
      }
      Offset globalPosition = _session!.offset.value +
          minOffset +
          Offset((maxOffset.dx - minOffset.dx) / 2,
              (maxOffset.dy - minOffset.dy) / 2);
      (_SortableState<T>, Offset)? target =
          _findState(_session!.layer, globalPosition);
      if (target == null) {
        _SortableDropFallbackState<T>? fallback =
            _findFallbackState(_session!.layer, globalPosition);
        _currentFallback.value = fallback;
        if (_currentTarget.value != null) {
          _currentTarget.value!.dispose(_session!);
          _currentTarget.value = null;
        }
      } else {
        _currentFallback.value = null;
        if (_currentTarget.value != null) {
          _currentTarget.value!.dispose(_session!);
        }
        var targetRenderBox = target.$1.context.findRenderObject() as RenderBox;
        var size = targetRenderBox.size;
        _SortableDropLocation? location = getPosition(
          target.$2,
          size,
          acceptTop: widget.onAcceptTop != null,
          acceptLeft: widget.onAcceptLeft != null,
          acceptRight: widget.onAcceptRight != null,
          acceptBottom: widget.onAcceptBottom != null,
        );
        if (location != null) {
          ValueNotifier<_SortableDraggingSession<T>?> candidate =
              target.$1._getByLocation(location);

          candidate.value = _session;
          _currentTarget.value = _DroppingTarget(
              candidate: candidate, source: target.$1, location: location);
        }
      }
    }
  }

  ValueChanged<SortableData<T>>? _getCallback(_SortableDropLocation location) {
    switch (location) {
      case _SortableDropLocation.top:
        return widget.onAcceptTop;
      case _SortableDropLocation.left:
        return widget.onAcceptLeft;
      case _SortableDropLocation.right:
        return widget.onAcceptRight;
      case _SortableDropLocation.bottom:
        return widget.onAcceptBottom;
    }
  }

  Predicate<SortableData<T>>? _getPredicate(_SortableDropLocation location) {
    switch (location) {
      case _SortableDropLocation.top:
        return widget.canAcceptTop;
      case _SortableDropLocation.left:
        return widget.canAcceptLeft;
      case _SortableDropLocation.right:
        return widget.canAcceptRight;
      case _SortableDropLocation.bottom:
        return widget.canAcceptBottom;
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _handleDrag(details.delta);
    _scrollableLayer?._updateDrag(this, details.globalPosition);
  }

  void _onDragEnd(DragEndDetails details) {
    if (_session != null) {
      if (_currentTarget.value != null) {
        widget.onDragEnd?.call();
        _currentTarget.value!.dispose(_session!);
        var target = _currentTarget.value!.source;
        var location = _currentTarget.value!.location;
        var predicate = target._getPredicate(location);
        var sortData = SortableData(
          data: _session!.data,
          transform: _session!.transform,
          size: _session!.size,
        );
        if (predicate == null || predicate(sortData)) {
          var callback = target._getCallback(location);
          if (callback != null) {
            callback(sortData);
          }
        }
        _currentTarget.value = null;
      } else {
        var target = _currentFallback.value;
        if (target != null) {
          var sortData = SortableData(
            data: _session!.data,
            transform: _session!.transform,
            size: _session!.size,
          );
          if (target.widget.canAccept == null ||
              target.widget.canAccept!(sortData)) {
            target.widget.onAccept?.call(sortData);
          }
        }
      }
      _session!.layer.removeDraggingSession(_session!);
      _session = null;
    }
    setState(() {
      _dragging = false;
    });
    _scrollableLayer?._endDrag(this);
  }

  void _onDragCancel() {
    if (_session != null) {
      if (_currentTarget.value != null) {
        _currentTarget.value!.dispose(_session!);
        _currentTarget.value = null;
      }
      _session!.layer.removeDraggingSession(_session!);
      _session = null;
    }
    setState(() {
      _dragging = false;
    });
    widget.onDragCancel?.call();
    _scrollableLayer?._endDrag(this);
  }

  @override
  void didUpdateWidget(covariant Sortable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (!widget.enabled && _dragging) {
        _onDragCancel();
      }
    }
  }

  final GlobalKey _key = GlobalKey();

  Widget _buildAnimatedSize({
    AlignmentGeometry alignment = Alignment.center,
    Widget? child,
    bool hasCandidate = false,
    required Duration duration,
  }) {
    if (!hasCandidate) {
      return child!;
    }
    return AnimatedSize(
      duration: duration,
      alignment: alignment,
      child: child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_dragging) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _scrollableLayer?._endDrag(this);
        _session!.layer.removeDraggingSession(_session!);
        _currentTarget.value = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final layer = Data.of<_SortableLayerState>(context);
    return MetaData(
      behavior: HitTestBehavior.translucent,
      metaData: this,
      child: ListenableBuilder(
        listenable: layer._sessions,
        builder: (context, child) {
          bool hasCandidate = layer._sessions.value.isNotEmpty;
          Widget container = GestureDetector(
            key: _key,
            behavior: widget.behavior,
            onPanStart: widget.enabled ? _onDragStart : null,
            onPanUpdate: widget.enabled ? _onDragUpdate : null,
            onPanEnd: widget.enabled ? _onDragEnd : null,
            onPanCancel: widget.enabled ? _onDragCancel : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AbsorbPointer(
                  child: _buildAnimatedSize(
                    duration: kDefaultDuration,
                    alignment: Alignment.centerRight,
                    hasCandidate: hasCandidate,
                    child: ListenableBuilder(
                      listenable: leftCandidate,
                      builder: (context, child) {
                        if (leftCandidate.value != null) {
                          return SizedBox.fromSize(
                            size: leftCandidate.value!.size,
                            child: leftCandidate.value!.placeholder,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AbsorbPointer(
                        child: _buildAnimatedSize(
                          duration: kDefaultDuration,
                          alignment: Alignment.bottomCenter,
                          hasCandidate: hasCandidate,
                          child: ListenableBuilder(
                            listenable: topCandidate,
                            builder: (context, child) {
                              if (topCandidate.value != null) {
                                return SizedBox.fromSize(
                                  size: topCandidate.value!.size,
                                  child: topCandidate.value!.placeholder,
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: _dragging
                            ? widget.fallback ??
                                ListenableBuilder(
                                  listenable: Listenable.merge([
                                    _currentTarget,
                                    _currentFallback,
                                  ]),
                                  builder: (context, child) {
                                    return (_currentTarget.value != null ||
                                            _currentFallback.value != null
                                        ? const AbsorbPointer()
                                        : AbsorbPointer(
                                            child: Visibility(
                                              maintainSize: true,
                                              maintainAnimation: true,
                                              maintainState: true,
                                              visible: false,
                                              child: widget.child,
                                            ),
                                          ));
                                  },
                                )
                            : IgnorePointer(
                                ignoring: hasCandidate,
                                child: widget.child,
                              ),
                      ),
                      AbsorbPointer(
                        child: _buildAnimatedSize(
                          duration: kDefaultDuration,
                          alignment: Alignment.topCenter,
                          hasCandidate: hasCandidate,
                          child: ListenableBuilder(
                            listenable: bottomCandidate,
                            builder: (context, child) {
                              if (bottomCandidate.value != null) {
                                return SizedBox.fromSize(
                                  size: bottomCandidate.value!.size,
                                  child: bottomCandidate.value!.placeholder,
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AbsorbPointer(
                  child: _buildAnimatedSize(
                    duration: kDefaultDuration,
                    alignment: Alignment.centerLeft,
                    hasCandidate: hasCandidate,
                    child: ListenableBuilder(
                      listenable: rightCandidate,
                      builder: (context, child) {
                        if (rightCandidate.value != null) {
                          return SizedBox.fromSize(
                            size: rightCandidate.value!.size,
                            child: rightCandidate.value!.placeholder,
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
          if (!hasCandidate) {
            return container;
          }
          return AnimatedSize(
            duration: kDefaultDuration,
            child: container,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => _dragging;
}

class SortableLayer extends StatefulWidget {
  final Widget child;
  final bool lock;
  const SortableLayer({
    super.key,
    this.lock = false,
    required this.child,
  });

  @override
  State<SortableLayer> createState() => _SortableLayerState();
}

class _SortableLayerState extends State<SortableLayer> {
  final MutableNotifier<List<_SortableDraggingSession>> _sessions =
      MutableNotifier([]);
  void pushDraggingSession(_SortableDraggingSession session) {
    setState(() {
      _sessions.mutate(
        (value) {
          value.add(session);
        },
      );
    });
  }

  void removeDraggingSession(_SortableDraggingSession session) {
    if (_sessions.value.contains(session)) {
      setState(() {
        _sessions.mutate((value) {
          value.remove(session);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: this,
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: widget.lock ? Clip.hardEdge : Clip.none,
        children: [
          widget.child,
          for (final session in _sessions.value)
            ListenableBuilder(
              listenable: session.offset,
              builder: (context, child) {
                return Positioned(
                  left: session.offset.value.dx,
                  top: session.offset.value.dy,
                  child: IgnorePointer(
                    child: Transform(
                      transform: session.transform,
                      child: SizedBox.fromSize(
                        size: session.size,
                        child: session.ghost,
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class ScrollableSortableLayer extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final double scrollThreshold;
  final bool overscroll;

  const ScrollableSortableLayer({
    super.key,
    required this.child,
    required this.controller,
    this.scrollThreshold = 50,
    this.overscroll = false,
  });

  @override
  State<ScrollableSortableLayer> createState() =>
      _ScrollableSortableLayerState();
}

class _ScrollableSortableLayerState extends State<ScrollableSortableLayer>
    with SingleTickerProviderStateMixin {
  late Ticker ticker;

  @override
  void initState() {
    super.initState();
    ticker = createTicker(_scroll);
  }

  _SortableState? _attached;
  Offset? _globalPosition;
  Duration? _lastElapsed;
  void _scroll(Duration elapsed) {
    var position = _globalPosition;
    if (position != null && _lastElapsed != null) {
      var renderBox = context.findRenderObject() as RenderBox;
      position = renderBox.globalToLocal(position);
      int delta = elapsed.inMicroseconds - _lastElapsed!.inMicroseconds;
      double scrollDelta = 0;
      var pos = widget.controller.position.axisDirection == AxisDirection.down
          ? position.dy
          : position.dx;
      var size = widget.controller.position.axisDirection == AxisDirection.down
          ? renderBox.size.height
          : renderBox.size.width;
      if (pos < widget.scrollThreshold) {
        scrollDelta = -delta / 10000;
      } else if (pos > size - widget.scrollThreshold) {
        scrollDelta = delta / 10000;
      }
      var newPosition = widget.controller.offset + scrollDelta;
      // newPosition =
      //     newPosition.clamp(0, widget.controller.position.maxScrollExtent);
      widget.controller.jumpTo(newPosition);
      _attached?._handleDrag(Offset.zero);
    }
    _lastElapsed = elapsed;
  }

  void _startDrag(_SortableState state, Offset globalPosition) {
    if (_attached != null && _attached!.context.mounted) {
      return;
    }
    _attached = state;
    _globalPosition = globalPosition;
    if (!ticker.isActive) {
      ticker.start();
    }
  }

  void _updateDrag(_SortableState state, Offset globalPosition) {
    if (state != _attached) {
      return;
    }
    _globalPosition = globalPosition;
  }

  void _endDrag(_SortableState state) {
    if (state != _attached) {
      return;
    }
    if (ticker.isActive) {
      ticker.stop();
    }
    _globalPosition = null;
    _attached = null;
  }

  @override
  Widget build(BuildContext context) {
    return Data.inherit(
      data: this,
      child: widget.child,
    );
  }
}
