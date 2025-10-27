---
title: "Class: Step"
description: "Represents a single step in a stepper component."
---

```dart
/// Represents a single step in a stepper component.
///
/// Contains the step's title, optional content builder for step details,
/// and an optional custom icon. The content builder is called when
/// the step becomes active to show step-specific content.
///
/// Example:
/// ```dart
/// Step(
///   title: Text('Personal Info'),
///   icon: Icon(Icons.person),
///   contentBuilder: (context) => PersonalInfoForm(),
/// );
/// ```
class Step {
  /// The title widget displayed for this step.
  final Widget title;
  /// Optional builder for step content shown when active.
  final WidgetBuilder? contentBuilder;
  /// Optional custom icon for the step indicator.
  final Widget? icon;
  /// Creates a [Step].
  ///
  /// The [title] is required and typically contains the step name or description.
  /// The [contentBuilder] is called when this step becomes active to show
  /// detailed content. The [icon] replaces the default step number/checkmark.
  ///
  /// Parameters:
  /// - [title] (Widget, required): step title or label
  /// - [contentBuilder] (WidgetBuilder?): builds content when step is active
  /// - [icon] (Widget?): custom icon for step indicator
  ///
  /// Example:
  /// ```dart
  /// Step(
  ///   title: Text('Account Setup'),
  ///   icon: Icon(Icons.account_circle),
  ///   contentBuilder: (context) => AccountSetupForm(),
  /// );
  /// ```
  const Step({required this.title, this.contentBuilder, this.icon});
}
```
