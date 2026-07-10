import 'package:flutter/rendering.dart';

import '../../../shadcn_flutter.dart';

/// Builder function that creates sortable list items.
///
/// Called to construct items for a sortable list at the specified [index].
///
/// Parameters:
/// - [context] (`BuildContext`): Build context.
/// - [index] (`int`): Item index in the list.
///
/// Returns: `T` — the item data.
typedef SortableItemBuilder<T> = T Function(BuildContext context, int index);

/// Builder function that creates widgets for sortable list items.
///
/// Called to build the visual representation of a sortable item.
///
/// Parameters:
/// - [context] (`BuildContext`): Build context.
/// - [index] (`int`): Item index in the list.
/// - [item] (`T`): The item data to display.
///
/// Returns: `Widget` — the visual representation.
typedef SortableWidgetBuilder<T> = Widget Function(
    BuildContext context, int index, T item);

/// Represents a collection of list modifications.
///
/// Encapsulates multiple [ListChange] objects that can be applied to a list
/// in sequence. Useful for batch operations or undo/redo functionality.
class ListChanges<T> {
  /// The list of individual changes to apply.
  final List<ListChange<T>> changes;

  /// Creates a [ListChanges] with the specified [changes].
  const ListChanges(this.changes);

  /// Applies all changes to the given [list] in order.
  ///
  /// Parameters:
  /// - [list] (`List<T>`, required): The list to modify.
  void apply(List<T> list) {
    for (var change in changes) {
      change.apply(list);
    }
  }
}

/// Base class for list modification operations.
///
/// Extend this class to create custom list change types. Each change
/// implements [apply] to modify a list in a specific way.
abstract class ListChange<T> {
  /// Creates a [ListChange].
  const ListChange();

  /// Applies this change to the given [list].
  ///
  /// Parameters:
  /// - [list] (`List<T>`, required): The list to modify.
  void apply(List<T> list);
}

/// A list change that swaps two items.
///
/// Exchanges the items at positions [from] and [to] in the list.
class ListSwapChange<T> extends ListChange<T> {
  /// The source index.
  final int from;

  /// The destination index.
  final int to;

  /// Creates a [ListSwapChange] that swaps items at [from] and [to].
  const ListSwapChange(this.from, this.to);

  @override
  void apply(List<T> list) {
    var temp = list[from];
    list[from] = list[to];
    list[to] = temp;
  }
}

/// A list change that removes an item.
///
/// Removes the item at the specified [index] from the list.
class ListRemoveChange<T> extends ListChange<T> {
  /// The index of the item to remove.
  final int index;

  /// Creates a [ListRemoveChange] that removes the item at [index].
  const ListRemoveChange(this.index);

  @override
  void apply(List<T> list) {
    list.removeAt(index);
  }
}

/// A list change that inserts an item.
///
/// Inserts [item] at the specified [index] in the list.
class ListInsertChange<T> extends ListChange<T> {
  /// The index where the item will be inserted.
  final int index;

  /// The item to insert.
  final T item;

  /// Creates a [ListInsertChange] that inserts [item] at [index].
  const ListInsertChange(this.index, this.item);

