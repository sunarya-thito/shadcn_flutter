---
title: "Class: RadioGroupState"
description: "State class for [RadioGroup] with form integration."
---

```dart
/// State class for [RadioGroup] with form integration.
///
/// Manages selection state and integrates with the form validation system.
class RadioGroupState<T> extends State<RadioGroup<T>> with FormValueSupplier<T, RadioGroup<T>> {
  /// Whether the radio group is currently enabled.
  bool get enabled;
  void initState();
  void didUpdateWidget(covariant RadioGroup<T> oldWidget);
  void didReplaceFormValue(T value);
  Widget build(BuildContext context);
}
```
