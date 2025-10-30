---
title: "Class: RawSortableList"
description: "A low-level sortable list widget with customizable rendering."
---

```dart
/// A low-level sortable list widget with customizable rendering.
///
/// Provides the foundation for building sortable lists with custom item
/// rendering and change tracking. Use this when you need fine-grained control
/// over the sortable list behavior.
class RawSortableList<T> extends StatelessWidget {
  /// The delegate that provides item data.
  final SortableListDelegate<T> delegate;
  /// Builder for creating item widgets.
  final SortableWidgetBuilder<T> builder;
  /// Callback invoked when the list order changes.
  ///
  /// Receives a [ListChanges] object containing all modifications.
  final ValueChanged<ListChanges<T>>? onChanged;
  /// Whether the list accepts reordering interactions.
  final bool enabled;
  /// Creates a [RawSortableList].
  ///
  /// Parameters:
  /// - [delegate] (`SortableListDelegate<T>`, required): Provides item data.
  /// - [builder] (`SortableWidgetBuilder<T>`, required): Builds item widgets.
  /// - [onChanged] (`ValueChanged<ListChanges<T>>?`, optional): Change callback.
  /// - [enabled] (`bool`, default: `true`): Whether reordering is enabled.
  const RawSortableList({super.key, required this.delegate, required this.builder, this.onChanged, this.enabled = true});
  Widget build(BuildContext context);
}
```
