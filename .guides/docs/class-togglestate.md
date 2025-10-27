---
title: "Class: ToggleState"
description: "Reference for ToggleState"
---

```dart
class ToggleState extends State<Toggle> with FormValueSupplier<bool, Toggle> {
  final WidgetStatesController statesController;
  void initState();
  void didUpdateWidget(Toggle oldWidget);
  void didReplaceFormValue(bool value);
  Widget build(BuildContext context);
}
```
