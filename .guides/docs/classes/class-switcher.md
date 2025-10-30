---
title: "Class: Switcher"
description: "A swipeable container that transitions between multiple child widgets."
---

```dart
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
  const Switcher({super.key, this.index = 0, required this.direction, required this.children, this.onIndexChanged, this.duration = const Duration(milliseconds: 300), this.curve = Curves.easeInOut});
  State<Switcher> createState();
}
```
