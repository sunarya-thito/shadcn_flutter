---
title: "Class: DotIndicator"
description: "Navigation indicator with customizable dots showing current position in a sequence."
---

```dart
/// Navigation indicator with customizable dots showing current position in a sequence.
///
/// A visual indicator widget that displays a series of dots representing items
/// in a sequence, with one dot highlighted to show the current position.
/// Commonly used with carousels, page views, and stepper interfaces.
///
/// ## Features
///
/// - **Position indication**: Clear visual representation of current position
/// - **Interactive navigation**: Optional tap-to-navigate functionality
/// - **Flexible orientation**: Horizontal or vertical dot arrangement
/// - **Custom dot builders**: Complete control over dot appearance and behavior
/// - **Responsive spacing**: Automatic scaling with theme configuration
/// - **Accessibility support**: Screen reader friendly with semantic information
///
/// The indicator automatically highlights the dot at the current index and
/// can optionally respond to taps to change the active position.
///
/// Example:
/// ```dart
/// DotIndicator(
///   index: currentPage,
///   length: totalPages,
///   onChanged: (newIndex) => pageController.animateToPage(newIndex),
///   direction: Axis.horizontal,
///   spacing: 12.0,
/// );
/// ```
class DotIndicator extends StatelessWidget {
  final int index;
  final int length;
  final ValueChanged<int>? onChanged;
  final double? spacing;
  final Axis direction;
  final EdgeInsetsGeometry? padding;
  final DotBuilder? dotBuilder;
  /// Creates a [DotIndicator].
  ///
  /// The indicator shows [length] dots with the dot at [index] highlighted
  /// as active. When [onChanged] is provided, tapping dots triggers navigation.
  ///
  /// Parameters:
  /// - [index] (int, required): current active dot position (0-based)
  /// - [length] (int, required): total number of dots to display
  /// - [onChanged] (`ValueChanged<int>?`, optional): callback when dot is tapped
  /// - [spacing] (double?, optional): override spacing between dots
  /// - [direction] (Axis, default: horizontal): layout direction of dots
  /// - [padding] (EdgeInsetsGeometry?, optional): padding around dot container
  /// - [dotBuilder] (DotBuilder?, optional): custom builder for dot widgets
  ///
  /// Example:
  /// ```dart
  /// DotIndicator(
  ///   index: 1,
  ///   length: 5,
  ///   onChanged: (index) => print('Navigate to $index'),
  ///   direction: Axis.horizontal,
  ///   dotBuilder: (context, index, active) => Container(
  ///     width: active ? 16 : 8,
  ///     height: 8,
  ///     decoration: BoxDecoration(
  ///       color: active ? Colors.blue : Colors.grey,
  ///       borderRadius: BorderRadius.circular(4),
  ///     ),
  ///   ),
  /// )
  /// ```
  const DotIndicator({super.key, required this.index, required this.length, this.onChanged, this.spacing, this.direction = Axis.horizontal, this.padding, this.dotBuilder});
  Widget build(BuildContext context);
}
```
