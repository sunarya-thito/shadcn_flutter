import 'dart:ui' show Offset;

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/rendering.dart' as rendering;
import 'package:flutter/widgets.dart' as widgets;

export 'package:flutter/rendering.dart'
    show
        FlexFit,
        MainAxisSize,
        MainAxisAlignment,
        CrossAxisAlignment,
        VerticalDirection,
        StackFit;

// ============================================================================
// Paint Order Mixin - shared logic for sorting children by paint order
// ============================================================================

/// Mixin for parent data that supports paint ordering.
mixin PaintOrderParentDataMixin
    on rendering.ContainerBoxParentData<rendering.RenderBox> {
  /// The paint order of this child. Higher values are painted on top.
  /// If null, uses the default order (0).
  int? paintOrder;

  /// Next sibling in the sorted paint order linked list.
  rendering.RenderBox? nextSortedSibling;

  /// Previous sibling in the sorted paint order linked list.
  rendering.RenderBox? previousSortedSibling;

  /// Internal index used for sorting.
  int paintIndex = 0;
}

/// Mixin for render objects that support custom paint order.
///
/// This mixin provides the sorting logic for painting children in a custom order
/// based on their [PaintOrderParentDataMixin.paintOrder] property.
mixin PaintOrderMixin on rendering.RenderBox {
  /// The first child in the sorted paint order.
  rendering.RenderBox? firstSortedChild;

  /// The last child in the sorted paint order.
  rendering.RenderBox? lastSortedChild;

  /// Get the first child - must be implemented by the render object.
  rendering.RenderBox? get paintOrderFirstChild;

  /// Builds a sorted linked list of children based on their paint order.
  ///
  /// Children without a paint order default to 0 and are painted in their
  /// natural layout order. Children with a positive paint order are painted
  /// above them.
  void buildSortedLinkedList() {
    final first = paintOrderFirstChild;
    if (first == null) {
      firstSortedChild = null;
      lastSortedChild = null;
      return;
    }

    rendering.RenderBox? child = first;
    rendering.RenderBox? prev;
    bool needsSort = false;
    int childCount = 0;

    while (child != null) {
      final parentData = child.parentData! as PaintOrderParentDataMixin;
      final order = parentData.paintOrder;
      parentData.paintIndex = order ?? 0;
      if (order != null) {
        needsSort = true;
      }
      parentData.previousSortedSibling = prev;
      if (prev != null) {
        (prev.parentData! as PaintOrderParentDataMixin).nextSortedSibling =
            child;
      }
      prev = child;
      child = parentData.nextSibling;
      childCount++;
    }

    if (prev != null) {
      (prev.parentData! as PaintOrderParentDataMixin).nextSortedSibling = null;
    }

    firstSortedChild = first;
    lastSortedChild = prev;

    if (!needsSort) {
      return;
    }

    // Merge sort the linked list
    firstSortedChild = _mergeSort(first, childCount);

    // Fix previous pointers
    rendering.RenderBox? current = firstSortedChild;
    prev = null;
    while (current != null) {
      final parentData = current.parentData! as PaintOrderParentDataMixin;
      parentData.previousSortedSibling = prev;
      prev = current;
      current = parentData.nextSortedSibling;
    }
    lastSortedChild = prev;
  }

  rendering.RenderBox? _mergeSort(rendering.RenderBox? head, int length) {
    if (head == null || length <= 1) {
      return head;
    }

    final int mid = length ~/ 2;
    rendering.RenderBox? current = head;
    for (int i = 0; i < mid - 1 && current != null; i++) {
      current =
          (current.parentData! as PaintOrderParentDataMixin).nextSortedSibling;
    }

    rendering.RenderBox? secondHalf;
    if (current != null) {
      final parentData = current.parentData! as PaintOrderParentDataMixin;
      secondHalf = parentData.nextSortedSibling;
      parentData.nextSortedSibling = null;
    }

    final rendering.RenderBox? left = _mergeSort(head, mid);
    final rendering.RenderBox? right = _mergeSort(secondHalf, length - mid);

    return _merge(left, right);
  }

  rendering.RenderBox? _merge(
      rendering.RenderBox? left, rendering.RenderBox? right) {
    if (left == null) return right;
    if (right == null) return left;

    rendering.RenderBox? head;
    rendering.RenderBox? tail;

    final leftData = left.parentData! as PaintOrderParentDataMixin;
    final rightData = right.parentData! as PaintOrderParentDataMixin;

    if (leftData.paintIndex <= rightData.paintIndex) {
      head = left;
      left = leftData.nextSortedSibling;
    } else {
      head = right;
      right = rightData.nextSortedSibling;
    }
    tail = head;

    while (left != null && right != null) {
      final leftData = left.parentData! as PaintOrderParentDataMixin;
      final rightData = right.parentData! as PaintOrderParentDataMixin;

      if (leftData.paintIndex <= rightData.paintIndex) {
        (tail!.parentData! as PaintOrderParentDataMixin).nextSortedSibling =
            left;
        tail = left;
        left = leftData.nextSortedSibling;
      } else {
        (tail!.parentData! as PaintOrderParentDataMixin).nextSortedSibling =
            right;
        tail = right;
        right = rightData.nextSortedSibling;
      }
    }

    (tail!.parentData! as PaintOrderParentDataMixin).nextSortedSibling =
        left ?? right;

    return head;
  }

  /// Paints children in sorted paint order.
  void paintSorted(rendering.PaintingContext context, Offset offset) {
    rendering.RenderBox? child = firstSortedChild;
    while (child != null) {
      final parentData = child.parentData! as PaintOrderParentDataMixin;
      context.paintChild(child, parentData.offset + offset);
      child = parentData.nextSortedSibling;
    }
  }

  /// Hit tests children in reverse sorted paint order (top-most first).
  bool hitTestSortedChildren(rendering.BoxHitTestResult result,
      {required Offset position}) {
    rendering.RenderBox? child = lastSortedChild;
    while (child != null) {
      final parentData = child.parentData! as PaintOrderParentDataMixin;
      final bool isHit = result.addWithPaintOffset(
        offset: parentData.offset,
        position: position,
        hitTest: (rendering.BoxHitTestResult result, Offset transformed) {
          return child!.hitTest(result, position: transformed);
        },
      );
      if (isHit) return true;
      child = parentData.previousSortedSibling;
    }
    return false;
  }
}

