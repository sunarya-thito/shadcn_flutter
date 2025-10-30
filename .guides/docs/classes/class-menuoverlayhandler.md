---
title: "Class: MenuOverlayHandler"
description: "Overlay handler specialized for menu popover display."
---

```dart
/// Overlay handler specialized for menu popover display.
///
/// Delegates to an [OverlayManager] to show menu popovers with
/// appropriate positioning, transitions, and dismissal behavior.
class MenuOverlayHandler extends OverlayHandler {
  /// The overlay manager handling menu display.
  final OverlayManager manager;
  /// Creates a menu overlay handler.
  ///
  /// Parameters:
  /// - [manager] (OverlayManager, required): Overlay manager for menu display
  const MenuOverlayHandler(this.manager);
  OverlayCompleter<T?> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
