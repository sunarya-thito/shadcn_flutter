---
title: "Class: ChipInputState"
description: "Reference for ChipInputState"
---

```dart
class ChipInputState<T> extends State<ChipInput<T>> with FormValueSupplier<List<T>, ChipInput<T>> implements _ChipProvider<T> {
  Widget? buildChip(BuildContext context, T chip);
  void initState();
  void didUpdateWidget(covariant ChipInput<T> oldWidget);
  void dispose();
  Widget build(BuildContext context);
  void didReplaceFormValue(List<T> value);
}
```
