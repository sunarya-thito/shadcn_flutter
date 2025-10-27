---
title: "Class: RawTableLayout"
description: "Reference for RawTableLayout"
---

```dart
class RawTableLayout extends MultiChildRenderObjectWidget {
  const RawTableLayout({super.key, super.children, required this.width, required this.height, required this.clipBehavior, this.frozenColumn, this.frozenRow, this.verticalOffset, this.horizontalOffset, this.viewportSize});
  final TableSizeSupplier width;
  final TableSizeSupplier height;
  final Clip clipBehavior;
  final CellPredicate? frozenColumn;
  final CellPredicate? frozenRow;
  final double? verticalOffset;
  final double? horizontalOffset;
  final Size? viewportSize;
  RenderTableLayout createRenderObject(BuildContext context);
  void updateRenderObject(BuildContext context, RenderTableLayout renderObject);
}
```
