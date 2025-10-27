---
title: "Class: StepTitle"
description: "Clickable step title widget with optional subtitle."
---

```dart
/// Clickable step title widget with optional subtitle.
///
/// Displays the step title and optional subtitle in a clickable container.
/// Used within stepper layouts to provide interactive step navigation.
/// Supports customizable cross-axis alignment for text positioning.
///
/// Example:
/// ```dart
/// StepTitle(
///   title: Text('Account Setup'),
///   subtitle: Text('Enter your personal details'),
///   onPressed: () => jumpToThisStep(),
/// );
/// ```
class StepTitle extends StatelessWidget {
  /// The main title widget for the step.
  final Widget title;
  /// Optional subtitle widget displayed below the title.
  final Widget? subtitle;
  /// Cross-axis alignment for the title and subtitle.
  final CrossAxisAlignment crossAxisAlignment;
  /// Callback invoked when the title is pressed.
  final VoidCallback? onPressed;
  /// Creates a [StepTitle].
  ///
  /// The [title] is required. The [subtitle], [crossAxisAlignment], and
  /// [onPressed] parameters are optional.
  ///
  /// Parameters:
  /// - [title] (Widget, required): main title content
  /// - [subtitle] (Widget?): optional subtitle below title
  /// - [crossAxisAlignment] (CrossAxisAlignment): text alignment (default: stretch)
  /// - [onPressed] (VoidCallback?): tap callback for interaction
  ///
  /// Example:
  /// ```dart
  /// StepTitle(
  ///   title: Text('Payment Info'),
  ///   subtitle: Text('Credit card details'),
  ///   crossAxisAlignment: CrossAxisAlignment.center,
  ///   onPressed: () => navigateToPayment(),
  /// );
  /// ```
  const StepTitle({super.key, required this.title, this.subtitle, this.crossAxisAlignment = CrossAxisAlignment.stretch, this.onPressed});
  Widget build(BuildContext context);
}
```
