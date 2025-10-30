---
title: "Class: FormState"
description: "State class for the [Form] widget that manages form controller lifecycle."
---

```dart
/// State class for the [Form] widget that manages form controller lifecycle.
///
/// This state class is responsible for initializing and updating the
/// [FormController] used by the [Form] widget. It ensures proper controller
/// management when the controller property changes and provides the controller
/// to descendant widgets through the data inheritance mechanism.
///
/// The state handles two scenarios:
/// - Creates a default [FormController] if none is provided
/// - Updates to a new controller when the widget's controller property changes
///
/// See also:
/// - [Form], the widget that uses this state
/// - [FormController], the controller managed by this state
class FormState extends State<Form> {
  void initState();
  void didUpdateWidget(covariant Form oldWidget);
  Widget build(BuildContext context);
}
```
