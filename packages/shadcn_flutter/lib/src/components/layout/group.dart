import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A multi-child layout widget that positions children using absolute coordinates.
///
/// Similar to Flutter's [Stack] but with more explicit positioning control.
/// Children are positioned using [GroupPositioned] widgets that specify their
/// exact location and/or size within the group's bounds.
///
/// Example:
/// ```dart
/// GroupWidget(
///   children: [
///     GroupPositioned(
///       top: 10,
///       left: 10,
///       child: Text('Positioned text'),
///     ),
///   ],
/// )
/// ```
class GroupWidget extends MultiChildRenderObjectWidget {
  /// Creates a [GroupWidget].
  const GroupWidget({
    super.key,
    super.children,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderGroup();
  }

  @override
  void updateRenderObject(BuildContext context, RenderGroup renderObject) {}
}

/// Parent data for children of [GroupWidget].
///
/// Stores positioning and sizing information for each child widget within
/// a [GroupWidget]. These values are set by [GroupPositioned].
class GroupParentData extends ContainerBoxParentData<RenderBox> {
  /// Distance from the top edge of the group.
  double? top;

  /// Distance from the left edge of the group.
  double? left;

  /// Distance from the right edge of the group.
  double? right;

  /// Distance from the bottom edge of the group.
  double? bottom;

  /// Explicit width of the child.
  double? width;

  /// Explicit height of the child.
  double? height;
}

/// Render object for [GroupWidget] that handles absolute positioning of children.
///
/// Manages layout and painting of children positioned using [GroupParentData].
class RenderGroup extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, GroupParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, GroupParentData> {
  /// Creates a [RenderGroup].
  ///
  /// Parameters:
  /// - [children] (`List<RenderBox>?`, optional): Initial list of child render objects.
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

/// Positions a child widget within a [GroupWidget].
///
/// Controls the position and optionally the size of a child using absolute
/// coordinates. At least one positioning parameter should be provided.
///
/// Example:
/// ```dart
/// GroupPositioned(
///   top: 20,
///   left: 20,
///   width: 100,
///   height: 50,
///   child: Container(color: Colors.blue),
/// )
/// ```
class GroupPositioned extends ParentDataWidget<GroupParentData> {
  /// Creates a [GroupPositioned].
  ///
  /// Parameters:
  /// - [top] (`double?`, optional): Distance from top edge.
  /// - [left] (`double?`, optional): Distance from left edge.
  /// - [right] (`double?`, optional): Distance from right edge.
  /// - [bottom] (`double?`, optional): Distance from bottom edge.
  /// - [width] (`double?`, optional): Explicit width.
  /// - [height] (`double?`, optional): Explicit height.
  /// - [child] (`Widget`, required): The child to position.
  const GroupPositioned({
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required super.child,
  });

  /// Creates a [GroupPositioned] that fills the entire group bounds.
  ///
  /// Sets all edges to 0, making the child fill the available space.
  const GroupPositioned.fill({
    super.key,
    this.top = 0,
    this.left = 0,
    this.right = 0,
    this.bottom = 0,
    this.width,
    this.height,
    required super.child,
  });

  /// Creates a [GroupPositioned] from a [Rect].
  ///
  /// Positions and sizes the child according to the given rectangle.
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

  /// Distance from the top edge of the group.
  final double? top;

  /// Distance from the left edge of the group.
  final double? left;

  /// Distance from the right edge of the group.
  final double? right;

  /// Distance from the bottom edge of the group.
  final double? bottom;

  /// Explicit width of the child.
  final double? width;

  /// Explicit height of the child.
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
