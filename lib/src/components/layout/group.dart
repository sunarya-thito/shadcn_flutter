import 'package:flutter/rendering.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A flexible layout widget that positions children using absolute positioning constraints.
///
/// [GroupWidget] provides a layout system similar to CSS absolute positioning,
/// where children can be positioned relative to the container using top, left,
/// right, bottom constraints along with explicit width and height values.
///
/// ## Positioning System
///
/// Each child is positioned based on its [GroupParentData] which supports:
/// - **Edge constraints**: top, left, right, bottom values for positioning
/// - **Size constraints**: width, height values for explicit sizing
/// - **Flexible sizing**: Automatic sizing when constraints are not fully specified
///
/// ## Constraint Resolution
///
/// The layout algorithm follows these rules:
/// - When both top and bottom are specified, height is calculated automatically
/// - When both left and right are specified, width is calculated automatically  
/// - When only one edge is specified, the child is positioned from that edge
/// - When no size is specified, the child uses the container's full dimensions
///
/// ## Use Cases
///
/// GroupWidget is particularly useful for:
/// - Overlay positioning (tooltips, dropdowns, modals)
/// - Complex dashboard layouts with fixed positioning
/// - Custom layout managers that need precise control
/// - Recreating CSS-style absolute positioning in Flutter
///
/// Example:
/// ```dart
/// GroupWidget(
///   children: [
///     // Background covering entire area
///     Positioned.fromRelativeRect(
///       rect: RelativeRect.fill,
///       child: Container(color: Colors.grey[100]),
///     ),
///     
///     // Top-left corner widget
///     Positioned(
///       top: 16,
///       left: 16,
///       width: 100,
///       height: 50,
///       child: ElevatedButton(
///         onPressed: () => {},
///         child: Text('Action'),
///       ),
///     ),
///     
///     // Bottom-right corner with automatic sizing
///     Positioned(
///       right: 16,
///       bottom: 16,
///       child: Icon(Icons.help),
///     ),
///   ],
/// );
/// ```
///
/// **Note**: This is a low-level layout widget. Consider using Flutter's built-in
/// [Stack] widget for most absolute positioning needs, as it provides similar
/// functionality with better performance optimizations.
class GroupWidget extends MultiChildRenderObjectWidget {
  /// Creates a [GroupWidget] with positioned children.
  ///
  /// The [children] list should contain widgets that will be positioned
  /// using their associated [GroupParentData]. Use [Positioned] widgets
  /// or manually set parent data to control positioning.
  ///
  /// Example:
  /// ```dart
  /// GroupWidget(
  ///   children: [
  ///     Positioned(
  ///       top: 10,
  ///       left: 10,
  ///       child: Text('Top Left'),
  ///     ),
  ///     Positioned(
  ///       bottom: 10,
  ///       right: 10,
  ///       child: Text('Bottom Right'),
  ///     ),
  ///   ],
  /// );
  /// ```
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

/// Parent data for [GroupWidget] children that defines positioning constraints.
///
/// [GroupParentData] extends [ContainerBoxParentData] to store positioning
/// and sizing information for children within a [GroupWidget]. This data
/// structure enables CSS-like absolute positioning with flexible constraint
/// resolution.
///
/// ## Properties
///
/// The positioning system supports six constraint types:
/// - **Edge positioning**: [top], [left], [right], [bottom] - distances from container edges
/// - **Explicit sizing**: [width], [height] - fixed dimensions for the child
///
/// ## Constraint Interactions
///
/// When conflicting constraints are provided, the layout algorithm prioritizes:
/// 1. Edge-based sizing over explicit dimensions
/// 2. Top/left positioning over bottom/right when size is explicit
/// 3. Container dimensions as fallback when no constraints are specified
///
/// Example usage:
/// ```dart
/// // Position 20px from top and left, with fixed 100x50 size
/// final parentData = GroupParentData()
///   ..top = 20
///   ..left = 20
///   ..width = 100
///   ..height = 50;
///
/// // Stretch between left and right edges, 30px from top
/// final stretchData = GroupParentData()
///   ..top = 30
///   ..left = 10
///   ..right = 10;  // width calculated automatically
/// ```
class GroupParentData extends ContainerBoxParentData<RenderBox> {
  /// Distance from the top edge of the container.
  ///
  /// When combined with [bottom], the [height] is calculated automatically.
  /// When only [top] is specified, positions the child from the top edge.
  double? top;

  /// Distance from the left edge of the container.
  ///
  /// When combined with [right], the [width] is calculated automatically.
  /// When only [left] is specified, positions the child from the left edge.
  double? left;

  /// Distance from the right edge of the container.
  ///
  /// When combined with [left], the [width] is calculated automatically.
  /// When only [right] is specified, positions the child from the right edge.
  double? right;

  /// Distance from the bottom edge of the container.
  ///
  /// When combined with [top], the [height] is calculated automatically.
  /// When only [bottom] is specified, positions the child from the bottom edge.
  double? bottom;

  /// Explicit width of the child widget.
  ///
  /// Ignored when both [left] and [right] are specified, as width is
  /// calculated from the edge constraints.
  double? width;

  /// Explicit height of the child widget.
  ///
  /// Ignored when both [top] and [bottom] are specified, as height is
  /// calculated from the edge constraints.
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
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.width,
    this.height,
    required super.child,
  });

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
