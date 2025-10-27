---
title: "Class: DrawerWrapper"
description: "Reference for DrawerWrapper"
---

```dart
class DrawerWrapper extends StatefulWidget {
  final OverlayPosition position;
  final Widget child;
  final bool expands;
  final bool draggable;
  final Size extraSize;
  final Size size;
  final bool showDragHandle;
  final BorderRadiusGeometry? borderRadius;
  final Size? dragHandleSize;
  final EdgeInsets padding;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final Color? barrierColor;
  final int stackIndex;
  final double? gapBeforeDragger;
  final double? gapAfterDragger;
  final AnimationController? animationController;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  const DrawerWrapper({super.key, required this.position, required this.child, this.expands = false, this.draggable = true, this.extraSize = Size.zero, required this.size, this.showDragHandle = true, this.borderRadius, this.dragHandleSize, this.padding = EdgeInsets.zero, this.surfaceOpacity, this.surfaceBlur, this.barrierColor, this.gapBeforeDragger, this.gapAfterDragger, required this.stackIndex, this.animationController, this.constraints, this.alignment});
  State<DrawerWrapper> createState();
}
```
