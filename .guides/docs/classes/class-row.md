---
title: "Class: Row"
description: "A widget that displays its children in a horizontal array.   To cause a child to expand to fill the available horizontal space, wrap the  child in an [Expanded] widget.   The [Row] widget does not scroll (and in general it is considered an error  to have more children in a [Row] than will fit in the available room). If  you have a line of widgets and want them to be able to scroll if there is  insufficient room, consider using a [ListView].   For a vertical variant, see [Column].   This patched version supports custom paint ordering via [PaintOrder] or  [Flexible.paintOrder].   See also:    * [Column], for a vertical equivalent.   * [Expanded], to indicate children that should take all remaining room.   * [Flexible], to indicate children that should share remaining room.   * [PaintOrder], to control the paint order of children."
---

```dart
/// A widget that displays its children in a horizontal array.
///
/// To cause a child to expand to fill the available horizontal space, wrap the
/// child in an [Expanded] widget.
///
/// The [Row] widget does not scroll (and in general it is considered an error
/// to have more children in a [Row] than will fit in the available room). If
/// you have a line of widgets and want them to be able to scroll if there is
/// insufficient room, consider using a [ListView].
///
/// For a vertical variant, see [Column].
///
/// This patched version supports custom paint ordering via [PaintOrder] or
/// [Flexible.paintOrder].
///
/// See also:
///
///  * [Column], for a vertical equivalent.
///  * [Expanded], to indicate children that should take all remaining room.
///  * [Flexible], to indicate children that should share remaining room.
///  * [PaintOrder], to control the paint order of children.
class Row extends Flex {
  /// Creates a horizontal array of children with paint order support.
  const Row({super.key, super.mainAxisAlignment, super.mainAxisSize, super.crossAxisAlignment, super.textDirection, super.verticalDirection, super.textBaseline, super.spacing, super.children, super.clipBehavior});
}
```
