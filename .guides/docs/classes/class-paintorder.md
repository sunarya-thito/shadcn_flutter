---
title: "Class: PaintOrder"
description: "A widget that sets the paint order of a non-flexible child in a [Row], [Column], or [Flex]."
---

```dart
/// A widget that sets the paint order of a non-flexible child in a [Row], [Column], or [Flex].
class PaintOrder extends widgets.ParentDataWidget<FlexParentData> {
  /// Creates a widget that sets the paint order of a child.
  const PaintOrder({super.key, required this.paintOrder, required super.child});
  /// The paint order of this child. Higher values are painted on top.
  final int paintOrder;
  void applyParentData(rendering.RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
  void debugFillProperties(foundation.DiagnosticPropertiesBuilder properties);
}
```
