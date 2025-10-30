---
title: "Class: Calendar"
description: "A highly customizable calendar widget supporting multiple selection modes."
---

```dart
/// A highly customizable calendar widget supporting multiple selection modes.
///
/// Displays a grid-based calendar interface allowing users to view and select dates
/// with comprehensive support for single selection, range selection, and multiple
/// date selection. Includes built-in date validation, state management, and theme integration.
///
/// Key Features:
/// - **Selection Modes**: Single date, date range, multiple dates, or display-only
/// - **Date Validation**: Custom date state builder for enabling/disabling dates
/// - **Interactive Grid**: Touch/click support with visual feedback
/// - **Theme Integration**: Follows shadcn_flutter design system
/// - **Accessibility**: Screen reader and keyboard navigation support
/// - **Customizable Appearance**: Themed colors, spacing, and visual states
///
/// The calendar automatically handles date logic, leap years, month boundaries,
/// and provides consistent visual feedback for different selection states.
///
/// Selection Behavior:
/// - **Single**: Click to select one date, click again to deselect
/// - **Range**: Click start date, then end date to form range
/// - **Multi**: Click multiple dates to build selection set
/// - **None**: Display-only mode with no interaction
///
/// Example:
/// ```dart
/// Calendar(
///   view: CalendarView.now(),
///   selectionMode: CalendarSelectionMode.range,
///   value: CalendarValue.range(startDate, endDate),
///   onChanged: (value) => setState(() => selectedDates = value),
///   stateBuilder: (date) => date.isBefore(DateTime.now())
///     ? DateState.disabled
///     : DateState.enabled,
/// )
/// ```
class Calendar extends StatefulWidget {
  /// The current date for highlighting purposes (defaults to DateTime.now()).
  final DateTime? now;
  /// The currently selected date value(s).
  final CalendarValue? value;
  /// The month and year view to display in the calendar.
  final CalendarView view;
  /// The selection mode determining how dates can be selected.
  final CalendarSelectionMode selectionMode;
  /// Callback invoked when the selected date(s) change.
  final ValueChanged<CalendarValue?>? onChanged;
  /// Legacy function to determine if a date should be enabled.
  final bool Function(DateTime date)? isDateEnabled;
  /// Builder function to determine the state of each date.
  final DateStateBuilder? stateBuilder;
  /// Creates a [Calendar] widget with flexible date selection capabilities.
  ///
  /// Configures the calendar's view, selection behavior, and interaction handling
  /// with comprehensive options for customization and validation.
  ///
  /// Parameters:
  /// - [view] (CalendarView, required): Month/year to display in calendar grid
  /// - [selectionMode] (CalendarSelectionMode, required): How dates can be selected
  /// - [now] (DateTime?, optional): Current date for highlighting, defaults to DateTime.now()
  /// - [value] (CalendarValue?, optional): Currently selected date(s)
  /// - [onChanged] (`ValueChanged<CalendarValue>?`, optional): Called when selection changes
  /// - [isDateEnabled] (bool Function(DateTime)?, optional): Legacy date validation function
  /// - [stateBuilder] (DateStateBuilder?, optional): Custom date state validation
  ///
  /// The [view] parameter determines which month and year are shown in the calendar grid.
  /// Use [CalendarView.now()] for current month or [CalendarView(year, month)] for specific dates.
  ///
  /// The [stateBuilder] takes precedence over [isDateEnabled] when both are provided.
  ///
  /// Example:
  /// ```dart
  /// Calendar(
  ///   view: CalendarView(2024, 3), // March 2024
  ///   selectionMode: CalendarSelectionMode.single,
  ///   onChanged: (value) => print('Selected: ${value?.toString()}'),
  ///   stateBuilder: (date) => date.weekday == DateTime.sunday
  ///     ? DateState.disabled
  ///     : DateState.enabled,
  /// )
  /// ```
  const Calendar({super.key, this.now, this.value, required this.view, required this.selectionMode, this.onChanged, this.isDateEnabled, this.stateBuilder});
  State<Calendar> createState();
}
```
