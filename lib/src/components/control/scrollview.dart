import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A specialized widget that intercepts and enhances scrolling behavior for desktop platforms.
///
/// [ScrollViewInterceptor] implements advanced scrolling interactions that simulate
/// middle-mouse button hold-to-scroll functionality commonly expected on desktop
/// and web platforms. It enhances the native scrolling experience by providing
/// smooth, momentum-based scrolling through pointer gesture interception.
///
/// The widget wraps scroll views and intercepts pointer events to provide:
/// - Middle mouse button hold-and-drag scrolling
/// - Smooth momentum scrolling with physics simulation
/// - Platform-appropriate cursor feedback during scroll operations
/// - Configurable scroll sensitivity and maximum speed limits
///
/// Key features:
/// - Desktop-optimized scrolling behavior enhancement
/// - Middle mouse button hold-to-scroll simulation
/// - Smooth momentum physics with customizable parameters
/// - Automatic cursor management during scroll operations
/// - Ticker-based animation for fluid scroll motion
/// - Configurable enable/disable functionality
///
/// The component is particularly useful for desktop applications where users
/// expect advanced scrolling interactions beyond basic wheel scrolling.
///
/// Example:
/// ```dart
/// ScrollViewInterceptor(
///   enabled: true,
///   child: ListView(
///     children: listItems,
///   ),
/// );
/// ```
class ScrollViewInterceptor extends StatefulWidget {
  /// The widget tree to wrap with enhanced scrolling behavior.
  ///
  /// This is typically a scrollable widget like [ListView], [SingleChildScrollView],
  /// or [CustomScrollView] that will benefit from enhanced desktop scrolling
  /// interactions.
  final Widget child;

  /// Whether the scroll interception is enabled.
  ///
  /// When false, the widget acts as a pass-through without intercepting
  /// any scroll events. Defaults to true to enable enhanced scrolling.
  final bool enabled;

  /// Creates a [ScrollViewInterceptor].
  ///
  /// The [child] parameter is required and should contain the scrollable
  /// content to be enhanced. The [enabled] parameter defaults to true
  /// to activate scroll interception by default.
  ///
  /// Example:
  /// ```dart
  /// ScrollViewInterceptor(
  ///   enabled: Platform.isDesktop,
  ///   child: CustomScrollView(
  ///     slivers: [
  ///       SliverList(delegate: listDelegate),
  ///     ],
  ///   ),
  /// );
  /// ```
  const ScrollViewInterceptor(
      {super.key, required this.child, this.enabled = true});

  @override
  State<ScrollViewInterceptor> createState() => _ScrollViewInterceptorState();
}

/// Scroll drag speed multiplier for converting pointer movement to scroll velocity.
///
/// This constant determines how quickly scroll movement responds to pointer
/// drag gestures. Lower values create more precise control, while higher
/// values create faster scrolling response.
const double kScrollDragSpeed = 0.02;

/// Maximum scroll speed limit to prevent excessive scroll velocities.
///
/// This constant caps the maximum scroll speed to maintain smooth, controlled
/// scrolling even with rapid pointer movements. Prevents scroll operations
/// from becoming uncontrollably fast.
const double kMaxScrollSpeed = 10;

/// Specialized pointer scroll event for desktop scrolling operations.
///
/// [DesktopPointerScrollEvent] extends [PointerScrollEvent] to provide
/// desktop-specific scroll event handling with enhanced metadata and
/// behavior appropriate for desktop pointer interactions.
///
/// This event type enables proper recognition and processing of desktop
/// scrolling gestures within the scroll view interceptor system.
class DesktopPointerScrollEvent extends PointerScrollEvent {
  /// Creates a [DesktopPointerScrollEvent] with the required pointer event properties.
  ///
  /// All parameters are required to properly identify and process the desktop
  /// scroll event within the Flutter event system. These parameters correspond
  /// to standard [PointerScrollEvent] properties but with desktop-specific handling.
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
