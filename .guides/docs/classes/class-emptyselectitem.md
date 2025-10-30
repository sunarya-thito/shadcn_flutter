---
title: "Class: EmptySelectItem"
description: "An empty select item delegate that renders no items."
---

```dart
/// An empty select item delegate that renders no items.
class EmptySelectItem extends SelectItemDelegate {
  /// Creates an empty select item.
  const EmptySelectItem();
  Widget? build(BuildContext context, int index);
  int get estimatedChildCount;
  bool shouldRebuild(covariant EmptySelectItem oldDelegate);
}
```
