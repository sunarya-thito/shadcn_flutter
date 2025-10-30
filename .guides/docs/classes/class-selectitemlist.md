---
title: "Class: SelectItemList"
description: "A select item delegate that uses a static list of children."
---

```dart
/// A select item delegate that uses a static list of children.
///
/// [SelectItemList] provides select items from a pre-defined list of widgets.
/// This is the simplest way to create a select dropdown with a fixed set of options.
///
/// Example:
/// ```dart
/// SelectItemList(
///   children: [
///     SelectItem(value: 1, child: Text('Option 1')),
///     SelectItem(value: 2, child: Text('Option 2')),
///     SelectItem(value: 3, child: Text('Option 3')),
///   ],
/// )
/// ```
class SelectItemList extends SelectItemDelegate {
  /// The list of widgets to display as select items.
  final List<Widget> children;
  /// Creates a [SelectItemList] with the specified children.
  const SelectItemList({required this.children});
  Widget build(BuildContext context, int index);
  int get estimatedChildCount;
  bool shouldRebuild(covariant SelectItemList oldDelegate);
}
```
