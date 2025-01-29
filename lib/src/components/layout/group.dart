import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class GroupWidget extends MultiChildRenderObjectWidget {
  GroupWidget({
    Key? key,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderGroup();
  }

  @override
  void updateRenderObject(BuildContext context, RenderGroup renderObject) {}
}

class GroupParentData extends ContainerBoxParentData<RenderBox> {
  double? top;
  double? left;
  double? right;
  double? bottom;
  double? width;
  double? height;
}

class RenderGroup extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, GroupParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, GroupParentData> {
  RenderGroup({
    List<RenderBox>? children,
  }) {
    addAll(children);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! GroupParentData) {
      child.parentData = GroupParentData();
    }
  }

  @override
  void performLayout() {
    var child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as GroupParentData;

      double? top = childParentData.top;
      double? left = childParentData.left;
      double? right = childParentData.right;
      double? bottom = childParentData.bottom;
      double? width = childParentData.width;
      double? height = childParentData.height;

      // do positioned layouting
      double offsetX = 0;
      double offsetY = 0;
      double childWidth = 0;
      double childHeight = 0;
      if (top != null && bottom != null) {
        offsetY = top;
        childHeight = constraints.maxHeight - (top + bottom);
      } else {
        // either top or bottom is null
        if (top != null) {
          offsetY = top;
        } else if (bottom != null) {
          offsetY = constraints.maxHeight - bottom;
        }
        if (height != null) {
          childHeight = height;
        } else {
          childHeight = constraints.maxHeight;
        }
      }
      if (left != null && right != null) {
        offsetX = left;
        childWidth = constraints.maxWidth - (left + right);
      } else {
        // either left or right is null
        if (left != null) {
          offsetX = left;
        } else if (right != null) {
          offsetX = constraints.maxWidth - right;
        }
        if (width != null) {
          childWidth = width;
        } else {
          childWidth = constraints.maxWidth;
        }
      }
      child.layout(
          BoxConstraints.tightFor(width: childWidth, height: childHeight),
          parentUsesSize: true);
      if (top == null && bottom != null) {
        offsetY -= child.size.height;
      }
      if (left == null && right != null) {
        offsetX -= child.size.width;
      }
      childParentData.offset = Offset(offsetX, offsetY);
      child = childParentData.nextSibling;
    }
    size = constraints.biggest;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    var child = firstChild;
    while (child != null) {
      final childParentData = child.parentData as GroupParentData;
      context.paintChild(child, offset + childParentData.offset);
      child = childParentData.nextSibling;
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return hitTestChildren(result, position: position);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    var child = lastChild;
    while (child != null) {
      // The x, y parameters have the top left of the node's box as the origin.
      final childParentData = child.parentData! as GroupParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child!.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
      child = childParentData.previousSibling;
    }
    return false;
  }
}

class GroupPositioned extends ParentDataWidget<GroupParentData> {
  const GroupPositioned({
    Key? key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required Widget child,
  }) : super(key: key, child: child);

  const GroupPositioned.fill({
    Key? key,
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
    this.width,
    this.height,
    required Widget child,
  }) : super(key: key, child: child);
  GroupPositioned.fromRect({
    super.key,
    required Rect rect,
    required super.child,
  })  : left = rect.left,
        top = rect.top,
        width = rect.width,
        height = rect.height,
        right = null,
        bottom = null;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? width;
  final double? height;

  @override
  void applyParentData(RenderObject renderObject) {
    final parentData = renderObject.parentData as GroupParentData;
    bool needsLayout = false;

    if (parentData.top != top) {
      parentData.top = top;
      needsLayout = true;
    }
    if (parentData.left != left) {
      parentData.left = left;
      needsLayout = true;
    }
    if (parentData.right != right) {
      parentData.right = right;
      needsLayout = true;
    }
    if (parentData.bottom != bottom) {
      parentData.bottom = bottom;
      needsLayout = true;
    }
    if (parentData.width != width) {
      parentData.width = width;
      needsLayout = true;
    }
    if (parentData.height != height) {
      parentData.height = height;
      needsLayout = true;
    }

    if (needsLayout) {
      final targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => GroupWidget;
}
