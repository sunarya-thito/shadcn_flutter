---
title: "Class: Steps"
description: "Vertical step progression widget with numbered indicators and connectors."
---

```dart
/// Vertical step progression widget with numbered indicators and connectors.
///
/// A layout widget that displays a vertical sequence of steps, each with a
/// numbered circular indicator connected by lines. Ideal for showing progress
/// through multi-step processes, tutorials, or workflows.
///
/// ## Features
///
/// - **Numbered indicators**: Circular indicators with automatic step numbering
/// - **Connector lines**: Visual lines connecting consecutive steps
/// - **Flexible content**: Each step can contain any widget content
/// - **Responsive theming**: Customizable indicator size, spacing, and colors
/// - **Intrinsic sizing**: Automatically adjusts to content height
///
/// The widget automatically numbers each step starting from 1 and connects
/// them with vertical lines. Each step's content is placed to the right of
/// its indicator.
///
/// Example:
/// ```dart
/// Steps(
///   children: [
///     Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Create Account', style: TextStyle(fontWeight: FontWeight.bold)),
///         Text('Sign up with your email address'),
///       ],
///     ),
///     Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Verify Email', style: TextStyle(fontWeight: FontWeight.bold)),
///         Text('Check your inbox for verification'),
///       ],
///     ),
///     Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Complete Profile', style: TextStyle(fontWeight: FontWeight.bold)),
///         Text('Add your personal information'),
///       ],
///     ),
///   ],
/// );
/// ```
class Steps extends StatelessWidget {
  /// List of widgets representing each step in the sequence.
  ///
  /// Each widget will be displayed with an automatically numbered
  /// circular indicator showing its position in the sequence.
  final List<Widget> children;
  /// Creates a [Steps] widget.
  ///
  /// Each child widget represents one step in the sequence and will be
  /// displayed with an automatically numbered circular indicator.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): list of widgets representing each step
  ///
  /// Example:
  /// ```dart
  /// Steps(
  ///   children: [
  ///     Text('First step content'),
  ///     Text('Second step content'),
  ///     Text('Third step content'),
  ///   ],
  /// )
  /// ```
  const Steps({super.key, required this.children});
  Widget build(BuildContext context);
}
```
