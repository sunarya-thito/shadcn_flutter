---
title: "Class: CalendarView"
description: "Represents a specific month and year view in calendar navigation."
---

```dart
/// Represents a specific month and year view in calendar navigation.
///
/// Provides immutable representation of a calendar's current viewing position
/// with navigation methods to move between months and years. Used to control
/// which month/year combination is displayed in calendar grids.
///
/// Key Features:
/// - **Navigation Methods**: [next], [previous], [nextYear], [previousYear]
/// - **Factory Constructors**: [now()], [fromDateTime()]
/// - **Validation**: Ensures month values stay within 1-12 range
/// - **Immutable**: All navigation returns new CalendarView instances
///
/// Example:
/// ```dart
/// // Create views for different dates
/// final current = CalendarView.now();
/// final specific = CalendarView(2024, 3); // March 2024
/// final fromDate = CalendarView.fromDateTime(someDateTime);
///
/// // Navigate between months
/// final nextMonth = current.next;
/// final prevMonth = current.previous;
/// final nextYear = current.nextYear;
/// ```
class CalendarView {
  final int year;
  final int month;
  /// Creates a [CalendarView] for the specified year and month.
  ///
  /// Parameters:
  /// - [year] (int): Four-digit year value
  /// - [month] (int): Month number (1-12, where 1 = January)
  ///
  /// Throws [AssertionError] if month is not between 1 and 12.
  ///
  /// Example:
  /// ```dart
  /// final view = CalendarView(2024, 3); // March 2024
  /// ```
  CalendarView(this.year, this.month);
  /// Creates a [CalendarView] for the current month and year.
  ///
  /// Uses [DateTime.now()] to determine the current date and extracts
  /// the year and month components.
  ///
  /// Example:
  /// ```dart
  /// final currentView = CalendarView.now();
  /// ```
  factory CalendarView.now();
  /// Creates a [CalendarView] from an existing [DateTime].
  ///
  /// Extracts the year and month components from the provided [DateTime]
  /// and creates a corresponding calendar view.
  ///
  /// Parameters:
  /// - [dateTime] (DateTime): Date to extract year and month from
  ///
  /// Example:
  /// ```dart
  /// final birthday = DateTime(1995, 7, 15);
  /// final view = CalendarView.fromDateTime(birthday); // July 1995
  /// ```
  factory CalendarView.fromDateTime(DateTime dateTime);
  CalendarView get next;
  CalendarView get previous;
  CalendarView get nextYear;
  CalendarView get previousYear;
  String toString();
  bool operator ==(Object other);
  int get hashCode;
  CalendarView copyWith({ValueGetter<int>? year, ValueGetter<int>? month});
}
```
