---
title: "Class: SelectItemDelegate"
description: "Abstract base class for building select item lists."
---

```dart
/// Abstract base class for building select item lists.
///
/// Provides interface for rendering select items with optional caching
/// and change detection.
abstract class SelectItemDelegate with CachedValue {
  /// An empty select item delegate constant.
  static const empty = EmptySelectItem();
  /// Creates a select item delegate.
  const SelectItemDelegate();
  /// Builds a widget for the item at the given index.
  Widget? build(BuildContext context, int index);
  /// Estimated number of children in this delegate.
  int? get estimatedChildCount;
  bool shouldRebuild(covariant SelectItemDelegate oldDelegate);
}
```
