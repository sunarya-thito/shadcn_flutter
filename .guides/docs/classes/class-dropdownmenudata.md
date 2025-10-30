---
title: "Class: DropdownMenuData"
description: "Internal data class for dropdown menu context."
---

```dart
/// Internal data class for dropdown menu context.
///
/// Holds shared data for dropdown menu implementation, including a unique
/// key for region grouping and overlay coordination.
///
/// This is typically used internally by the dropdown menu system and not
/// intended for direct use in application code.
class DropdownMenuData {
  /// Unique key identifying this dropdown menu instance.
  ///
  /// Used for coordinating overlays and region-based interactions.
  final GlobalKey key;
  /// Creates dropdown menu data with the specified key.
  DropdownMenuData(this.key);
}
```
