---
title: "Enum: CalendarValueLookup"
description: "Result type for calendar value lookup operations."
---

```dart
/// Result type for calendar value lookup operations.
///
/// Indicates the relationship between a queried date and the current calendar selection:
/// - [none]: Date is not part of any selection
/// - [selected]: Date is directly selected (single mode or exact match)
/// - [start]: Date is the start of a selected range
/// - [end]: Date is the end of a selected range
/// - [inRange]: Date falls within a selected range but is not start/end
enum CalendarValueLookup {
  none,
  selected,
  start,
  end,
  inRange,
}
```
