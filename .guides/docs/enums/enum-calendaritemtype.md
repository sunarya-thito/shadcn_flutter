---
title: "Enum: CalendarItemType"
description: "Visual states for individual calendar date items."
---

```dart
/// Visual states for individual calendar date items.
///
/// Defines the different visual appearances and behaviors that calendar date cells
/// can have based on their selection state and position within ranges.
enum CalendarItemType {
  /// Normal unselected date.
  none,
  /// Current date highlighted.
  today,
  /// Single selected date or exact range boundary.
  selected,
  /// Date within a selected range but not start/end.
  inRange,
  /// Range start boundary in other months (same as startRangeSelected).
  startRange,
  /// Range end boundary in other months (same as endRangeSelected).
  endRange,
  /// Range start boundary in current month.
  startRangeSelected,
  /// Range end boundary in current month.
  endRangeSelected,
  /// Range start boundary in short ranges.
  startRangeSelectedShort,
  /// Range end boundary in short ranges (typically 2-day ranges).
  endRangeSelectedShort,
  /// Middle dates in short ranges (typically 2-day ranges).
  inRangeSelectedShort,
}
```