  @override
  void apply(List<T> list) {
    list.insert(index, item);
  }
}

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
  const RawSortableList({
    super.key,
    required this.delegate,
    required this.builder,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

/// Parent data for sortable items within a [RawSortableStack].
///
/// Extends [ContainerBoxParentData] to include positioning information
/// for items in a sortable layout.
class RawSortableParentData extends ContainerBoxParentData<RenderBox> {
  /// The current position offset of this sortable item.
  Offset? position;
}

/// Widget that positions a sortable item at a specific offset.
///
/// Used internally by sortable lists to position items during drag
/// operations. Wraps a child widget and updates its parent data with
/// the specified [offset].
class RawSortableItemPositioned
    extends ParentDataWidget<RawSortableParentData> {
  /// The offset where the item should be positioned.
  final Offset offset;

  /// Creates a [RawSortableItemPositioned].
  ///
  /// Parameters:
  /// - [offset] (`Offset`, required): Position offset for the child.
  /// - [child] (`Widget`, required): The child widget to position.
  const RawSortableItemPositioned({
    super.key,
    required this.offset,
    required super.child,
  });

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as RawSortableParentData;
    if (parentData.position != offset) {
      parentData.position = offset;
      final targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => RawSortableStack;
}

/// RawSortableStack prevents the stacking children from going outside the bounds of this widget.
/// A raw sortable stack widget for managing layered sortable items.
///
/// Provides basic stacking functionality for sortable components without
/// additional layout or styling. Clamps child positions to widget bounds.
class RawSortableStack extends MultiChildRenderObjectWidget {
  /// Creates a raw sortable stack.
  const RawSortableStack({
    super.key,
    required super.children,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderRawSortableStack();
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderRawSortableStack renderObject) {
    renderObject.enabled = true;
  }
}

/// Render object for managing sortable item stacking and positioning.
///
/// Handles layout, painting, and hit testing for sortable items arranged
/// in a stack. Clamps child positions to widget bounds to prevent items
/// from escaping during drag operations.
class RenderRawSortableStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, RawSortableParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, RawSortableParentData> {
  /// Whether drag-and-drop interactions are enabled.
  bool enabled = true;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! RawSortableParentData) {
      child.parentData = RawSortableParentData();
    }
  }

  @override
  void performLayout() {
    var constraints = this.constraints;
    var child = firstChild;
    while (child != null) {
      var childParentData = child.parentData as RawSortableParentData;
      child.layout(constraints, parentUsesSize: true);
      child = childParentData.nextSibling;
    }
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var child = firstChild;
    while (child != null) {
      var childParentData = child.parentData as RawSortableParentData;
      context.paintChild(child, childParentData.position! + offset);
      child = childParentData.nextSibling;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    var child = lastChild;
    while (child != null) {
      var childParentData = child.parentData as RawSortableParentData;
      if ((childParentData.position! & child.size).contains(position)) {
        return result.addWithPaintOffset(
          offset: childParentData.position!,
          position: position,
          hitTest: (BoxHitTestResult result, Offset position) {
            return child!.hitTest(result,
                position: position - childParentData.position!);
          },
        );
      }
      child = childParentData.previousSibling;
    }
    return false;
  }
}

/// Abstract base for providing items to a sortable list.
///
/// Implement this class to create custom item sources for sortable lists.
/// Provides item count and item retrieval methods.
abstract class SortableListDelegate<T> {
  /// Creates a [SortableListDelegate].
  const SortableListDelegate();

  /// The number of items in the list.
  ///
  /// Returns `null` for infinite or unknown-length lists.
  int? get itemCount;

  /// Retrieves the item at the specified [index].
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context.
  /// - [index] (`int`, required): Item index.
  ///
  /// Returns: `T` — the item data.
  T getItem(BuildContext context, int index);
}

/// A delegate that provides items from an explicit list.
///
/// Wraps a fixed [List] of items for use in a sortable list.
class SortableChildListDelegate<T> extends SortableListDelegate<T> {
  /// The list of items.
  final List<T> items;

  /// Builder for creating item widgets.
  final SortableWidgetBuilder<T> builder;

  /// Creates a [SortableChildListDelegate].
  ///
  /// Parameters:
  /// - [items] (`List<T>`, required): The list of items.
  /// - [builder] (`SortableWidgetBuilder<T>`, required): Item widget builder.
  const SortableChildListDelegate(this.items, this.builder);

  @override
  int get itemCount => items.length;

  @override
  T getItem(BuildContext context, int index) => items[index];
}

/// A delegate that builds items on demand.
///
/// Creates items using a builder function rather than from a fixed list.
/// Useful for large or lazily-generated item sets.
class SortableChildBuilderDelegate<T> extends SortableListDelegate<T> {
  @override

  /// The number of items, or `null` for infinite lists.
  final int? itemCount;

  /// Builder function for creating items.
  final SortableItemBuilder<T> builder;

  /// Creates a [SortableChildBuilderDelegate].
  ///
  /// Parameters:
  /// - [itemCount] (`int?`, optional): Number of items, or `null` for infinite.
  /// - [builder] (`SortableItemBuilder<T>`, required): Item builder function.
  const SortableChildBuilderDelegate({this.itemCount, required this.builder});

  @override
  T getItem(BuildContext context, int index) => builder(context, index);
}
