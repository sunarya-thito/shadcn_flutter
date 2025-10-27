---
title: "Class: CalendarItem"
description: "Individual calendar date cell with interactive behavior and visual states."
---

```dart
/// Individual calendar date cell with interactive behavior and visual states.
///
/// Represents a single date item within a calendar grid, handling touch interactions,
/// visual state management, and theme integration. Supports different visual states
/// for selection, ranges, and special dates like today.
///
/// Key Features:
/// - **Visual States**: Multiple appearance modes based on selection status
/// - **Interactive**: Touch/click handling with callbacks
/// - **Responsive Sizing**: Configurable width/height with theme scaling
/// - **Accessibility**: Screen reader support and focus management
/// - **State Management**: Enabled/disabled states with visual feedback
/// - **Range Support**: Special styling for range start/end/middle positions
///
/// The item automatically applies appropriate button styling based on its [type]
/// and handles edge cases for range visualization at row boundaries.
///
/// Example:
/// ```dart
/// CalendarItem(
///   type: CalendarItemType.selected,
///   indexAtRow: 2,
///   rowCount: 7,
///   state: DateState.enabled,
///   onTap: () => handleDateTap(date),
///   child: Text('15'),
/// )
/// ```
class CalendarItem extends StatelessWidget {
  final Widget child;
  final CalendarItemType type;
  final VoidCallback? onTap;
  final int indexAtRow;
  final int rowCount;
  final double? width;
  final double? height;
  final DateState state;
  const CalendarItem({super.key, required this.child, required this.type, required this.indexAtRow, required this.rowCount, this.onTap, this.width, this.height, required this.state});
  Widget build(BuildContext context);
}
```
