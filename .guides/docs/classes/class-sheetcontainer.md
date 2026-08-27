---
title: "Class: SheetContainer"
description: "A sheet container that takes only a [child] and reads the rest of its  configuration from an ancestor [DrawerContainerData] (provided via a [Data]  widget, e.g. by a [PinnedSheet]). Delegates to [SheetRawContainer]."
---

```dart
/// A sheet container that takes only a [child] and reads the rest of its
/// configuration from an ancestor [DrawerContainerData] (provided via a [Data]
/// widget, e.g. by a [PinnedSheet]). Delegates to [SheetRawContainer].
class SheetContainer extends StatelessWidget {
  /// The sheet content.
  final Widget child;
  /// Cross-axis padding on the leading edge.
  final double startPadding;
  /// Cross-axis padding on the trailing edge.
  final double endPadding;
  /// Optional cross-axis size (so the sheet doesn't stretch edge-to-edge).
  final AxisSize? size;
  /// Cross-axis alignment in `[-1, 1]`.
  final double alignment;
  /// Creates a data-driven sheet container.
  const SheetContainer({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size, this.alignment = 0});
  /// A sheet container aligned to the cross-axis start.
  const SheetContainer.alignStart({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size});
  /// A sheet container centered on the cross axis.
  const SheetContainer.alignCenter({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size});
  /// A sheet container aligned to the cross-axis end.
  const SheetContainer.alignEnd({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size});
  Widget build(BuildContext context);
}
```
