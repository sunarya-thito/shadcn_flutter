import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A swipeable container that transitions between multiple child widgets.
///
/// [Switcher] provides smooth animated transitions between different views
/// with gesture-based navigation. Users can swipe to change the active view,
/// and the component supports all four axis directions for transitions.
///
/// Features include:
/// - Gesture-based drag navigation between views
/// - Smooth animated transitions with configurable duration and curve
/// - Support for all axis directions (up, down, left, right)
/// - Automatic snapping to the nearest index after dragging
/// - Programmatic control via index changes
///
/// The component uses a custom render object to handle smooth interpolation
/// between child sizes and positions during transitions.
///
/// **Note: This component is experimental and may change in future versions.**
///
/// Example:
/// ```dart
/// Switcher(
///   index: currentIndex,
///   direction: AxisDirection.right,
///   onIndexChanged: (newIndex) => setState(() => currentIndex = newIndex),
///   children: [
///     Container(color: Colors.red, child: Center(child: Text('Page 1'))),
///     Container(color: Colors.blue, child: Center(child: Text('Page 2'))),
///     Container(color: Colors.green, child: Center(child: Text('Page 3'))),
///   ],
/// );
/// ```
class Switcher extends StatefulWidget {
  /// Current active child index.
  final int index;

  /// Callback invoked when the active index changes through gestures.
  final ValueChanged<int>? onIndexChanged;

  /// Direction of the swipe transition animation.
  final AxisDirection direction;

  /// List of child widgets to switch between.
  final List<Widget> children;

  /// Duration of the transition animation.
  final Duration duration;

  /// Animation curve for the transition.
  final Curve curve;

  /// Creates a [Switcher].
  ///
  /// The [direction] and [children] parameters are required. The [index]
  /// determines which child is initially visible.
  ///
  /// Parameters:
  /// - [index] (int, default: 0): initial active child index
  /// - [direction] (AxisDirection, required): swipe transition direction
  /// - [children] (`List<Widget>`, required): child widgets to switch between
  /// - [onIndexChanged] (`ValueChanged<int>?`): called when index changes
  /// - [duration] (Duration, default: 300ms): transition animation duration
  /// - [curve] (Curve, default: Curves.easeInOut): transition animation curve
  ///
  /// Example:
  /// ```dart
  /// Switcher(
  ///   index: 0,
  ///   direction: AxisDirection.left,
  ///   duration: Duration(milliseconds: 250),
  ///   curve: Curves.easeOut,
  ///   onIndexChanged: (index) => print('Switched to $index'),
  ///   children: [
  ///     Text('First view'),
  ///     Text('Second view'),
  ///     Text('Third view'),
  ///   ],
  /// );
  /// ```
  const Switcher({
    super.key,
    this.index = 0,
    required this.direction,
    required this.children,
    this.onIndexChanged,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  late double _index;
  bool _dragging = false;

  @override
  void initState() {
    super.initState();
    _index = widget.index.toDouble();
  }

  @override
  void didUpdateWidget(covariant Switcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      _index = widget.index.toDouble();
      _dragging = false; // cancels out dragging
    }
  }

  /// Wraps child with gesture detection for drag-based navigation.
  ///
  /// Handles pan gestures to allow users to drag between different views.
  /// The drag distance is normalized based on the widget's size and direction.
  Widget buildDraggable(BuildContext context, Widget child) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        _dragging = true;
      },
      onPanUpdate: (details) {
        if (_dragging) {
          final currentSize = context.size!;
          double delta;
          switch (widget.direction) {
            case AxisDirection.up:
              delta = -details.delta.dy / currentSize.height;
              break;
            case AxisDirection.down:
              delta = details.delta.dy / currentSize.height;
              break;
            case AxisDirection.left:
              delta = -details.delta.dx / currentSize.width;
              break;
            case AxisDirection.right:
              delta = details.delta.dx / currentSize.width;
              break;
          }
          setState(() {
            _index += delta;
            _index = _index.clamp(0, widget.children.length - 1).toDouble();
          });
        }
      },
      onPanEnd: (details) {
        setState(() {
          _dragging = false;
          // Snap to the nearest index
          _index = _index.roundToDouble();
          if (widget.onIndexChanged != null) {
            widget.onIndexChanged!(_index.toInt());
          }
        });
      },
      onPanCancel: () {
        setState(() {
          _dragging = false;
          // Snap to the nearest index
          _index = _index.roundToDouble();
          if (widget.onIndexChanged != null) {
            widget.onIndexChanged!(_index.toInt());
          }
        });
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildDraggable(
      context,
      AnimatedValueBuilder(
        value: _index,
        duration: _dragging ? Duration.zero : widget.duration,
        curve: widget.curve,
        builder: (context, value, child) {
          final sourceChild = value.floor();
          final targetChild = value.ceil();
          final relativeProgress = value - sourceChild;
          return _SwitcherTransition(
            progress: relativeProgress,
            direction: widget.direction,
            absolute: false,
            children: [
              1 - relativeProgress == 0
                  ? const SizedBox.shrink()
                  : Opacity(
                      key: ValueKey(sourceChild),
                      opacity: 1 - relativeProgress,
                      child: widget.children[sourceChild],
                    ),
              relativeProgress == 0
                  ? const SizedBox.shrink()
                  : Opacity(
                      key: ValueKey(targetChild),
                      opacity: relativeProgress,
                      child: widget.children[targetChild],
                    ),
            ],
          );
        },
      ),
    );
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
