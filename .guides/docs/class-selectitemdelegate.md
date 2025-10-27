---
title: "Class: SelectItemDelegate"
description: "Reference for SelectItemDelegate"
---

```dart
abstract class SelectItemDelegate with CachedValue {
  static const empty = EmptySelectItem();
  const SelectItemDelegate();
  Widget? build(BuildContext context, int index);
  int? get estimatedChildCount;
  bool shouldRebuild(covariant SelectItemDelegate oldDelegate);
}
```
