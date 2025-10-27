---
title: "Class: SheetOverlayHandler"
description: "Reference for SheetOverlayHandler"
---

```dart
class SheetOverlayHandler extends OverlayHandler {
  static bool isSheetOverlay(BuildContext context);
  final OverlayPosition position;
  final Color? barrierColor;
  const SheetOverlayHandler({this.position = OverlayPosition.bottom, this.barrierColor});
  bool operator ==(Object other);
  int get hashCode;
  OverlayCompleter<T?> show<T>({required BuildContext context, required AlignmentGeometry alignment, required WidgetBuilder builder, Offset? position, AlignmentGeometry? anchorAlignment, PopoverConstraint widthConstraint = PopoverConstraint.flexible, PopoverConstraint heightConstraint = PopoverConstraint.flexible, Key? key, bool rootOverlay = true, bool modal = true, bool barrierDismissable = true, Clip clipBehavior = Clip.none, Object? regionGroupId, Offset? offset, AlignmentGeometry? transitionAlignment, EdgeInsetsGeometry? margin, bool follow = true, bool consumeOutsideTaps = true, ValueChanged<PopoverOverlayWidgetState>? onTickFollow, bool allowInvertHorizontal = true, bool allowInvertVertical = true, bool dismissBackdropFocus = true, Duration? showDuration, Duration? dismissDuration, OverlayBarrier? overlayBarrier, LayerLink? layerLink});
}
```
