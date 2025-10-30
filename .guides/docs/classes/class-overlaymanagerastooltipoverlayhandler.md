---
title: "Class: OverlayManagerAsTooltipOverlayHandler"
description: "Overlay handler that delegates tooltip display to an [OverlayManager]."
---

```dart
/// Overlay handler that delegates tooltip display to an [OverlayManager].
///
/// This handler integrates tooltips with the overlay management system,
/// allowing tooltips to be displayed through the overlay manager's
/// tooltip-specific display logic. This ensures proper layering and
/// lifecycle management within the overlay system.
class OverlayManagerAsTooltipOverlayHandler extends OverlayHandler {
  /// The overlay manager instance to use for displaying tooltips.
  final OverlayManager overlayManager;
  /// Creates an [OverlayManagerAsTooltipOverlayHandler].
  ///
  /// Parameters:
  /// - [overlayManager] (`OverlayManager`, required): The overlay manager instance.
  const OverlayManagerAsTooltipOverlayHandler({required this.overlayManager});
  OverlayCompleter<T?> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool barrierDismissable = true, bool modal = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
