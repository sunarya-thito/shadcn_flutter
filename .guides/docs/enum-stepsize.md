---
title: "Enum: StepSize"
description: "Defines the size variants available for step indicators."
---

```dart
/// Defines the size variants available for step indicators.
///
/// Each size includes both a numeric size value and a builder function
/// that applies appropriate text and icon styling. Sizes scale with
/// the theme's scaling factor.
///
/// Example:
/// ```dart
/// Stepper(
///   size: StepSize.large,
///   steps: mySteps,
///   controller: controller,
/// );
/// ```
enum StepSize {
  /// Small step indicators with compact text and icons.
  small,
  /// Medium step indicators with normal text and icons (default).
  medium,
  /// Large step indicators with larger text and icons.
  large,
}
```
