---
title: "Class: RawSortableList"
description: "Reference for RawSortableList"
---

```dart
class RawSortableList<T> extends StatelessWidget {
  final SortableListDelegate<T> delegate;
  final SortableWidgetBuilder<T> builder;
  final ValueChanged<ListChanges<T>>? onChanged;
  final bool enabled;
  const RawSortableList({super.key, required this.delegate, required this.builder, this.onChanged, this.enabled = true});
  Widget build(BuildContext context);
}
```
