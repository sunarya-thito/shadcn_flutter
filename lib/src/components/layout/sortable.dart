import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

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
  final SortableData<T> data;
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
  final GlobalKey key = GlobalKey();
  final Matrix4 transform;
  final Size size;
  final Widget ghost;
  final Widget placeholder;
  final SortableData<T> data;
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
      children: [
        Positioned.fill(
          child: MetaData(
            behavior: HitTestBehavior.translucent,
            metaData: this,
          ),
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

class _DropTransform {
  final Matrix4 from;
  final Matrix4 to;
  final Widget child;
  final _SortableState state;

  Duration? start;

  final ValueNotifier<double> progress = ValueNotifier(0);

  _DropTransform({
    required this.from,
    required this.to,
    required this.child,
    required this.state,
  });
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
  final ValueNotifier<bool> _hasClaimedDrop = ValueNotifier(false);
  final ValueNotifier<bool> _hasDraggedOff = ValueNotifier(false);

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
  bool _claimUnchanged = false;
  _SortableDraggingSession<T>? _session;

  _ScrollableSortableLayerState? _scrollableLayer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollableLayer = Data.maybeOf<_ScrollableSortableLayerState>(context);
  }

  void _onDragStart(DragStartDetails details) {
    if (_hasClaimedDrop.value) {
      return;
    }
    _hasDraggedOff.value = false;
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
    final ghost = widget.ghost ?? widget.child;
    final candidateFallback = widget.candidateFallback;
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
            return candidateFallback ?? widget.child;
          }
          return ghost;
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
      RenderBox sessionRenderBox =
          _session!.layer.context.findRenderObject() as RenderBox;
      Size size = sessionRenderBox.size;
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
        if (_currentTarget.value != null && fallback == null) {
          _currentTarget.value!.dispose(_session!);
          _currentTarget.value = null;
        }
      } else {
        _hasDraggedOff.value = true;
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
    if (_hasClaimedDrop.value) {
      return;
    }
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
        var sortData = _session!.data;
        if (predicate == null || predicate(sortData)) {
          var callback = target._getCallback(location);
          if (callback != null) {
            callback(sortData);
          }
        }
        _session!.layer.removeDraggingSession(_session!);
        _currentTarget.value = null;
      } else if (_hasDraggedOff.value) {
        var target = _currentFallback.value;
        if (target != null) {
          var sortData = _session!.data;
          if (target.widget.canAccept == null ||
              target.widget.canAccept!(sortData)) {
            target.widget.onAccept?.call(sortData);
          }
        }
        _session!.layer.removeDraggingSession(_session!);
        if (target == null) {
          _session!.layer._claimDrop(this, _session!.data, true);
        }
      } else {
        // basically the same as drag cancel, because the drag has not been
        // dragged off of itself
        _session!.layer.removeDraggingSession(_session!);
        _session!.layer._claimDrop(this, _session!.data, true);
      }
      _claimUnchanged = true;
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
      _session!.layer._claimDrop(this, _session!.data, true);
      _session = null;
    }
    setState(() {
      _dragging = false;
    });
    widget.onDragCancel?.call();
    _scrollableLayer?._endDrag(this);
  }

  @override
  void initState() {
    super.initState();
    final layer = Data.maybeFind<_SortableLayerState>(context);
    if (layer != null) {
      var data = widget.data;
      if (layer._canClaimDrop(this, data)) {
        _hasClaimedDrop.value = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (mounted) {
            layer._claimDrop(this, data);
          }
        });
      }
    }
  }

  @override
  void didUpdateWidget(covariant Sortable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      if (!widget.enabled && _dragging) {
        _onDragCancel();
      }
    }
    if (widget.data != oldWidget.data || _claimUnchanged) {
      _claimUnchanged = false;
      final layer = Data.maybeFind<_SortableLayerState>(context);
      if (layer != null && layer._canClaimDrop(this, widget.data)) {
        _hasClaimedDrop.value = true;
        final data = widget.data;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (mounted) {
            layer._claimDrop(this, data);
          }
        });
      }
    }
  }

  final GlobalKey _key = GlobalKey();
  final GlobalKey _gestureKey = GlobalKey();

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
      // must define the generic type to avoid type inference _SortableState<T>
      child: Data<_SortableState>.inherit(
        data: this,
        child: ListenableBuilder(
          listenable: layer._sessions,
          builder: (context, child) {
            bool hasCandidate = layer._sessions.value.isNotEmpty;
            Widget container = GestureDetector(
              key: _gestureKey,
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
                                    listenable: _hasDraggedOff,
                                    builder: (context, child) {
                                      return (_hasDraggedOff.value
                                          ? AbsorbPointer(
                                              child: Visibility(
                                                visible: false,
                                                maintainState: true,
                                                child: KeyedSubtree(
                                                  key: _key,
                                                  child: widget.child,
                                                ),
                                              ),
                                            )
                                          : AbsorbPointer(
                                              child: Visibility(
                                                maintainSize: true,
                                                maintainAnimation: true,
                                                maintainState: true,
                                                visible: false,
                                                child: KeyedSubtree(
                                                  key: _key,
                                                  child: widget.child,
                                                ),
                                              ),
                                            ));
                                    },
                                  )
                              : ListenableBuilder(
                                  listenable: _hasClaimedDrop,
                                  builder: (context, child) {
                                    return IgnorePointer(
                                      ignoring:
                                          hasCandidate || _hasClaimedDrop.value,
                                      child: Visibility(
                                        maintainSize: true,
                                        maintainAnimation: true,
                                        maintainState: true,
                                        visible: !_hasClaimedDrop.value,
                                        child: KeyedSubtree(
                                          key: _key,
                                          child: widget.child,
                                        ),
                                      ),
                                    );
                                  },
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => _dragging;
}

class SortableDragHandle extends StatefulWidget {
  final Widget child;
  final bool enabled;
  final HitTestBehavior? behavior;
  final MouseCursor? cursor;

  const SortableDragHandle(
      {super.key,
      required this.child,
      this.enabled = true,
      this.behavior,
      this.cursor});

  @override
  State<SortableDragHandle> createState() => _SortableDragHandleState();
}

class _SortableDragHandleState extends State<SortableDragHandle>
    with AutomaticKeepAliveClientMixin {
  _SortableState? _state;

  bool _dragging = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = Data.maybeOf<_SortableState>(context);
  }

  @override
  bool get wantKeepAlive {
    return _dragging;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MouseRegion(
      cursor: widget.enabled
          ? (widget.cursor ?? SystemMouseCursors.grab)
          : MouseCursor.defer,
      hitTestBehavior: widget.behavior,
      child: GestureDetector(
        behavior: widget.behavior,
        onPanStart: widget.enabled && _state != null
            ? (details) {
                _dragging = true;
                _state!._onDragStart(details);
              }
            : null,
        onPanUpdate:
            widget.enabled && _state != null ? _state!._onDragUpdate : null,
        onPanEnd: widget.enabled && _state != null
            ? (details) {
                _state!._onDragEnd(details);
                _dragging = false;
              }
            : null,
        onPanCancel: widget.enabled && _state != null
            ? () {
                _state!._onDragCancel();
                _dragging = false;
              }
            : null,
        child: widget.child,
      ),
    );
  }
}

@immutable
class SortableData<T> {
  final T data;

  const SortableData(this.data);

  @override
  @nonVirtual
  bool operator ==(Object other) => super == other;

  @override
  @nonVirtual
  int get hashCode => super.hashCode;

  @override
  String toString() => 'SortableData($data)';
}

class SortableLayer extends StatefulWidget {
  final Widget child;
  final bool lock;
  final Clip? clipBehavior;
  final Duration? dropDuration;
  final Curve? dropCurve;
  const SortableLayer({
    super.key,
    this.lock = false,
    this.clipBehavior,
    this.dropDuration,
    this.dropCurve,
    required this.child,
  });

  @override
  State<SortableLayer> createState() => _SortableLayerState();
}

class _PendingDropTransform {
  final Matrix4 from;
  final Widget child;
  final SortableData data;

  _PendingDropTransform({
    required this.from,
    required this.child,
    required this.data,
  });
}

class _SortableLayerState extends State<SortableLayer>
    with SingleTickerProviderStateMixin {
  final MutableNotifier<List<_SortableDraggingSession>> _sessions =
      MutableNotifier([]);
  final MutableNotifier<List<_DropTransform>> _activeDrops =
      MutableNotifier([]);

  // _PendingDropTransform? _pendingDrop;
  final ValueNotifier<_PendingDropTransform?> _pendingDrop =
      ValueNotifier(null);

  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
  }

  bool _canClaimDrop(_SortableState item, Object? data) {
    return _pendingDrop.value != null && data == _pendingDrop.value!.data;
  }

  _DropTransform? _claimDrop(_SortableState item, SortableData data,
      [bool force = false]) {
    if (_pendingDrop.value != null &&
        (force || data == _pendingDrop.value!.data)) {
      RenderBox layerRenderBox = context.findRenderObject() as RenderBox;
      RenderBox itemRenderBox = item.context.findRenderObject() as RenderBox;
      var dropTransform = _DropTransform(
        from: _pendingDrop.value!.from,
        to: itemRenderBox.getTransformTo(layerRenderBox),
        child: _pendingDrop.value!.child,
        state: item,
      );
      _activeDrops.mutate((value) {
        value.add(dropTransform);
      });
      item._hasClaimedDrop.value = true;
      _pendingDrop.value = null;
      if (!_ticker.isActive) {
        _ticker.start();
      }
      return dropTransform;
    }
    return null;
  }

  void _tick(Duration elapsed) {
    List<_DropTransform> toRemove = [];
    for (final drop in _activeDrops.value) {
      drop.start ??= elapsed;
      double progress = ((elapsed - drop.start!).inMilliseconds /
              (widget.dropDuration ?? kDefaultDuration).inMilliseconds)
          .clamp(0, 1);
      progress = (widget.dropCurve ?? Curves.easeInOut).transform(progress);
      if (progress >= 1) {
        drop.state._hasClaimedDrop.value = false;
        toRemove.add(drop);
      } else {
        drop.progress.value = progress;
      }
    }
    _activeDrops.mutate((value) {
      value.removeWhere((element) => toRemove.contains(element));
    });
    if (_activeDrops.value.isEmpty) {
      _ticker.stop();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  Matrix4 _tweenMatrix(Matrix4 from, Matrix4 to, double progress) {
    return Matrix4Tween(
      begin: from,
      end: to,
    ).transform(progress);
  }

  void pushDraggingSession(_SortableDraggingSession session) {
    _sessions.mutate(
      (value) {
        value.add(session);
      },
    );
  }

  void removeDraggingSession(_SortableDraggingSession session) {
    if (!mounted) {
      return;
    }
    if (_sessions.value.contains(session)) {
      _sessions.mutate((value) {
        value.remove(session);
      });
      if (widget.dropDuration != Duration.zero) {
        RenderBox? ghostRenderBox =
            session.key.currentContext?.findRenderObject() as RenderBox?;
        if (ghostRenderBox != null) {
          RenderBox layerRenderBox = context.findRenderObject() as RenderBox;
          _pendingDrop.value = _PendingDropTransform(
            from: ghostRenderBox.getTransformTo(layerRenderBox),
            child: SizedBox.fromSize(
              size: session.size,
              child: session.ghost,
            ),
            data: session.data,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MetaData(
      metaData: this,
      behavior: HitTestBehavior.translucent,
      child: Data.inherit(
        data: this,
        child: Stack(
          fit: StackFit.passthrough,
          clipBehavior:
              widget.clipBehavior ?? (widget.lock ? Clip.hardEdge : Clip.none),
          children: [
            widget.child,
            ListenableBuilder(
              listenable: _sessions,
              builder: (context, child) {
                return Positioned.fill(
                  child: MouseRegion(
                    opaque: false,
                    hitTestBehavior: HitTestBehavior.translucent,
                    cursor: _sessions.value.isNotEmpty
                        ? SystemMouseCursors.grabbing
                        : MouseCursor.defer,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
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
                                      key: session.key,
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
                  ),
                );
              },
            ),
            ListenableBuilder(
              listenable: _activeDrops,
              builder: (context, child) {
                return Positioned.fill(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      for (final drop in _activeDrops.value)
                        ListenableBuilder(
                          listenable: drop.progress,
                          builder: (context, child) {
                            return IgnorePointer(
                              child: Transform(
                                transform: _tweenMatrix(
                                  drop.from,
                                  drop.to,
                                  drop.progress.value,
                                ),
                                child: drop.child,
                              ),
                            );
                          },
                        ),
                      child!,
                    ],
                  ),
                );
              },
              child: ListenableBuilder(
                listenable: _pendingDrop,
                builder: (context, child) {
                  if (_pendingDrop.value != null) {
                    return IgnorePointer(
                      child: Transform(
                        transform: _pendingDrop.value!.from,
                        child: _pendingDrop.value!.child,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
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

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
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
      for (var pos in widget.controller.positions) {
        pos.pointerScroll(scrollDelta);
      }
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
