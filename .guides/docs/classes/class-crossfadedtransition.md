---
title: "Class: CrossFadedTransition"
description: "A widget that smoothly transitions between different child widgets."
---

```dart
/// A widget that smoothly transitions between different child widgets.
///
/// [CrossFadedTransition] automatically detects when its child widget changes
/// and performs a smooth transition animation between the old and new child.
/// It uses [AnimatedSize] to handle size changes and provides different
/// interpolation strategies via the [lerp] parameter.
///
/// The widget is particularly useful for content that changes dynamically,
/// such as switching between different states of a UI component or fading
/// between different pieces of text or imagery.
///
/// Built-in lerp functions:
/// - [lerpOpacity]: Cross-fades using opacity (default)
/// - [lerpStep]: Instant transition without fade effect
///
/// Example:
/// ```dart
/// CrossFadedTransition(
///   duration: Duration(milliseconds: 300),
///   child: _showFirst
///       ? Text('First Text', key: ValueKey('first'))
///       : Icon(Icons.star, key: ValueKey('second')),
/// );
/// ```
class CrossFadedTransition extends StatefulWidget {
  /// Creates a smooth opacity-based transition between two widgets.
  ///
  /// This lerp function implements a cross-fade effect where the first widget
  /// fades out during the first half of the transition (t: 0.0-0.5) while the
  /// second widget fades in during the second half (t: 0.5-1.0).
  ///
  /// Parameters:
  /// - [a] (Widget): The outgoing widget to fade out.
  /// - [b] (Widget): The incoming widget to fade in.
  /// - [t] (double): Animation progress from 0.0 to 1.0.
  /// - [alignment] (AlignmentGeometry): How to align widgets during transition.
  ///
  /// Returns a [Stack] with both widgets positioned and faded appropriately.
  static Widget lerpOpacity(Widget a, Widget b, double t, {AlignmentGeometry alignment = Alignment.center});
  /// Creates an instant transition between two widgets without animation.
  ///
  /// This lerp function provides a step-wise transition where both widgets
  /// are shown simultaneously without any fade effect. At t=0.0, widget [a]
  /// is returned; at t=1.0, widget [b] is returned; for intermediate values,
  /// both widgets are stacked.
  ///
  /// Parameters:
  /// - [a] (Widget): The first widget in the transition.
  /// - [b] (Widget): The second widget in the transition.
  /// - [t] (double): Animation progress from 0.0 to 1.0.
  /// - [alignment] (AlignmentGeometry): How to align widgets (unused in step mode).
  ///
  /// Returns either individual widget at extremes or a [Stack] for intermediate values.
  static Widget lerpStep(Widget a, Widget b, double t, {AlignmentGeometry alignment = Alignment.center});
  /// The child widget to display and potentially transition from.
  ///
  /// When this changes (determined by widget equality and key comparison),
  /// a transition animation is triggered using the specified [lerp] function.
  final Widget child;
  /// Duration of the transition animation.
  ///
  /// Controls how long the transition takes when the child widget changes.
  /// Also affects the [AnimatedSize] duration for size-change animations.
  final Duration duration;
  /// Alignment for positioning widgets during transition.
  ///
  /// Determines how widgets are aligned within the transition area,
  /// affecting both the [AnimatedSize] behavior and lerp positioning.
  final AlignmentGeometry alignment;
  /// Function that interpolates between old and new child widgets.
  ///
  /// Called during transition with the outgoing widget [a], incoming widget [b],
  /// and progress value [t] (0.0 to 1.0). Must return a widget representing
  /// the intermediate state of the transition.
  final Widget Function(Widget a, Widget b, double t, {AlignmentGeometry alignment}) lerp;
  /// Creates a [CrossFadedTransition] widget.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The child widget to display and transition from when changed.
  /// - [duration] (Duration, default: kDefaultDuration): How long transitions should take.
  /// - [alignment] (AlignmentGeometry, default: Alignment.center): Widget alignment during transitions.
  /// - [lerp] (Function, default: lerpOpacity): How to interpolate between old and new children.
  ///
  /// The [child] should have a unique key when you want to trigger transitions,
  /// as the widget uses key comparison to detect when content has changed.
  ///
  /// Example:
  /// ```dart
  /// CrossFadedTransition(
  ///   duration: Duration(milliseconds: 250),
  ///   alignment: Alignment.topCenter,
  ///   child: _currentIndex == 0
  ///       ? Text('Home', key: ValueKey('home'))
  ///       : Text('Settings', key: ValueKey('settings')),
  /// );
  /// ```
  const CrossFadedTransition({super.key, required this.child, this.duration = kDefaultDuration, this.alignment = Alignment.center, this.lerp = lerpOpacity});
  State<CrossFadedTransition> createState();
}
```
