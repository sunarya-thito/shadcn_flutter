---
title: "Class: StepVariant"
description: "Abstract base class for step visual presentation variants."
---

```dart
/// Abstract base class for step visual presentation variants.
///
/// Defines how steps are rendered and connected to each other. Three built-in
/// variants are provided: circle (default), circleAlt (alternative layout),
/// and line (minimal design). Custom variants can be created by extending
/// this class.
///
/// Example:
/// ```dart
/// Stepper(
///   variant: StepVariant.circle,
///   steps: mySteps,
///   controller: controller,
/// );
/// ```
abstract class StepVariant {
  /// Circle variant with numbered indicators and connecting lines.
  static const StepVariant circle = _StepVariantCircle();
  /// Alternative circle variant with centered step names.
  static const StepVariant circleAlt = _StepVariantCircleAlternative();
  /// Minimal line variant with progress bars as step indicators.
  static const StepVariant line = _StepVariantLine();
  /// Creates a [StepVariant].
  const StepVariant();
  /// Builds the stepper widget using this variant's visual style.
  ///
  /// Implementations should create the appropriate layout using the
  /// provided [StepProperties] which contains step data, current state,
  /// and sizing information.
  Widget build(BuildContext context, StepProperties properties);
}
```
