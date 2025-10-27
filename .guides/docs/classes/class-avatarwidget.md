---
title: "Class: AvatarWidget"
description: "Abstract base class for avatar-related widgets."
---

```dart
/// Abstract base class for avatar-related widgets.
///
/// [AvatarWidget] provides a common interface for avatar components, ensuring
/// they expose size and border radius properties that can be used by container
/// components like [AvatarGroup] for proper layout and clipping.
abstract class AvatarWidget extends Widget {
  /// Creates an [AvatarWidget] with optional key.
  const AvatarWidget({super.key});
  /// Size of the avatar widget in logical pixels.
  ///
  /// Used by container widgets for layout calculations and clipping operations.
  double? get size;
  /// Border radius of the avatar widget in logical pixels.
  ///
  /// Used by container widgets for proper clipping and visual effects.
  double? get borderRadius;
}
```
