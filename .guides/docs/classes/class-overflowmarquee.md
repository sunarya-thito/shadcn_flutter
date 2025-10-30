---
title: "Class: OverflowMarquee"
description: "Automatically scrolling widget for content that overflows its container."
---

```dart
/// Automatically scrolling widget for content that overflows its container.
///
/// Creates smooth, continuous scrolling animation for content that exceeds the
/// available space. Commonly used for long text labels, news tickers, or any
/// content that needs horizontal or vertical scrolling to be fully visible.
///
/// Key Features:
/// - **Auto-scroll Detection**: Only animates when content actually overflows
/// - **Bi-directional Support**: Horizontal and vertical scrolling modes
/// - **Edge Fading**: Smooth fade effects at container boundaries
/// - **Customizable Timing**: Configurable duration, delay, and animation curves
/// - **Performance Optimized**: Uses Flutter's Ticker system for smooth 60fps animation
/// - **Theme Integration**: Respects OverflowMarqueeTheme configuration
///
/// Animation Behavior:
/// 1. Measures content size vs. container size
/// 2. If content fits, displays normally without animation
/// 3. If content overflows, starts continuous scrolling animation
/// 4. Scrolls content from start to end position
/// 5. Pauses briefly (delayDuration) before restarting
/// 6. Applies edge fade effects for smooth visual transitions
///
/// The widget automatically handles text direction (RTL/LTR) and adapts
/// scroll behavior accordingly for proper internationalization support.
///
/// Example:
/// ```dart
/// OverflowMarquee(
///   direction: Axis.horizontal,
///   duration: Duration(seconds: 8),
///   delayDuration: Duration(seconds: 2),
///   fadePortion: 0.15,
///   child: Text(
///     'This is a very long text that will scroll horizontally when it overflows the container',
///     style: TextStyle(fontSize: 16),
///   ),
/// )
/// ```
class OverflowMarquee extends StatefulWidget {
  /// The child widget to display and potentially scroll.
  final Widget child;
  /// Scroll direction (horizontal or vertical).
  ///
  /// If `null`, uses theme default or [Axis.horizontal].
  final Axis? direction;
  /// Total duration for one complete scroll cycle.
  ///
  /// If `null`, uses theme default.
  final Duration? duration;
  /// Distance to scroll per animation step.
  ///
  /// If `null`, scrolls the entire overflow amount.
  final double? step;
  /// Pause duration between scroll cycles.
  ///
  /// If `null`, uses theme default.
  final Duration? delayDuration;
  /// Portion of edges to apply fade effect (0.0 to 1.0).
  ///
  /// For example, 0.15 fades 15% of each edge. If `null`, uses theme default.
  final double? fadePortion;
  /// Animation curve for scroll motion.
  ///
  /// If `null`, uses theme default or [Curves.linear].
  final Curve? curve;
  /// Creates an [OverflowMarquee] widget with customizable scrolling behavior.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Content to display and potentially scroll
  /// - [direction] (Axis?, optional): Scroll direction, defaults to horizontal
  /// - [duration] (Duration?, optional): Time for one complete scroll cycle
  /// - [delayDuration] (Duration?, optional): Pause time before restarting animation
  /// - [step] (double?, optional): Step size for scroll speed calculation
  /// - [fadePortion] (double?, optional): Fade effect intensity at edges (0.0-1.0)
  /// - [curve] (Curve?, optional): Animation easing curve
  ///
  /// All optional parameters will use theme defaults or built-in fallback values
  /// when not explicitly provided.
  ///
  /// Example:
  /// ```dart
  /// OverflowMarquee(
  ///   duration: Duration(seconds: 10),
  ///   delayDuration: Duration(seconds: 1),
  ///   fadePortion: 0.2,
  ///   child: Text('Long scrolling text content'),
  /// )
  /// ```
  const OverflowMarquee({super.key, required this.child, this.direction, this.duration, this.delayDuration, this.step, this.fadePortion, this.curve});
  State<OverflowMarquee> createState();
}
```
