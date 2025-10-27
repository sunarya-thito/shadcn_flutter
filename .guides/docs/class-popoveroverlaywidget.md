---
title: "Class: PopoverOverlayWidget"
description: "Reference for PopoverOverlayWidget"
---

```dart
class PopoverOverlayWidget extends StatefulWidget {
  const PopoverOverlayWidget({super.key, required this.anchorContext, this.position, required this.alignment, this.themes, required this.builder, required this.animation, required this.anchorAlignment, this.widthConstraint = PopoverConstraint.flexible, this.heightConstraint = PopoverConstraint.flexible, this.anchorSize, this.onTapOutside, this.regionGroupId, this.offset, this.transitionAlignment, this.margin, this.follow = true, this.consumeOutsideTaps = true, this.onTickFollow, this.allowInvertHorizontal = true, this.allowInvertVertical = true, this.data, this.onClose, this.onImmediateClose, this.onCloseWithResult, this.layerLink});
  final Offset? position;
  final AlignmentGeometry alignment;
  final AlignmentGeometry anchorAlignment;
  final CapturedThemes? themes;
  final CapturedData? data;
  final WidgetBuilder builder;
  final Size? anchorSize;
  final Animation<double> animation;
  final PopoverConstraint widthConstraint;
  final PopoverConstraint heightConstraint;
  final FutureVoidCallback? onClose;
  final VoidCallback? onImmediateClose;
  final VoidCallback? onTapOutside;
  final Object? regionGroupId;
  final Offset? offset;
  final AlignmentGeometry? transitionAlignment;
  final EdgeInsetsGeometry? margin;
  final bool follow;
  final BuildContext anchorContext;
  final bool consumeOutsideTaps;
  final ValueChanged<PopoverOverlayWidgetState>? onTickFollow;
  final bool allowInvertHorizontal;
  final bool allowInvertVertical;
  final PopoverFutureVoidCallback<Object?>? onCloseWithResult;
  final LayerLink? layerLink;
  State<PopoverOverlayWidget> createState();
}
```
