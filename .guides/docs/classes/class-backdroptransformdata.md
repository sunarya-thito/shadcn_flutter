---
title: "Class: BackdropTransformData"
description: "Data class containing backdrop transformation information."
---

```dart
/// Data class containing backdrop transformation information.
///
/// Holds the size difference needed to scale and position backdrop
/// content when overlays are displayed.
class BackdropTransformData {
  /// The difference in size between original and transformed backdrop.
  final Size sizeDifference;
  /// Creates backdrop transform data.
  ///
  /// Parameters:
  /// - [sizeDifference] (Size, required): Size difference for transform
  BackdropTransformData(this.sizeDifference);
}
```
