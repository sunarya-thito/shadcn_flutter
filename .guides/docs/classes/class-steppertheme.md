---
title: "Class: StepperTheme"
description: "Theme configuration for [Stepper] components."
---

```dart
/// Theme configuration for [Stepper] components.
///
/// Defines default values for stepper direction, size, and visual variant.
/// Applied through [ComponentTheme] to provide consistent styling across
/// stepper widgets in the application.
///
/// Example:
/// ```dart
/// ComponentTheme(
///   data: StepperTheme(
///     direction: Axis.vertical,
///     size: StepSize.large,
///     variant: StepVariant.circle,
///   ),
///   child: MyApp(),
/// );
/// ```
class StepperTheme {
  /// Layout direction for the stepper.
  final Axis? direction;
  /// Size variant for step indicators.
  final StepSize? size;
  /// Visual variant for step presentation.
  final StepVariant? variant;
  /// Creates a [StepperTheme].
  ///
  /// All parameters are optional and provide default values for
  /// stepper components in the widget tree.
  ///
  /// Parameters:
  /// - [direction] (Axis?): horizontal or vertical layout
  /// - [size] (StepSize?): step indicator size (small, medium, large)
  /// - [variant] (StepVariant?): visual style (circle, circleAlt, line)
  const StepperTheme({this.direction, this.size, this.variant});
  /// Creates a copy of this theme with optionally overridden properties.
  StepperTheme copyWith({ValueGetter<Axis?>? direction, ValueGetter<StepSize?>? size, ValueGetter<StepVariant?>? variant});
  bool operator ==(Object other);
  int get hashCode;
}
```
