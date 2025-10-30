---
title: "Class: SelectItemBuilder"
description: "A select item delegate that uses a builder function."
---

```dart
/// A select item delegate that uses a builder function.
///
/// Provides items through a builder function with optional child count.
class SelectItemBuilder extends SelectItemDelegate {
  /// The builder function for creating item widgets.
  final SelectItemWidgetBuilder builder;
  /// The number of children this delegate can build.
  final int? childCount;
  /// Creates a select item builder.
  const SelectItemBuilder({required this.builder, this.childCount});
  Widget build(BuildContext context, int index);
  int? get estimatedChildCount;
  bool shouldRebuild(covariant SelectItemBuilder oldDelegate);
}
```
