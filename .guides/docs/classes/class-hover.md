---
title: "Class: Hover"
description: "A widget that manages hover state with configurable timing behavior."
---

```dart
/// A widget that manages hover state with configurable timing behavior.
///
/// [Hover] provides sophisticated hover detection with delays and minimum durations
/// to prevent flickering when the cursor quickly passes over the widget. It calls
/// [onHover] with `true` when hover activates and `false` when it deactivates.
///
/// Unlike [HoverActivity], this widget implements smart timing:
/// - [waitDuration]: Delay before activating hover
/// - [minDuration]: Minimum time to keep hover active once triggered
/// - [showDuration]: Total duration for hover state
///
/// Example:
/// ```dart
/// Hover(
///   waitDuration: Duration(milliseconds: 500),
///   minDuration: Duration(milliseconds: 200),
///   onHover: (hovered) {
///     print(hovered ? 'Hover activated' : 'Hover deactivated');
///   },
///   child: Container(
///     width: 100,
///     height: 100,
///     color: Colors.blue,
///   ),
/// )
/// ```
class Hover extends StatefulWidget {
  /// The widget to track for hover events.
  final Widget child;
  /// Called with `true` when hover activates, `false` when it deactivates.
  ///
  /// Activation respects [waitDuration] delay, and deactivation respects [minDuration].
  final void Function(bool hovered) onHover;
  /// Delay before activating hover after cursor enters.
  ///
  /// Prevents accidental activation from quick cursor passes. Defaults to 500ms.
  final Duration? waitDuration;
  /// Minimum duration to keep hover active once triggered.
  ///
  /// Prevents flickering when cursor quickly moves over the widget. Defaults to 0ms.
  final Duration? minDuration;
  /// Total duration for hover state before auto-deactivation.
  final Duration? showDuration;
  /// Hit test behavior for pointer event handling.
  final HitTestBehavior? hitTestBehavior;
  /// Creates a [Hover] widget with timing configuration.
  const Hover({super.key, required this.child, required this.onHover, this.waitDuration, this.minDuration, this.showDuration, this.hitTestBehavior});
  State<Hover> createState();
}
```
