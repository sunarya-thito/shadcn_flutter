---
title: "Class: ChipInputState"
description: "State class for [ChipInput]."
---

```dart
/// State class for [ChipInput].
///
/// Manages the chip input's internal state and chip rendering.
class ChipInputState<T> extends State<ChipInput<T>> with FormValueSupplier<List<T>, ChipInput<T>> implements _ChipProvider<T> {
  Widget? buildChip(BuildContext context, T chip);
  void initState();
  void didUpdateWidget(covariant ChipInput<T> oldWidget);
  void dispose();
  Widget build(BuildContext context);
  void didReplaceFormValue(List<T> value);
}
```
