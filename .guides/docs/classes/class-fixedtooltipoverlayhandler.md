---
title: "Class: FixedTooltipOverlayHandler"
description: "A fixed overlay handler for tooltips using direct overlay entries."
---

```dart
/// A fixed overlay handler for tooltips using direct overlay entries.
///
/// This handler creates tooltips using Flutter's built-in overlay system
/// without delegating to an overlay manager. Tooltips are positioned
/// directly in the overlay and use fixed positioning relative to their
/// anchor widget.
///
/// Use this handler when you need direct control over tooltip overlay
/// entries or when not using an overlay manager.
class FixedTooltipOverlayHandler extends OverlayHandler {
  /// Creates a [FixedTooltipOverlayHandler].
  const FixedTooltipOverlayHandler();
  OverlayCompleter<T> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
