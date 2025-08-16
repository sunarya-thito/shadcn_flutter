import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef SwitcherResponse = Widget? Function(
    BuildContext context, AxisDirection direction);

class Switcher extends StatefulWidget {
  final AxisDirection direction;
  final Widget child;
  final SwitcherResponse? onDrag;
  final Duration duration;
  final Curve curve;

  const Switcher({
    super.key,
    required this.direction,
    required this.child,
    this.onDrag,
    this.duration = kDefaultDuration,
    this.curve = Curves.easeInOut,
  });

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherQueue {
  final Widget oldWidget;
  final AxisDirection direction;
  final Duration duration;
  final Curve curve;
  double progress = 0;
  final bool absolute;

  _SwitcherQueue({
    required this.oldWidget,
    required this.direction,
    required this.duration,
    required this.curve,
    required this.absolute,
  });

  Offset get directionalOffset {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, -1);
      case AxisDirection.down:
        return const Offset(0, 1);
      case AxisDirection.left:
        return const Offset(-1, 0);
      case AxisDirection.right:
        return const Offset(1, 0);
    }
  }

  Widget _buildTransition(BuildContext context, Widget newChild) {
    final progress = this.progress.clamp(0.0, 1.0);
    return _SwitcherTransition(
        progress: progress,
        direction: direction,
        absolute: absolute,
        children: [
          Opacity(
            opacity: 1 - progress,
            child: oldWidget,
          ),
          Opacity(
            opacity: progress,
            child: newChild,
          ),
        ]);
  }
}

class _SwitcherState extends State<Switcher>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  Duration? _last;
  final List<_SwitcherQueue> _queue = [];
  _SwitcherQueue? _dragged;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
  }

  void _startTicker() {
    if (_ticker.isActive) {
      return;
    }
    _last = null;
    _ticker.start();
  }

  void _tick(Duration elapsed) {
    final delta = _last == null ? Duration.zero : elapsed - _last!;
    if (_queue.isNotEmpty) {
      final last = _queue.last;
      setState(() {
        last.progress += delta.inMilliseconds / last.duration.inMilliseconds;
      });
      if (last.progress >= 1) {
        _queue.removeLast();
      }
    } else {
      _ticker.stop();
    }
    _last = elapsed;
  }

  @override
  void didUpdateWidget(covariant Switcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child ||
        oldWidget.child.key != widget.child.key) {
      _queue.insert(
          0,
          _SwitcherQueue(
            oldWidget: oldWidget.child,
            direction: widget.direction,
            duration: widget.duration,
            curve: widget.curve,
            absolute: false,
          ));
      _startTicker();
    }
  }

  void _visitQueue(void Function(_SwitcherQueue item) visitor) {
    for (final queue in _queue) {
      visitor(queue);
    }
    if (_dragged != null) {
      visitor(_dragged!);
    }
  }

  Offset _filterDragOffset(Offset delta) {
    switch (widget.direction) {
      case AxisDirection.up:
      case AxisDirection.down:
        return Offset(0, delta.dy);
      case AxisDirection.left:
      case AxisDirection.right:
        return Offset(delta.dx, 0);
    }
  }

  AxisDirection _fromDelta(Offset delta) {
    if (delta.dy.abs() > delta.dx.abs()) {
      return delta.dy < 0 ? AxisDirection.up : AxisDirection.down;
    } else {
      return delta.dx < 0 ? AxisDirection.left : AxisDirection.right;
    }
  }

  Widget buildDraggable(BuildContext context, Widget child) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanUpdate: (details) {
        if (_dragged == null) {
          final direction = _fromDelta(details.delta);
          final newChild = widget.onDrag?.call(context, direction);
          if (newChild == null) {
            return;
          }
          _dragged = _SwitcherQueue(
            oldWidget: newChild,
            direction: direction,
            duration: widget.duration,
            curve: widget.curve,
            absolute: true,
          );
          return;
        }
        final delta = _filterDragOffset(details.delta);
        setState(() {
          _dragged!.progress += delta.distance;
        });
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentChild = widget.child;
    _visitQueue((item) {
      currentChild = item._buildTransition(context, currentChild);
    });
    if (widget.onDrag != null) {
      currentChild = buildDraggable(context, currentChild);
    }
    return currentChild;
  }
}

class _SwitcherTransition extends MultiChildRenderObjectWidget {
  final double progress;
  final AxisDirection direction;
  final bool absolute;

  const _SwitcherTransition({
    required this.progress,
    required this.direction,
    required this.absolute,
    required super.children,
  });

  @override
  _RenderSwitcherTransition createRenderObject(BuildContext context) {
    return _RenderSwitcherTransition()
      ..progress = progress
      ..direction = direction
      ..absolute = absolute;
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderSwitcherTransition renderObject) {
    if (renderObject.progress != progress ||
        renderObject.direction != direction ||
        renderObject.absolute != absolute) {
      renderObject.progress = progress;
      renderObject.direction = direction;
      renderObject.absolute = absolute;
      renderObject.markNeedsLayout();
    }
  }
}

