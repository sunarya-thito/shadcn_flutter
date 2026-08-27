---
title: "Class: DrawerRawContainer"
description: "The visual chrome of a drawer: background decoration with a border and  rounded outer corners, an optional drag handle, optional surface blur, and  an optional [ModalBackdrop] barrier.   This widget is the reusable container extracted from the drawer/sheet  overlay implementation. It is used both by the imperative drawer overlays  ([DrawerWrapper]) and by the controller-driven [PinnedSheet].   The drag *gesture* is intentionally not owned here — callers wrap this  container in their own gesture detector. This container only lays out the  handle and content (including the overscroll growth) and paints the  decoration/barrier.   This is the fully-parameterized form. For a form that reads its  configuration from an ancestor [DrawerContainerData] and only takes a  [child], use [DrawerContainer]."
---

```dart
/// The visual chrome of a drawer: background decoration with a border and
/// rounded outer corners, an optional drag handle, optional surface blur, and
/// an optional [ModalBackdrop] barrier.
///
/// This widget is the reusable container extracted from the drawer/sheet
/// overlay implementation. It is used both by the imperative drawer overlays
/// ([DrawerWrapper]) and by the controller-driven [PinnedSheet].
///
/// The drag *gesture* is intentionally not owned here — callers wrap this
/// container in their own gesture detector. This container only lays out the
/// handle and content (including the overscroll growth) and paints the
/// decoration/barrier.
///
/// This is the fully-parameterized form. For a form that reads its
/// configuration from an ancestor [DrawerContainerData] and only takes a
/// [child], use [DrawerContainer].
class DrawerRawContainer extends StatelessWidget {
  /// The resolved position (never [OverlayPosition.start]/[OverlayPosition.end]).
  final OverlayPosition position;
  /// The sheet content.
  final Widget child;
  /// Whether the container expands to fill the cross axis.
  final bool expands;
  /// Whether to lay out the draggable content (handle gaps + overscroll growth).
  final bool draggable;
  /// Whether to show the drag handle bar.
  final bool showDragHandle;
  /// Explicit drag handle size, or null for the density-derived default.
  final Size? dragHandleSize;
  /// Corner radius override for the drawer.
  final BorderRadiusGeometry? borderRadius;
  /// Inner content padding.
  final EdgeInsets padding;
  /// Outer margin around the container (used by sheets for safe-area insets).
  final EdgeInsets margin;
  /// Surface opacity for the background.
  final double? surfaceOpacity;
  /// Surface blur amount for the background.
  final double? surfaceBlur;
  /// Barrier color for the [ModalBackdrop].
  final Color? barrierColor;
  /// Stack index (0 = top-most). Affects opacity/barrier weakening.
  final int stackIndex;
  /// Gap before the drag handle.
  final double? gapBeforeDragger;
  /// Gap after the drag handle.
  final double? gapAfterDragger;
  /// Size constraints for the container.
  final BoxConstraints? constraints;
  /// Alignment of the container within its constraints.
  final AlignmentGeometry? alignment;
  /// Fade animation driving the [ModalBackdrop]. When null, no barrier is drawn.
  final Animation<double>? fadeAnimation;
  /// Extra space (freed by the backdrop transform) consumed on the outer edge.
  final Size extraSize;
  /// Live overscroll (drag past fully-open) in logical pixels.
  final double overscroll;
  /// The measured content size, used for the overscroll growth divisor.
  final Size size;
  /// Optional wrapper applied around the inner handle+content layout, used by
  /// callers to attach a drag gesture that stays inside the decoration.
  final Widget Function(BuildContext context, Widget layout)? gestureWrapper;
  /// Cross-axis padding on the leading edge (left for top/bottom, top for
  /// left/right).
  final double startPadding;
  /// Cross-axis padding on the trailing edge (right for top/bottom, bottom for
  /// left/right).
  final double endPadding;
  /// Optional explicit cross-axis size. When set, the sheet does not stretch
  /// edge-to-edge; it is sized to this and positioned by [crossAxisAlignment].
  final AxisSize? crossAxisSize;
  /// Cross-axis alignment in `[-1, 1]` (-1 = start, 0 = center, 1 = end). Only
  /// meaningful when [crossAxisSize] bounds the sheet smaller than the axis.
  final double crossAxisAlignment;
  /// Creates a drawer container.
  const DrawerRawContainer({super.key, required this.position, required this.child, required this.size, required this.stackIndex, this.expands = false, this.draggable = true, this.showDragHandle = true, this.dragHandleSize, this.borderRadius, this.padding = EdgeInsets.zero, this.margin = EdgeInsets.zero, this.surfaceOpacity, this.surfaceBlur, this.barrierColor, this.gapBeforeDragger, this.gapAfterDragger, this.constraints, this.alignment, this.fadeAnimation, this.extraSize = Size.zero, this.overscroll = 0, this.gestureWrapper, this.startPadding = 0, this.endPadding = 0, this.crossAxisSize, this.crossAxisAlignment = 0});
  /// The border drawn around the drawer. Drawers border three sides.
  Border getBorder(ThemeData theme);
  /// The border radius applied to the two outer corners.
  BorderRadiusGeometry getBorderRadius(double radius);
  /// The decoration (background + border + radius) painted behind the content.
  BoxDecoration getDecoration(ThemeData theme);
  /// The drag handle bar widget.
  Widget buildDragHandle(ThemeData theme);
  Widget build(BuildContext context);
}
```
