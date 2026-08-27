---
title: "Class: OverlayAnchorEntry"
description: "The registry entry representing a registered [OverlayAnchor]."
---

```dart
/// The registry entry representing a registered [OverlayAnchor].
class OverlayAnchorEntry {
  /// The [RenderBox] of the registered anchor.
  final RenderBox renderBox;
  /// The [BuildContext] (Element) of the registered anchor.
  final BuildContext context;
  /// Creates an [OverlayAnchorEntry].
  const OverlayAnchorEntry({required this.renderBox, required this.context});
}
```
