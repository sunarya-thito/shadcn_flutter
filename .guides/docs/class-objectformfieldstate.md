---
title: "Class: ObjectFormFieldState"
description: "Reference for ObjectFormFieldState"
---

```dart
class ObjectFormFieldState<T> extends State<ObjectFormField<T>> with FormValueSupplier<T, ObjectFormField<T>> {
  void initState();
  T? get value;
  set value(T? value);
  void didReplaceFormValue(T value);
  void didUpdateWidget(covariant ObjectFormField<T> oldWidget);
  bool get enabled;
  void dispose();
  void prompt([T? value]);
  Widget build(BuildContext context);
}
```
