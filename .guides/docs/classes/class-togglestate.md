---
title: "Class: ToggleState"
description: "State class for [Toggle] that manages the toggle behavior and form integration."
---

```dart
/// State class for [Toggle] that manages the toggle behavior and form integration.
///
/// This state class handles:
/// - Maintaining widget states (selected, pressed, hovered, etc.)
/// - Form value integration via [FormValueSupplier]
/// - Updating the selected state based on the toggle value
class ToggleState extends State<Toggle> with FormValueSupplier<bool, Toggle> {
  /// Controller for managing widget interaction states.
  final WidgetStatesController statesController;
  void initState();
  void didUpdateWidget(Toggle oldWidget);
  void didReplaceFormValue(bool value);
  Widget build(BuildContext context);
}
```
