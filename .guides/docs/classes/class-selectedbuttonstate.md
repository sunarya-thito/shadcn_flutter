---
title: "Class: SelectedButtonState"
description: "State class for [SelectedButton] managing selection and interaction states."
---

```dart
/// State class for [SelectedButton] managing selection and interaction states.
///
/// Handles widget state controller lifecycle and synchronizes the selected state
/// with the button's value.
class SelectedButtonState extends State<SelectedButton> {
  /// The controller managing widget states (selected, hovered, focused, etc.).
  ///
  /// This controller is either provided via [SelectedButton.statesController]
  /// or created automatically. It tracks and manages the button's interactive
  /// states and updates them based on user interactions and the selection value.
  WidgetStatesController statesController;
  void initState();
  void didUpdateWidget(SelectedButton oldWidget);
  Widget build(BuildContext context);
}
```
