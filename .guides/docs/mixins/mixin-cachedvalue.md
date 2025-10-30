---
title: "Mixin: CachedValue"
description: "Mixin for values that need custom rebuild logic."
---

```dart
/// Mixin for values that need custom rebuild logic.
///
/// Implement this mixin to control when a [CachedValueWidget] should rebuild
/// based on custom comparison logic.
mixin CachedValue {
  /// Determines if the widget should rebuild when value changes.
  ///
  /// Parameters:
  /// - [oldValue] (`CachedValue`, required): Previous value to compare against.
  ///
  /// Returns: `bool` — `true` if rebuild is needed.
  bool shouldRebuild(covariant CachedValue oldValue);
}
```
