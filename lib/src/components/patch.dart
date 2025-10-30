import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Details about a click event, including the click count.
///
/// Provides information about click interactions, particularly useful
/// for detecting single, double, or multiple clicks on a widget.
///
/// The [clickCount] indicates how many consecutive clicks have occurred
/// within the threshold duration (e.g., 1 for single click, 2 for double click).
class ClickDetails {
  /// The number of consecutive clicks within the threshold period.
  ///
  /// Increments for each click that occurs within [ClickDetector.threshold]
  /// duration of the previous click. Resets to 1 when threshold is exceeded.
  final int clickCount;

  /// Creates click details with the specified click count.
  ///
  /// Parameters:
  /// - [clickCount]: Number of consecutive clicks (required)
  const ClickDetails({required this.clickCount});
}

/// Callback function type for handling click events with details.
///
/// Used by [ClickDetector] to notify listeners about click interactions
/// with full click context including click count for multi-click detection.
///
/// Type parameter [T] extends the details type, typically [ClickDetails].
typedef ClickCallback<T> = void Function(T details);

/// A widget that detects and reports click events with multi-click support.
///
/// Wraps a child widget and detects tap gestures, tracking consecutive clicks
/// within a configurable threshold duration. Useful for implementing double-click,
/// triple-click, or other multi-click interactions.
///
/// Features:
/// - **Click Count Tracking**: Automatically counts consecutive clicks
/// - **Configurable Threshold**: Set maximum time between clicks
/// - **Flexible Behavior**: Customize hit test behavior
/// - **Simple Integration**: Wraps any widget with tap detection
///
/// The widget calls [onClick] with [ClickDetails] containing the click count
/// each time a tap is detected. The count resets to 1 if taps are spaced
/// beyond the [threshold] duration.
///
/// Example - Double Click Detection:
/// ```dart
/// ClickDetector(
///   onClick: (details) {
///     if (details.clickCount == 2) {
///       print('Double clicked!');
///     }
///   },
///   child: Text('Double click me'),
/// )
/// ```
///
/// Example - Custom Threshold:
/// ```dart
/// ClickDetector(
///   onClick: (details) {
///     print('Clicked ${details.clickCount} times');
///   },
///   threshold: Duration(milliseconds: 500),
///   child: Container(
///     padding: EdgeInsets.all(16),
///     child: Text('Click rapidly'),
///   ),
/// )
/// ```
class ClickDetector extends StatefulWidget {
  /// Callback invoked when the child widget is clicked.
  ///
  /// Called with [ClickDetails] containing the current click count.
  /// If `null`, the detector is effectively disabled (no taps detected).
  final ClickCallback<ClickDetails>? onClick;

  /// The widget that receives click detection.
  ///
  /// This widget will be wrapped with gesture detection capabilities.
  final Widget child;

  /// How to behave during hit testing.
  ///
  /// Determines whether this detector should participate in hit testing
  /// and how it should behave. Defaults to [HitTestBehavior.deferToChild].
  final HitTestBehavior behavior;

  /// Maximum time between clicks to count as consecutive.
  ///
  /// When clicks occur within this duration, they increment the click count.
  /// When clicks are spaced beyond this duration, the count resets to 1.
  ///
  /// Defaults to 300 milliseconds, which is a common double-click threshold.
  final Duration threshold;

  /// Creates a click detector widget.
  ///
  /// Parameters:
  /// - [child]: The widget to wrap with click detection (required)
  /// - [onClick]: Callback for click events (optional)
  /// - [behavior]: Hit test behavior (defaults to [HitTestBehavior.deferToChild])
  /// - [threshold]: Max time between consecutive clicks (defaults to 300ms)
  const ClickDetector({
    super.key,
    this.onClick,
    required this.child,
    this.behavior = HitTestBehavior.deferToChild,
    this.threshold = const Duration(milliseconds: 300),
  });

  @override
  State<ClickDetector> createState() => _ClickDetectorState();
}

class _ClickDetectorState extends State<ClickDetector> {
  DateTime? lastClick;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTap: widget.onClick == null
          ? null
          : () {
              var now = DateTime.now();
              if (lastClick == null ||
                  (now.difference(lastClick!) > widget.threshold)) {
                count = 1;
              } else {
                count++;
              }
              widget.onClick?.call(ClickDetails(clickCount: count));
              lastClick = now;
            },
      child: widget.child,
    );
  }
}
