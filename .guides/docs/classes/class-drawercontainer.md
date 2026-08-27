---
title: "Class: DrawerContainer"
description: "A drawer container that takes only a [child] and reads the rest of its  configuration from an ancestor [DrawerContainerData] (provided via a [Data]  widget, e.g. by a [PinnedSheet]). Delegates to [DrawerRawContainer].   The caller may additionally control cross-axis padding ([startPadding],  [endPadding]), the cross-axis [size], and [alignment] (-1 start, 0 center,  1 end; or the [DrawerContainer.alignStart]/[alignCenter]/[alignEnd]  constructors)."
---

```dart
/// A drawer container that takes only a [child] and reads the rest of its
/// configuration from an ancestor [DrawerContainerData] (provided via a [Data]
/// widget, e.g. by a [PinnedSheet]). Delegates to [DrawerRawContainer].
///
/// The caller may additionally control cross-axis padding ([startPadding],
/// [endPadding]), the cross-axis [size], and [alignment] (-1 start, 0 center,
/// 1 end; or the [DrawerContainer.alignStart]/[alignCenter]/[alignEnd]
/// constructors).
class DrawerContainer extends StatelessWidget {
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
  /// Creates a data-driven drawer container.
  const DrawerContainer({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size, this.alignment = 0});
  /// A drawer container aligned to the cross-axis start.
  const DrawerContainer.alignStart({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size});
  /// A drawer container centered on the cross axis.
  const DrawerContainer.alignCenter({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size});
  /// A drawer container aligned to the cross-axis end.
  const DrawerContainer.alignEnd({super.key, required this.child, this.startPadding = 0, this.endPadding = 0, this.size});
  Widget build(BuildContext context);
}
```
