---
title: "Class: PopoverOverlayWidget"
description: "Internal widget for rendering popover overlays.   Manages positioning, constraints, and lifecycle of popover content  relative to an anchor widget."
---

```dart
/// Internal widget for rendering popover overlays.
///
/// Manages positioning, constraints, and lifecycle of popover content
/// relative to an anchor widget.
class PopoverOverlayWidget extends StatefulWidget {
  /// Creates a [PopoverOverlayWidget].
  const PopoverOverlayWidget({super.key, required this.anchor, this.position, required this.alignment, this.themes, required this.builder, required this.animation, required this.anchorAlignment, this.widthConstraint = PopoverConstraint.flexible, this.heightConstraint = PopoverConstraint.flexible, this.anchorSize, this.onTapOutside, this.regionGroupId, this.offset, this.transitionAlignment, this.margin, this.follow = true, this.consumeOutsideTaps = true, this.onTickFollow, this.allowInvertHorizontal = true, this.allowInvertVertical = true, this.data, this.onClose, this.onImmediateClose, this.onCloseWithResult, this.completer});
  /// Explicit position for the popover.
  final Offset? position;
  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry alignment;
  /// Alignment point on the anchor widget.
  final AlignmentGeometry anchorAlignment;
  /// Captured theme data from context.
  final CapturedThemes? themes;
  /// Captured inherited data from context.
  final CapturedData? data;
  /// Builder function for popover content.
  final WidgetBuilder builder;
  /// Size of the anchor widget.
  final Size? anchorSize;
  /// Animation controller for show/hide transitions.
  final Animation<double> animation;
  /// Width constraint mode for the popover.
  final PopoverConstraint widthConstraint;
  /// Height constraint mode for the popover.
  final PopoverConstraint heightConstraint;
  /// Callback when popover is closing.
  final FutureVoidCallback? onClose;
  /// Callback for immediate close without animation.
  final VoidCallback? onImmediateClose;
  /// Callback when user taps outside the popover.
  final VoidCallback? onTapOutside;
  /// Region group identifier for coordinating multiple overlays.
  final Object? regionGroupId;
  /// Additional offset applied to popover position.
  final Offset? offset;
  /// Alignment for transition animations.
  final AlignmentGeometry? transitionAlignment;
  /// Margin around the popover.
  final EdgeInsetsGeometry? margin;
  /// Whether popover follows anchor movement.
  final bool follow;
  /// The anchor this popover is positioned/tracked against.
  final Anchor anchor;
  /// Whether to consume taps outside the popover.
  final bool consumeOutsideTaps;
  /// Callback on each frame when following anchor.
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;
  /// Allow horizontal inversion when constrained.
  final bool allowInvertHorizontal;
  /// Allow vertical inversion when constrained.
  final bool allowInvertVertical;
  /// Callback when closing with a result value.
  final PopoverFutureVoidCallback<Object?>? onCloseWithResult;
  /// The completer that manages this popover's lifecycle, if shown via
  /// [PopoverConfiguration.show]. When non-null, it's inherited into the
  /// content subtree so [closeOverlay] can find it from within.
  final OverlayCompleter? completer;
  State<PopoverOverlayWidget> createState();
}
```