// ============================================================================
// Flex patch - supports custom paint ordering
// ============================================================================

/// Parent data for use with [RenderFlex].
///
/// Extends the base [rendering.FlexParentData] to add paint order support.
class FlexParentData extends rendering.FlexParentData
    with PaintOrderParentDataMixin {
  @override
  String toString() => '${super.toString()}; paintOrder=$paintOrder';
}

/// A patched version of [rendering.RenderFlex] that supports custom paint ordering.
class RenderFlex extends rendering.RenderFlex with PaintOrderMixin {
  /// Creates a flex render object with paint order support.
  RenderFlex({
    super.children,
    super.direction,
    super.mainAxisSize,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.clipBehavior,
    super.spacing,
  });

  bool _hasOverflow = false;

  @override
  rendering.RenderBox? get paintOrderFirstChild => firstChild;

  @override
  void setupParentData(rendering.RenderBox child) {
    if (child.parentData is! FlexParentData) {
      child.parentData = FlexParentData();
    }
  }

  @override
  void performLayout() {
    super.performLayout();
    buildSortedLinkedList();
    _hasOverflow = _checkOverflow();
  }

  bool _checkOverflow() {
    rendering.RenderBox? child = firstChild;
    final parentRect = Offset.zero & size;
    while (child != null) {
      final parentData = child.parentData! as FlexParentData;
      final childRect = parentData.offset & child.size;
      if (!parentRect.contains(childRect.topLeft) ||
          !parentRect.contains(childRect.bottomRight)) {
        return true;
      }
      child = parentData.nextSibling;
    }
    return false;
  }

