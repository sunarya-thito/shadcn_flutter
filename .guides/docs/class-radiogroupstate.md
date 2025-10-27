---
title: "Class: RadioGroupState"
description: "Reference for RadioGroupState"
---

```dart
class RadioGroupState<T> extends State<RadioGroup<T>> with FormValueSupplier<T, RadioGroup<T>> {
  bool get enabled;
  void initState();
  void didUpdateWidget(covariant RadioGroup<T> oldWidget);
  void didReplaceFormValue(T value);
  Widget build(BuildContext context);
}
```
