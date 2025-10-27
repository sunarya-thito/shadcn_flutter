---
title: "Class: PopoverLayout"
description: "Reference for PopoverLayout"
---

```dart
class PopoverLayout extends SingleChildRenderObjectWidget {
  final Alignment alignment;
  final Alignment anchorAlignment;
  final Offset? position;
  final Size? anchorSize;
  final PopoverConstraint widthConstraint;
  final PopoverConstraint heightConstraint;
  final Offset? offset;
  final EdgeInsets margin;
  final double scale;
  final Alignment scaleAlignment;
  final FilterQuality? filterQuality;
  final bool allowInvertHorizontal;
  final bool allowInvertVertical;
  const PopoverLayout({super.key, required this.alignment, required this.position, required this.anchorAlignment, required this.widthConstraint, required this.heightConstraint, this.anchorSize, this.offset, required this.margin, required Widget super.child, required this.scale, required this.scaleAlignment, this.filterQuality, this.allowInvertHorizontal = true, this.allowInvertVertical = true});
  RenderObject createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, covariant PopoverLayoutRender renderObject);
}
```