  @override
  void paint(rendering.PaintingContext context, Offset offset) {
    if (!_hasOverflow) {
      paintSorted(context, offset);
      return;
    }

    if (size.isEmpty) {
      return;
    }

    context.pushClipRect(
      needsCompositing,
      offset,
      Offset.zero & size,
      paintSorted,
      clipBehavior: clipBehavior,
    );
  }

  @override
  bool hitTestChildren(rendering.BoxHitTestResult result,
      {required Offset position}) {
    return hitTestSortedChildren(result, position: position);
  }
}

/// A widget that displays its children in a one-dimensional array.
///
/// The [Flex] widget allows you to control the axis along which the children are
/// placed (horizontal or vertical). This is referred to as the _main axis_. If
/// you know the main axis in advance, then consider using a [Row] (if it's
/// horizontal) or [Column] (if it's vertical) instead, because that will be less
/// verbose.
///
/// To cause a child to expand to fill the available space in the [direction]
/// of this widget's main axis, wrap the child in an [Expanded] widget.
///
/// The [Flex] widget does not scroll (and in general it is considered an error
/// to have more children in a [Flex] than will fit in the available room). If
/// you have some widgets and want them to be able to scroll if there is
/// insufficient room, consider using a [ListView].
///
/// This patched version supports custom paint ordering via [PaintOrder] or
/// [Flexible.paintOrder].
///
/// See also:
///
///  * [Row], for a horizontal arrangement of children.
///  * [Column], for a vertical arrangement of children.
///  * [Expanded], to indicate children that should take all remaining room.
///  * [Flexible], to indicate children that should share remaining room.
///  * [PaintOrder], to control the paint order of children.
class Flex extends widgets.Flex {
  /// Creates a flex layout with paint order support.
  const Flex({
    super.key,
    required super.direction,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.clipBehavior,
    super.spacing,
    super.children,
  });

  @override
  RenderFlex createRenderObject(widgets.BuildContext context) {
    return RenderFlex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
      spacing: spacing,
    );
  }

  @override
  void updateRenderObject(
      widgets.BuildContext context, covariant RenderFlex renderObject) {
    renderObject
      ..direction = direction
      ..mainAxisAlignment = mainAxisAlignment
      ..mainAxisSize = mainAxisSize
      ..crossAxisAlignment = crossAxisAlignment
      ..textDirection = getEffectiveTextDirection(context)
      ..verticalDirection = verticalDirection
      ..textBaseline = textBaseline
      ..clipBehavior = clipBehavior
      ..spacing = spacing;
  }
}

/// A widget that displays its children in a horizontal array.
///
/// To cause a child to expand to fill the available horizontal space, wrap the
/// child in an [Expanded] widget.
///
/// The [Row] widget does not scroll (and in general it is considered an error
/// to have more children in a [Row] than will fit in the available room). If
/// you have a line of widgets and want them to be able to scroll if there is
/// insufficient room, consider using a [ListView].
///
/// For a vertical variant, see [Column].
///
/// This patched version supports custom paint ordering via [PaintOrder] or
/// [Flexible.paintOrder].
///
/// See also:
///
///  * [Column], for a vertical equivalent.
///  * [Expanded], to indicate children that should take all remaining room.
///  * [Flexible], to indicate children that should share remaining room.
///  * [PaintOrder], to control the paint order of children.
class Row extends Flex {
  /// Creates a horizontal array of children with paint order support.
  const Row({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.spacing,
    super.children,
    super.clipBehavior,
  }) : super(direction: widgets.Axis.horizontal);
}

