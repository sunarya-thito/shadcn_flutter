---
title: "Class: Expanded"
description: "A widget that expands a child of a [Row], [Column], or [Flex]  so that the child fills the available space.   Using an [Expanded] widget makes a child of a [Row], [Column], or [Flex]  expand to fill the available space along the main axis (e.g., horizontally  for a [Row] or vertically for a [Column]). If multiple children are  expanded, the available space is divided among them according to the [flex]  factor.   An [Expanded] widget must be a descendant of a [Row], [Column], or [Flex],  and the path from the [Expanded] widget to its enclosing [Row], [Column],  or [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not  other kinds of widgets, like [RenderObjectWidget]s).   This patched version also supports [paintOrder] to control the painting  order of children.   See also:    * [Flexible], which does not force the child to fill the available space.   * [PaintOrder], to control paint order without affecting flex behavior."
---

```dart
/// A widget that expands a child of a [Row], [Column], or [Flex]
/// so that the child fills the available space.
///
/// Using an [Expanded] widget makes a child of a [Row], [Column], or [Flex]
/// expand to fill the available space along the main axis (e.g., horizontally
/// for a [Row] or vertically for a [Column]). If multiple children are
/// expanded, the available space is divided among them according to the [flex]
/// factor.
///
/// An [Expanded] widget must be a descendant of a [Row], [Column], or [Flex],
/// and the path from the [Expanded] widget to its enclosing [Row], [Column],
/// or [Flex] must contain only [StatelessWidget]s or [StatefulWidget]s (not
/// other kinds of widgets, like [RenderObjectWidget]s).
///
/// This patched version also supports [paintOrder] to control the painting
/// order of children.
///
/// See also:
///
///  * [Flexible], which does not force the child to fill the available space.
///  * [PaintOrder], to control paint order without affecting flex behavior.
class Expanded extends Flexible {
  /// Creates a widget that expands a child of a [Row], [Column], or [Flex].
  const Expanded({super.key, super.flex, super.paintOrder, required super.child});
}
```
