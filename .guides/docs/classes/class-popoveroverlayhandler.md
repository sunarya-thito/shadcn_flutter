---
title: "Class: PopoverOverlayHandler"
description: "Handles overlay presentation for popover components."
---

```dart
/// Handles overlay presentation for popover components.
///
/// Manages the display, positioning, and lifecycle of popover overlays
/// with support for alignment, constraints, and modal behavior.
class PopoverOverlayHandler extends OverlayHandler {
  /// Creates a [PopoverOverlayHandler].
  const PopoverOverlayHandler();
  OverlayCompleter<T> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, ui.Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, ui.Clip clipBehavior = Clip.none, Object? regionGroupId, ui.Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
