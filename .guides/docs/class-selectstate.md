---
title: "Class: SelectState"
description: "Reference for SelectState"
---

```dart
class SelectState<T> extends State<Select<T>> with FormValueSupplier<T, Select<T>> {
  void didChangeDependencies();
  void initState();
  void didUpdateWidget(Select<T> oldWidget);
  void didReplaceFormValue(T value);
  void dispose();
  Widget build(BuildContext context);
}
```
