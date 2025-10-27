---
title: "Class: PopoverOverlayWidgetState"
description: "Reference for PopoverOverlayWidgetState"
---

```dart
class PopoverOverlayWidgetState extends State<PopoverOverlayWidget> with SingleTickerProviderStateMixin, OverlayHandlerStateMixin {
  set offset(Offset? offset);
  void initState();
  Future<void> close([bool immediate = false]);
  void closeLater();
  void didUpdateWidget(covariant PopoverOverlayWidget oldWidget);
  Size? get anchorSize;
  AlignmentGeometry get anchorAlignment;
  Offset? get position;
  AlignmentGeometry get alignment;
  PopoverConstraint get widthConstraint;
  PopoverConstraint get heightConstraint;
  Offset? get offset;
  EdgeInsetsGeometry? get margin;
  bool get follow;
  BuildContext get anchorContext;
  bool get allowInvertHorizontal;
  bool get allowInvertVertical;
  LayerLink? get layerLink;
  set layerLink(LayerLink? value);
  set alignment(AlignmentGeometry value);
  set position(Offset? value);
  set anchorAlignment(AlignmentGeometry value);
  set widthConstraint(PopoverConstraint value);
  set heightConstraint(PopoverConstraint value);
  set margin(EdgeInsetsGeometry? value);
  set follow(bool value);
  set anchorContext(BuildContext value);
  set allowInvertHorizontal(bool value);
  set allowInvertVertical(bool value);
  void dispose();
  Widget build(BuildContext context);
  Future<void> closeWithResult<X>([X? value]);
}
```
