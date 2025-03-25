import 'package:flutter/rendering.dart';

import '../../../shadcn_flutter.dart';

typedef SortableItemBuilder<T> = T Function(BuildContext context, int index);
typedef SortableWidgetBuilder<T> = Widget Function(
    BuildContext context, int index, T item);

class ListChanges<T> {
  final List<ListChange<T>> changes;
  const ListChanges(this.changes);

  void apply(List<T> list) {
    for (var change in changes) {
      change.apply(list);
    }
  }
}

abstract class ListChange<T> {
  const ListChange();
  void apply(List<T> list);
}

class ListSwapChange<T> extends ListChange<T> {
  final int from;
  final int to;
  const ListSwapChange(this.from, this.to);

  @override
  void apply(List<T> list) {
    var temp = list[from];
    list[from] = list[to];
    list[to] = temp;
  }
}

class ListRemoveChange<T> extends ListChange<T> {
  final int index;
  const ListRemoveChange(this.index);

  @override
  void apply(List<T> list) {
    list.removeAt(index);
  }
}

class ListInsertChange<T> extends ListChange<T> {
  final int index;
  final T item;
  const ListInsertChange(this.index, this.item);

  @override
  void apply(List<T> list) {
    list.insert(index, item);
  }
}

class RawSortableList<T> extends StatelessWidget {
  final SortableListDelegate<T> delegate;
  final SortableWidgetBuilder<T> builder;
  final ValueChanged<ListChanges<T>>? onChanged;
  final bool enabled;
  const RawSortableList({super.key, 
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

class RawSortableParentData extends ContainerBoxParentData<RenderBox> {
  Offset? position;
}

class RawSortableItemPositioned
    extends ParentDataWidget<RawSortableParentData> {
  final Offset offset;
  @override
  final Widget child;
  const RawSortableItemPositioned({
    super.key,
    required this.offset,
    required this.child,
  }) : super(child: child);

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
/// It will clamp the position of the children to the bounds of this widget.
class RawSortableStack extends MultiChildRenderObjectWidget {
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

class RenderRawSortableStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, RawSortableParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, RawSortableParentData> {
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

abstract class SortableListDelegate<T> {
  const SortableListDelegate();
  int? get itemCount;
  T getItem(BuildContext context, int index);
}

class SortableChildListDelegate<T> extends SortableListDelegate<T> {
  final List<T> items;
  final SortableWidgetBuilder<T> builder;
  const SortableChildListDelegate(this.items, this.builder);

  @override
  int get itemCount => items.length;

  @override
  T getItem(BuildContext context, int index) => items[index];
}

class SortableChildBuilderDelegate<T> extends SortableListDelegate<T> {
  @override
  final int? itemCount;
  final SortableItemBuilder<T> builder;
  const SortableChildBuilderDelegate({this.itemCount, required this.builder});

  @override
  T getItem(BuildContext context, int index) => builder(context, index);
}
