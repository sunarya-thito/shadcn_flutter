---
title: "Class: StepNumber"
description: "Step indicator widget displaying step number, checkmark, or custom icon."
---

```dart
/// Step indicator widget displaying step number, checkmark, or custom icon.
///
/// Renders a circular (or rectangular based on theme) step indicator that
/// shows the step number by default, a checkmark for completed steps,
/// or an X for failed steps. Colors and states are automatically managed
/// based on the stepper's current state.
///
/// Must be used within a [Stepper] widget tree to access step context.
/// Optionally supports custom icons and click handling.
///
/// Example:
/// ```dart
/// StepNumber(
///   icon: Icon(Icons.star),
///   onPressed: () => print('Step tapped'),
/// );
/// ```
class StepNumber extends StatelessWidget {
  /// Custom icon to display instead of step number.
  final Widget? icon;
  /// Callback invoked when the step indicator is pressed.
  final VoidCallback? onPressed;
  /// Creates a [StepNumber].
  ///
  /// Both parameters are optional. If [icon] is provided, it replaces
  /// the default step number. If [onPressed] is provided, the step
  /// becomes clickable.
  ///
  /// Parameters:
  /// - [icon] (Widget?): custom icon replacing step number
  /// - [onPressed] (VoidCallback?): tap callback for interaction
  ///
  /// Example:
  /// ```dart
  /// StepNumber(
  ///   icon: Icon(Icons.person),
  ///   onPressed: () => jumpToStep(stepIndex),
  /// );
  /// ```
  const StepNumber({super.key, this.icon, this.onPressed});
  Widget build(BuildContext context);
}
```