/// A widget that displays its children in a vertical array.
///
/// To cause a child to expand to fill the available vertical space, wrap the
/// child in an [Expanded] widget.
///
/// The [Column] widget does not scroll (and in general it is considered an
/// error to have more children in a [Column] than will fit in the available
/// room). If you have a line of widgets and want them to be able to scroll if
/// there is insufficient room, consider using a [ListView].
///
/// For a horizontal variant, see [Row].
///
/// This patched version supports custom paint ordering via [PaintOrder] or
/// [Flexible.paintOrder].
///
/// See also:
///
///  * [Row], for a horizontal equivalent.
///  * [Expanded], to indicate children that should take all remaining room.
///  * [Flexible], to indicate children that should share remaining room.
///  * [PaintOrder], to control the paint order of children.
class Column extends Flex {
  /// Creates a vertical array of children with paint order support.
  const Column({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.spacing,
    super.children,
    super.clipBehavior,
  }) : super(direction: widgets.Axis.vertical);
}

/// A widget that controls how a child of a [Row], [Column], or [Flex] flexes.
///
/// Using a [Flexible] widget gives a child of a [Row], [Column], or [Flex]
/// the flexibility to expand to fill the available space in the main axis
/// (e.g., horizontally for a [Row] or vertically for a [Column]), but, unlike
/// [Expanded], [Flexible] does not require the child to fill the available
/// space.
///
/// A [Flexible] widget must be a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Flexible] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
///
/// This patched version also supports [paintOrder] to control the painting
/// order of children.
///
/// See also:
///
///  * [Expanded], which forces the child to expand to fill the available space.
///  * [PaintOrder], to control paint order without affecting flex behavior.
class Flexible extends widgets.ParentDataWidget<FlexParentData> {
  /// Creates a widget that controls how a child of a [Row], [Column], or [Flex] flexes.
  const Flexible({
    super.key,
    this.flex = 1,
    this.fit = rendering.FlexFit.loose,
    this.paintOrder,
    required super.child,
  });

  /// The flex factor to use for this child.
  final int flex;

  /// How a flexible child is inscribed into the available space.
  final rendering.FlexFit fit;

  /// The paint order of this child. Higher values are painted on top.
  final int? paintOrder;

