---
title: "Extension: ListExtension"
description: "Reference for extension"
---

```dart
extension ListExtension<T> on List<T> {
  int? indexOfOrNull(T obj, [int start = 0]);
  int? lastIndexOfOrNull(T obj, [int? start]);
  int? indexWhereOrNull(Predicate<T> test, [int start = 0]);
  int? lastIndexWhereOrNull(Predicate<T> test, [int? start]);
  bool swapItem(T element, int targetIndex);
  bool swapItemWhere(Predicate<T> test, int targetIndex);
  T? optGet(int index);
}
```
