---
title: "Class: Stepper"
description: "A multi-step navigation component with visual progress indication."
---

```dart
/// A multi-step navigation component with visual progress indication.
///
/// Displays a sequence of steps with customizable visual styles, supporting
/// both horizontal and vertical layouts. Each step can have a title, optional
/// content, and custom icons. The component tracks current step progress and
/// can display failed states.
///
/// Uses a [StepperController] for state management and navigation. Steps are
/// defined using [Step] objects, and visual presentation is controlled by
/// [StepVariant] and [StepSize] configurations.
///
/// The stepper automatically handles step indicators, connecting lines or
/// progress bars, and animated content transitions between steps.
///
/// Example:
/// ```dart
/// final controller = StepperController();
///
/// Stepper(
///   controller: controller,
///   direction: Axis.vertical,
///   variant: StepVariant.circle,
///   size: StepSize.medium,
///   steps: [
///     Step(
///       title: Text('Personal Info'),
///       contentBuilder: (context) => PersonalInfoForm(),
///     ),
///     Step(
///       title: Text('Address'),
///       contentBuilder: (context) => AddressForm(),
///     ),
///     Step(
///       title: Text('Confirmation'),
///       contentBuilder: (context) => ConfirmationView(),
///     ),
///   ],
/// );
/// ```
class Stepper extends StatelessWidget {
  /// Controller for managing stepper state and navigation.
  final StepperController controller;
  /// List of steps to display in the stepper.
  final List<Step> steps;
  /// Layout direction (horizontal or vertical).
  final Axis? direction;
  /// Size variant for step indicators.
  final StepSize? size;
  /// Visual variant for step presentation.
  final StepVariant? variant;
  /// Creates a [Stepper].
  ///
  /// The [controller] and [steps] are required. Other parameters are optional
  /// and will use theme defaults or built-in defaults if not provided.
  ///
  /// Parameters:
  /// - [controller] (StepperController, required): manages state and navigation
  /// - [steps] (`List<Step>`, required): list of steps to display
  /// - [direction] (Axis?): horizontal or vertical layout (default: horizontal)
  /// - [size] (StepSize?): step indicator size (default: medium)
  /// - [variant] (StepVariant?): visual style (default: circle)
  ///
  /// Example:
  /// ```dart
  /// final controller = StepperController(currentStep: 0);
  ///
  /// Stepper(
  ///   controller: controller,
  ///   direction: Axis.vertical,
  ///   size: StepSize.large,
  ///   variant: StepVariant.line,
  ///   steps: [
  ///     Step(title: Text('Step 1')),
  ///     Step(title: Text('Step 2')),
  ///     Step(title: Text('Step 3')),
  ///   ],
  /// );
  /// ```
  const Stepper({super.key, required this.controller, required this.steps, this.direction, this.size, this.variant});
  Widget build(BuildContext context);
}
```
