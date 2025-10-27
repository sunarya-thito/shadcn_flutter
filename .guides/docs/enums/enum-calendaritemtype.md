---
title: "Enum: CalendarItemType"
description: "Visual states for individual calendar date items."
---

```dart
/// Visual states for individual calendar date items.
///
/// Defines the different visual appearances and behaviors that calendar date cells
/// can have based on their selection state and position within ranges.
///
/// States include:
/// - [none]: Normal unselected date
/// - [today]: Current date highlighted
/// - [selected]: Single selected date or exact range boundary
/// - [inRange]: Date within a selected range but not start/end
/// - [startRange]/[endRange]: Range boundaries in other months
/// - [startRangeSelected]/[endRangeSelected]: Range boundaries in current month
/// - [startRangeSelectedShort]/[endRangeSelectedShort]: Boundaries in short ranges
/// - [inRangeSelectedShort]: Middle dates in short ranges (typically 2-day ranges)
enum CalendarItemType {
  none,
  today,
  selected,
  inRange,
  startRange,
  endRange,
  startRangeSelected,
  endRangeSelected,
  startRangeSelectedShort,
  endRangeSelectedShort,
  inRangeSelectedShort,
}
```
