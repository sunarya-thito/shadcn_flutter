import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Contains details about a click event, including the number of consecutive clicks.
/// 
/// ClickDetails is passed to click callback functions to provide information about
/// the click interaction, particularly the click count for detecting multiple clicks
/// (double-click, triple-click, etc.).
/// 
/// This class is primarily used by [ClickDetector] to provide enhanced click
/// event information beyond standard tap detection.
/// 
/// Example:
/// ```dart
/// ClickDetails details = ClickDetails(clickCount: 2); // Double-click
/// print('User performed ${details.clickCount} clicks');
/// ```
class ClickDetails {
  /// The number of consecutive clicks detected within the threshold period.
  /// 
  /// Starts at 1 for a single click and increments for each additional click
  /// that occurs within the detector's threshold duration. Resets to 1 after
  /// the threshold period expires without additional clicks.
  /// 
  /// Common values:
  /// - 1: Single click
  /// - 2: Double click
  /// - 3: Triple click
  /// - 4+: Multiple consecutive clicks
  final int clickCount;

  /// Creates [ClickDetails] with the specified click count.
  /// 
  /// The [clickCount] should be a positive integer representing the number
  /// of consecutive clicks detected by the click detector.
  /// 
  /// Parameters:
  /// - [clickCount] (int, required): Number of consecutive clicks
  /// 
  /// Example:
  /// ```dart
  /// const singleClick = ClickDetails(clickCount: 1);
  /// const doubleClick = ClickDetails(clickCount: 2);
  /// ```
  const ClickDetails({required this.clickCount});
}

/// Function signature for handling click events with enhanced click details.
/// 
/// ClickCallback is used by click detection components to provide enhanced
/// click event information beyond standard tap callbacks. The callback receives
/// a details object containing additional information about the click event.
/// 
/// Type parameter [T] represents the type of details object passed to the callback,
/// typically [ClickDetails] but can be extended for custom click detection scenarios.
/// 
/// Example:
/// ```dart
/// final ClickCallback<ClickDetails> onMultiClick = (details) {
///   if (details.clickCount == 2) {
///     print('Double-click detected!');
///   } else if (details.clickCount >= 3) {
///     print('Multiple clicks: ${details.clickCount}');
///   }
/// };
/// ```
typedef ClickCallback<T> = void Function(T details);

/// A widget that detects multiple consecutive clicks within a specified time threshold.
/// 
/// ClickDetector extends standard tap detection by tracking the number of consecutive
/// clicks that occur within a configurable time window. This enables detection of
/// double-clicks, triple-clicks, and other multi-click patterns that are common
/// in desktop applications and advanced mobile interfaces.
/// 
/// The detector maintains a click counter that increments for each tap that occurs
/// within the threshold duration and resets when the threshold expires. This provides
/// accurate multi-click detection without interfering with normal single-click handling.
/// 
/// ## Key Features
/// 
/// - **Multi-click Detection**: Tracks consecutive clicks with accurate timing
/// - **Configurable Threshold**: Adjustable time window for click grouping
/// - **HitTest Behavior Control**: Flexible event propagation options
/// - **Zero Interference**: Works alongside other gesture recognizers
/// - **Efficient Reset**: Automatic counter reset after threshold expiration
/// 
/// ## Use Cases
/// 
/// - Double-click to edit functionality
/// - Triple-click to select all
/// - Multi-click games or interactions
/// - Desktop-style interaction patterns
/// - Advanced file browser operations
/// 
/// Example:
/// ```dart
/// ClickDetector(
///   threshold: Duration(milliseconds: 400),
///   onClick: (details) {
///     switch (details.clickCount) {
///       case 1:
///         print('Single click');
///         break;
///       case 2:
///         _handleDoubleClick();
///         break;
///       case 3:
///         _selectAll();
///         break;
///       default:
///         print('${details.clickCount} clicks detected');
///     }
///   },
///   child: Container(
///     padding: EdgeInsets.all(16),
///     child: Text('Click me multiple times'),
///   ),
/// )
/// ```
class ClickDetector extends StatefulWidget {
  /// Callback function invoked when clicks are detected.
  /// 
  /// Called for each click within the threshold period, providing [ClickDetails]
  /// that include the current consecutive click count. The callback is invoked
  /// immediately for each click, allowing real-time response to multi-click patterns.
  /// 
  /// Set to null to disable click detection while preserving the widget structure.
  final ClickCallback<ClickDetails>? onClick;
  
  /// The child widget that will be clickable.
  /// 
  /// Any widget can be made clickable by wrapping it with [ClickDetector].
  /// The detector adds gesture recognition without affecting the child's
  /// layout or appearance.
  final Widget child;
  
  /// Controls how hit testing is performed for gesture recognition.
  /// 
  /// Determines how the click detector interacts with the widget tree's
  /// hit testing system. Common values:
  /// - [HitTestBehavior.deferToChild]: Only detect clicks on child widgets
  /// - [HitTestBehavior.opaque]: Detect clicks on entire detector area
  /// - [HitTestBehavior.translucent]: Allow clicks to pass through
  final HitTestBehavior behavior;
  
  /// Maximum time between clicks to consider them consecutive.
  /// 
  /// Clicks occurring within this duration of each other are counted as
  /// consecutive clicks and increment the click counter. When the threshold
  /// expires, the counter resets to 1 for the next click.
  /// 
  /// Typical values:
  /// - 300ms: Standard double-click timing (default)
  /// - 400ms: More forgiving for accessibility
  /// - 200ms: Faster, more responsive feeling
  final Duration threshold;

  /// Creates a [ClickDetector] with the specified child and configuration.
  /// 
  /// The [child] parameter is required as it defines what will be clickable.
  /// All other parameters are optional and provide customization for the
  /// click detection behavior.
  /// 
  /// Parameters:
  /// - [child] (Widget, required): The widget to make clickable
  /// - [onClick] (ClickCallback<ClickDetails>?, optional): Click event handler
  /// - [behavior] (HitTestBehavior, default: deferToChild): Hit test behavior
  /// - [threshold] (Duration, default: 300ms): Max time between consecutive clicks
  /// 
  /// Example:
  /// ```dart
  /// ClickDetector(
  ///   threshold: Duration(milliseconds: 500),
  ///   onClick: (details) => handleClick(details.clickCount),
  ///   child: Text('Clickable Text'),
  /// );
  /// ```
  const ClickDetector({
    super.key,
    this.onClick,
    required this.child,
    this.behavior = HitTestBehavior.deferToChild,
    this.threshold = const Duration(milliseconds: 300),
  });

  @override
  /// Creates the mutable state for this click detector.
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
