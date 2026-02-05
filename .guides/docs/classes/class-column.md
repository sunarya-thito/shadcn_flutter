---
title: "Class: Column"
description: "A widget that displays its children in a vertical array."
---

```dart
/// A widget that displays its children in a vertical array.
///
/// To cause a child to expand to fill the available vertical space, wrap the
/// child in an [Expanded] widget.
///
/// The [Column] widget does not scroll (and in general it is considered an
/// error to have more children in a [Column] than will fit in the available
/// room). If you have a line of widgets and want them to be able to scroll if
/// there is insufficient room, consider using a [ListView].
///
/// For a horizontal variant, see [Row].
///
/// This patched version supports custom paint ordering via [PaintOrder] or
/// [Flexible.paintOrder].
///
/// See also:
///
///  * [Row], for a horizontal equivalent.
///  * [Expanded], to indicate children that should take all remaining room.
///  * [Flexible], to indicate children that should share remaining room.
///  * [PaintOrder], to control the paint order of children.
class Column extends Flex {
  /// Creates a vertical array of children with paint order support.
  const Column({super.key, super.mainAxisAlignment, super.mainAxisSize, super.crossAxisAlignment, super.textDirection, super.verticalDirection, super.textBaseline, super.spacing, super.children});
}
```
