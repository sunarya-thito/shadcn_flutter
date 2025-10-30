---
title: "Class: StepContainer"
description: "Container widget for step content with optional action buttons."
---

```dart
/// Container widget for step content with optional action buttons.
///
/// Provides consistent padding and layout for step content, with optional
/// action buttons displayed below the main content. Actions are arranged
/// horizontally with appropriate spacing.
///
/// Typically used within step content builders to provide a consistent
/// layout for form content, descriptions, and navigation buttons.
///
/// Example:
/// ```dart
/// StepContainer(
///   child: Column(
///     children: [
///       TextFormField(decoration: InputDecoration(labelText: 'Name')),
///       TextFormField(decoration: InputDecoration(labelText: 'Email')),
///     ],
///   ),
///   actions: [
///     Button(
///       onPressed: controller.previousStep,
///       child: Text('Back'),
///     ),
///     Button(
///       onPressed: controller.nextStep,
///       child: Text('Next'),
///     ),
///   ],
/// );
/// ```
class StepContainer extends StatefulWidget {
  /// The main content widget for the step.
  final Widget child;
  /// List of action widgets (typically buttons) displayed below content.
  final List<Widget> actions;
  /// Creates a [StepContainer].
  ///
  /// The [child] and [actions] parameters are required. Actions can be
  /// an empty list if no buttons are needed.
  ///
  /// Parameters:
  /// - [child] (Widget, required): main step content
  /// - [actions] (`List<Widget>`, required): action buttons or widgets
  ///
  /// Example:
  /// ```dart
  /// StepContainer(
  ///   child: FormFields(),
  ///   actions: [
  ///     Button(onPressed: previousStep, child: Text('Back')),
  ///     Button(onPressed: nextStep, child: Text('Continue')),
  ///   ],
  /// );
  /// ```
  const StepContainer({super.key, required this.child, required this.actions});
  State<StepContainer> createState();
}
```