  @override
  void applyParentData(rendering.RenderObject renderObject) {
    assert(renderObject.parentData is FlexParentData);
    final parentData = renderObject.parentData! as FlexParentData;
    bool needsLayout = false;

    if (parentData.flex != flex) {
      parentData.flex = flex;
      needsLayout = true;
    }

    if (parentData.fit != fit) {
      parentData.fit = fit;
      needsLayout = true;
    }

    if (parentData.paintOrder != paintOrder) {
      parentData.paintOrder = paintOrder;
      needsLayout = true;
    }

    if (needsLayout) {
      renderObject.parent?.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Flex;

  @override
  void debugFillProperties(foundation.DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(foundation.IntProperty('flex', flex));
    properties.add(foundation.EnumProperty<rendering.FlexFit>('fit', fit));
    properties.add(foundation.IntProperty('paintOrder', paintOrder));
  }
}

/// A widget that expands a child of a [Row], [Column], or [Flex]
/// so that the child fills the available space.
///
/// Using an [Expanded] widget makes a child of a [Row], [Column], or [Flex]
/// expand to fill the available space along the main axis (e.g., horizontally
/// for a [Row] or vertically for a [Column]). If multiple children are
/// expanded, the available space is divided among them according to the [flex]
/// factor.
///
/// An [Expanded] widget must be a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Expanded] widget to its enclosing [Row], [Column],
/// or [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not
/// other kinds of widgets, like [RenderObjectWidget]s).
///
/// This patched version also supports [paintOrder] to control the painting
/// order of children.
///
/// See also:
///
///  * [Flexible], which does not force the child to fill the available space.
///  * [PaintOrder], to control paint order without affecting flex behavior.
class Expanded extends Flexible {
  /// Creates a widget that expands a child of a [Row], [Column], or [Flex].
  const Expanded({
    super.key,
    super.flex,
    super.paintOrder,
    required super.child,
  }) : super(fit: rendering.FlexFit.tight);
}

/// A widget that sets the paint order of a non-flexible child in a [Row], [Column], or [Flex].
class PaintOrder extends widgets.ParentDataWidget<FlexParentData> {
  /// Creates a widget that sets the paint order of a child.
  const PaintOrder({
    super.key,
    required this.paintOrder,
    required super.child,
  });

  /// The paint order of this child. Higher values are painted on top.
  final int paintOrder;

  @override
  void applyParentData(rendering.RenderObject renderObject) {
    assert(renderObject.parentData is FlexParentData);
    final parentData = renderObject.parentData! as FlexParentData;
    if (parentData.paintOrder != paintOrder) {
      parentData.paintOrder = paintOrder;
      renderObject.parent?.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Flex;

  @override
  void debugFillProperties(foundation.DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(foundation.IntProperty('paintOrder', paintOrder));
  }
}

// ============================================================================
// Stack patch - supports custom paint ordering
// ============================================================================

/// Parent data for use with [RenderStack].
class StackParentData extends rendering.StackParentData
    with PaintOrderParentDataMixin {
  @override
  String toString() => '${super.toString()}; paintOrder=$paintOrder';
}

/// A patched version of [rendering.RenderStack] that supports custom paint ordering.
class RenderStack extends rendering.RenderStack with PaintOrderMixin {
  /// Creates a stack render object with paint order support.
  RenderStack({
    super.children,
    super.alignment,
    super.textDirection,
    super.fit,
    super.clipBehavior,
  });

  @override
  rendering.RenderBox? get paintOrderFirstChild => firstChild;

  @override
  void setupParentData(rendering.RenderBox child) {
    if (child.parentData is! StackParentData) {
      child.parentData = StackParentData();
    }
  }

  @override
  void performLayout() {
    super.performLayout();
    buildSortedLinkedList();
  }

  @override
  void paintStack(rendering.PaintingContext context, Offset offset) {
    paintSorted(context, offset);
  }

  @override
  bool hitTestChildren(rendering.BoxHitTestResult result,
      {required Offset position}) {
    return hitTestSortedChildren(result, position: position);
  }
}

/// A widget that positions its children relative to the edges of its box.
///
/// This class is useful if you want to overlap several children in a simple
/// way, for example having some text and an image, overlaid with a gradient
/// and a button attached to the bottom.
///
/// Each child of a [Stack] widget is either _positioned_ or _non-positioned_.
/// Positioned children are those wrapped in a [Positioned] widget that has at
/// least one non-null property. The stack sizes itself to contain all the
/// non-positioned children, which are positioned according to [alignment]
/// (which defaults to the top-left corner in left-to-right environments and
/// the top-right corner in right-to-left environments). The positioned
/// children are then placed relative to the stack according to their top,
/// right, bottom, and left properties.
///
/// This patched version supports custom paint ordering via [Positioned.paintOrder].
///
/// See also:
///
///  * [Positioned], for positioning children within this stack.
///  * [Align], which sizes itself based on its child's size and positions
///    the child according to an [Alignment] value.
class Stack extends widgets.Stack {
  /// Creates a stack with paint order support.
  const Stack({
    super.key,
    super.alignment,
    super.textDirection,
    super.fit,
    super.clipBehavior,
    super.children,
  });

  @override
  RenderStack createRenderObject(widgets.BuildContext context) {
    assert(_debugCheckHasDirectionality(context));
    return RenderStack(
      alignment: alignment,
      textDirection: textDirection ?? widgets.Directionality.maybeOf(context),
      fit: fit,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
      widgets.BuildContext context, covariant RenderStack renderObject) {
    assert(_debugCheckHasDirectionality(context));
    renderObject
      ..alignment = alignment
      ..textDirection = textDirection ?? widgets.Directionality.maybeOf(context)
      ..fit = fit
      ..clipBehavior = clipBehavior;
  }

  bool _debugCheckHasDirectionality(widgets.BuildContext context) {
    if (alignment is! widgets.AlignmentDirectional) {
      return true;
    }
    assert(
      textDirection != null || widgets.Directionality.maybeOf(context) != null,
      'Stack alignment requires a TextDirection',
    );
    return true;
  }
}

/// A widget that controls where a child of a [Stack] is positioned.
///
/// A [Positioned] widget must be a descendant of a [Stack], and the path from
/// the [Positioned] widget to its enclosing [Stack] must contain only
/// [StatelessWidget]s or [StatefulWidget]s (not other kinds of widgets, like
/// [RenderObjectWidget]s).
///
/// If a widget is wrapped in a [Positioned], then it is a _positioned_ widget
/// in its [Stack]. If the [top] property is non-null, the top edge of this child
/// will be positioned [top] layout units from the top of the stack widget. The
/// [right], [bottom], and [left] properties work analogously.
///
/// If both the [top] and [bottom] properties are non-null, then the child will
/// be forced to have exactly the height required to satisfy both constraints.
/// Similarly, setting the [right] and [left] properties to non-null values will
/// force the child to have a particular width.
///
/// This patched version also supports [paintOrder] to control the painting
/// order of children.
///
/// See also:
///
///  * [Stack], which uses positioned children.
class Positioned extends widgets.ParentDataWidget<StackParentData> {
  /// Creates a positioned widget with paint order support.
  const Positioned({
    super.key,
    this.left,
    this.top,
    this.right,
    this.bottom,
    this.width,
    this.height,
    this.paintOrder,
    required super.child,
  })  : assert(left == null || right == null || width == null),
        assert(top == null || bottom == null || height == null);

  /// Creates a Positioned with all edges set to 0.0 unless specified.
  const Positioned.fill({
    super.key,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.bottom = 0.0,
    this.paintOrder,
    required super.child,
  })  : width = null,
        height = null;

  /// The distance that the child's left edge is inset from the left of the stack.
  final double? left;

  /// The distance that the child's top edge is inset from the top of the stack.
  final double? top;

  /// The distance that the child's right edge is inset from the right of the stack.
  final double? right;

  /// The distance that the child's bottom edge is inset from the bottom of the stack.
  final double? bottom;

  /// The child's width.
  final double? width;

  /// The child's height.
  final double? height;

  /// The paint order of this child. Higher values are painted on top.
  final int? paintOrder;

  @override
  void applyParentData(rendering.RenderObject renderObject) {
    assert(renderObject.parentData is StackParentData);
    final parentData = renderObject.parentData! as StackParentData;
    bool needsLayout = false;

    if (parentData.left != left) {
      parentData.left = left;
      needsLayout = true;
    }
    if (parentData.top != top) {
      parentData.top = top;
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
    if (parentData.paintOrder != paintOrder) {
      parentData.paintOrder = paintOrder;
      needsLayout = true;
    }

    if (needsLayout) {
      renderObject.parent?.markNeedsLayout();
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => Stack;

  @override
  void debugFillProperties(foundation.DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(foundation.DoubleProperty('left', left, defaultValue: null));
    properties.add(foundation.DoubleProperty('top', top, defaultValue: null));
    properties
        .add(foundation.DoubleProperty('right', right, defaultValue: null));
    properties
        .add(foundation.DoubleProperty('bottom', bottom, defaultValue: null));
    properties
        .add(foundation.DoubleProperty('width', width, defaultValue: null));
    properties
        .add(foundation.DoubleProperty('height', height, defaultValue: null));
    properties.add(
        foundation.IntProperty('paintOrder', paintOrder, defaultValue: null));
  }
}
