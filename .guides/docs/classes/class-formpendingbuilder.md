---
title: "Class: FormPendingBuilder"
description: "Widget builder for displaying pending form validations."
---

```dart
/// Widget builder for displaying pending form validations.
///
/// Shows feedback while asynchronous validations are in progress.
class FormPendingBuilder extends StatelessWidget {
  /// Optional child widget passed to the builder.
  final Widget? child;
  /// Builder function for creating pending validation display.
  final FormPendingWidgetBuilder builder;
  /// Creates a form pending builder.
  const FormPendingBuilder({super.key, required this.builder, this.child});
  Widget build(widgets.BuildContext context);
}
```
