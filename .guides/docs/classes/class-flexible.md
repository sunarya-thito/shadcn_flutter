---
title: "Class: Flexible"
description: "A widget that controls how a child of a [Row], [Column], or [Flex] flexes."
---

```dart
/// A widget that controls how a child of a [Row], [Column], or [Flex] flexes.
///
/// Using a [Flexible] widget gives a child of a [Row], [Column], or [Flex]
/// the flexibility to expand to fill the available space in the main axis
/// (e.g., horizontally for a [Row] or vertically for a [Column]), but, unlike
/// [Expanded], [Flexible] does not require the child to fill the available
/// space.
///
/// A [Flexible] widget must be a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Flexible] widget to its enclosing [Row], [Column], or
/// [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not other
/// kinds of widgets, like [RenderObjectWidget]s).
///
/// This patched version also supports [paintOrder] to control the painting
/// order of children.
///
/// See also:
///
///  * [Expanded], which forces the child to expand to fill the available space.
///  * [PaintOrder], to control paint order without affecting flex behavior.
class Flexible extends widgets.ParentDataWidget<FlexParentData> {
  /// Creates a widget that controls how a child of a [Row], [Column], or [Flex] flexes.
  const Flexible({super.key, this.flex = 1, this.fit = rendering.FlexFit.loose, this.paintOrder, required super.child});
  /// The flex factor to use for this child.
  final int flex;
  /// How a flexible child is inscribed into the available space.
  final rendering.FlexFit fit;
  /// The paint order of this child. Higher values are painted on top.
  final int? paintOrder;
  void applyParentData(rendering.RenderObject renderObject);
  Type get debugTypicalAncestorWidgetClass;
  void debugFillProperties(foundation.DiagnosticPropertiesBuilder properties);
}
```
