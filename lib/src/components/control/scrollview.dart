import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Widget that intercepts scroll events to simulate middle-button drag scrolling.
///
/// Helps simulate middle-hold scroll on web and desktop platforms by intercepting
/// pointer events and converting drag gestures into scroll events.
class ScrollViewInterceptor extends StatefulWidget {
  /// The child widget to wrap with scroll interception functionality.
  final Widget child;

  /// Whether scroll interception is enabled.
  final bool enabled;

  /// Creates a scroll view interceptor.
  const ScrollViewInterceptor(
      {super.key, required this.child, this.enabled = true});

  @override
  State<ScrollViewInterceptor> createState() => _ScrollViewInterceptorState();
}

/// The drag speed multiplier for scroll interception (0.02).
const double kScrollDragSpeed = 0.02;

/// The maximum scroll speed allowed (10.0).
const double kMaxScrollSpeed = 10;

/// A custom pointer scroll event for desktop platforms.
///
/// Extends [PointerScrollEvent] with desktop-specific scroll event handling.
class DesktopPointerScrollEvent extends PointerScrollEvent {
  /// Creates a desktop pointer scroll event.
  const DesktopPointerScrollEvent({
    required super.position,
    required super.device,
    required super.embedderId,
    required super.kind,
    required super.timeStamp,
    required super.viewId,
    required super.scrollDelta,
  });
}

class _ScrollViewInterceptorState extends State<ScrollViewInterceptor>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;

  Duration? _lastTime;

  PointerDownEvent? _event;
  Offset? _lastOffset;
  MouseCursor? _cursor;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration elapsed) {
    Duration delta = _lastTime == null ? Duration.zero : elapsed - _lastTime!;
    _lastTime = elapsed;
    if (delta.inMilliseconds == 0) return;
    Offset positionDelta = _event!.position - _lastOffset!;
    double incX =
        pow(-positionDelta.dx * kScrollDragSpeed, 3) / delta.inMilliseconds;
    double incY =
        pow(-positionDelta.dy * kScrollDragSpeed, 3) / delta.inMilliseconds;
    incX = incX.clamp(-kMaxScrollSpeed, kMaxScrollSpeed);
    incY = incY.clamp(-kMaxScrollSpeed, kMaxScrollSpeed);
    var instance = GestureBinding.instance;
    HitTestResult result = HitTestResult();
    instance.hitTestInView(result, _event!.position, _event!.viewId);
    var pointerScrollEvent = DesktopPointerScrollEvent(
      position: _event!.position,
      device: _event!.device,
      embedderId: _event!.embedderId,
      kind: _event!.kind,
      timeStamp: Duration(milliseconds: DateTime.now().millisecondsSinceEpoch),
      viewId: _event!.viewId,
      scrollDelta: Offset(incX, incY),
    );
    for (final path in result.path) {
      try {
        path.target.handleEvent(pointerScrollEvent, path);
      } catch (e, s) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: e,
          stack: s,
          library: 'shadcn_flutter',
          context: ErrorDescription('while dispatching a pointer scroll event'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        Listener(
          onPointerDown: (event) {
            // check if middle button is pressed
            if (event.buttons != 4 || _ticker.isActive) return;
            _event = event;
            _lastOffset = event.position;
            _lastTime = null;
            _ticker.start();
            setState(() {
              _cursor = SystemMouseCursors.allScroll;
            });
          },
          onPointerUp: (event) {
            if (_ticker.isActive) {
              _ticker.stop();
              _lastTime = null;
              _event = null;
              _lastOffset = null;
              setState(() {
                _cursor = null;
              });
            }
          },
          onPointerMove: (event) {
            if (_ticker.isActive) {
              _lastOffset = event.position;
            }
          },
          child: widget.child,
        ),
        if (_cursor != null)
          Positioned.fill(
            child: MouseRegion(
              cursor: _cursor!,
              hitTestBehavior: HitTestBehavior.translucent,
            ),
          ),
      ],
    );
  }
}