class _SwitcherParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderSwitcherTransition extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _SwitcherParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _SwitcherParentData> {
  double progress = 0;
  AxisDirection direction = AxisDirection.down;
  bool absolute = false;

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parent != this) {
      child.parentData = _SwitcherParentData();
    }
  }

  double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }

  @override
  void performLayout() {
    if (firstChild == null || childAfter(firstChild!) == null) {
      size = Size.zero;
      return;
    }
    final oldChild = firstChild!;
    final newChild = childAfter(oldChild)!;

    oldChild.layout(constraints, parentUsesSize: true);
    newChild.layout(constraints, parentUsesSize: true);
    final oldSize = oldChild.size;
    final newSize = newChild.size;

    final oldData = oldChild.parentData! as _SwitcherParentData;
    final newData = newChild.parentData! as _SwitcherParentData;

    final lerpedSize = Size.lerp(oldSize, newSize, progress)!;

    if (absolute) {
      // 🎯 Centering logic is now applied to the absolute transition.
      switch (direction) {
        case AxisDirection.down:
        case AxisDirection.up:
          // For vertical slides, we center horizontally.
          final slideOffset = direction == AxisDirection.down
              ? Offset(0, _lerpDouble(0, newSize.height, progress))
              : Offset(0, _lerpDouble(0, -newSize.height, progress));

          // Calculate the horizontal centering offset for each child.
          final oldCenteringDx = (lerpedSize.width - oldSize.width) / 2;
          final newCenteringDx = (lerpedSize.width - newSize.width) / 2;

          oldData.offset = slideOffset + Offset(oldCenteringDx, 0);

          // Position the new child relative to the old one, but with its own centering.
          final newRelativePos = direction == AxisDirection.down
              ? slideOffset - Offset(0, newSize.height)
              : slideOffset + Offset(0, newSize.height);
          newData.offset = newRelativePos + Offset(newCenteringDx, 0);
          break;

        case AxisDirection.left:
        case AxisDirection.right:
          // For horizontal slides, we center vertically.
          final slideOffset = direction == AxisDirection.right
              ? Offset(_lerpDouble(0, newSize.width, progress), 0)
              : Offset(_lerpDouble(0, -newSize.width, progress), 0);

          // Calculate the vertical centering offset for each child.
          final oldCenteringDy = (lerpedSize.height - oldSize.height) / 2;
          final newCenteringDy = (lerpedSize.height - newSize.height) / 2;

          oldData.offset = slideOffset + Offset(0, oldCenteringDy);

          // Position the new child relative to the old one, but with its own centering.
          final newRelativePos = direction == AxisDirection.right
              ? slideOffset - Offset(newSize.width, 0)
              : slideOffset + Offset(newSize.width, 0);
          newData.offset = newRelativePos + Offset(0, newCenteringDy);
          break;
      }
    } else {
      // 🎯 Centering logic applied to the relative transition.
      switch (direction) {
        case AxisDirection.down:
        case AxisDirection.up:
          // For vertical slides, we center horizontally.
          final oldSlideOffset = direction == AxisDirection.down
              ? Offset.lerp(Offset.zero, Offset(0, newSize.height), progress)!
              : Offset.lerp(Offset.zero, Offset(0, -oldSize.height), progress)!;
          final newSlideOffset = direction == AxisDirection.down
              ? Offset.lerp(Offset(0, -newSize.height), Offset.zero, progress)!
              : Offset.lerp(Offset(0, oldSize.height), Offset.zero, progress)!;

          // Calculate the horizontal centering offset for each child.
          final oldCenteringDx = (lerpedSize.width - oldSize.width) / 2;
          final newCenteringDx = (lerpedSize.width - newSize.width) / 2;

          oldData.offset = oldSlideOffset + Offset(oldCenteringDx, 0);
          newData.offset = newSlideOffset + Offset(newCenteringDx, 0);
          break;

        case AxisDirection.left:
        case AxisDirection.right:
          // For horizontal slides, we center vertically.
          final oldSlideOffset = direction == AxisDirection.right
              ? Offset.lerp(Offset.zero, Offset(newSize.width, 0), progress)!
              : Offset.lerp(Offset.zero, Offset(-oldSize.width, 0), progress)!;
          final newSlideOffset = direction == AxisDirection.right
              ? Offset.lerp(Offset(-newSize.width, 0), Offset.zero, progress)!
              : Offset.lerp(Offset(oldSize.width, 0), Offset.zero, progress)!;

          // Calculate the vertical centering offset for each child.
          final oldCenteringDy = (lerpedSize.height - oldSize.height) / 2;
          final newCenteringDy = (lerpedSize.height - newSize.height) / 2;

          oldData.offset = oldSlideOffset + Offset(0, oldCenteringDy);
          newData.offset = newSlideOffset + Offset(0, newCenteringDy);
          break;
      }
    }
    size = constraints.constrain(lerpedSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
