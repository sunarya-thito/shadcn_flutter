---
title: "Enum: PopoverConstraint"
description: "Size constraint strategies for popover overlays."
---

```dart
/// Size constraint strategies for popover overlays.
///
/// - `flexible`: Size flexibly based on content and available space
/// - `intrinsic`: Use intrinsic content size
/// - `anchorFixedSize`: Match anchor's exact size
/// - `anchorMinSize`: Use anchor size as minimum
/// - `anchorMaxSize`: Use anchor size as maximum
enum PopoverConstraint {
  /// Size flexibly based on content and available space
  flexible,
  /// Use intrinsic content size
  intrinsic,
  /// Match anchor's exact size
  anchorFixedSize,
  /// Use anchor size as minimum
  anchorMinSize,
  /// Use anchor size as maximum
  anchorMaxSize,
}
```
