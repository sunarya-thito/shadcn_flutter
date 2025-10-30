---
title: "Enum: CalendarValueLookup"
description: "Result type for calendar value lookup operations."
---

```dart
/// Result type for calendar value lookup operations.
///
/// Indicates the relationship between a queried date and the current calendar selection.
enum CalendarValueLookup {
  /// Date is not part of any selection.
  none,
  /// Date is directly selected (single mode or exact match).
  selected,
  /// Date is the start of a selected range.
  start,
  /// Date is the end of a selected range.
  end,
  /// Date falls within a selected range but is not start/end.
  inRange,
}
```
