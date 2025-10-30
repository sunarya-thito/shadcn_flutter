---
title: "Enum: SelectionPosition"
description: "Represents the visual position of a selected item within a group."
---

```dart
/// Represents the visual position of a selected item within a group.
///
/// Used to determine border radius styling for selected tree items
/// when multiple consecutive items are selected.
enum SelectionPosition {
  /// First item in a selection group.
  start,
  /// Middle item in a selection group.
  middle,
  /// Last item in a selection group.
  end,
  /// Single selected item (not part of a group).
  single,
}
```
