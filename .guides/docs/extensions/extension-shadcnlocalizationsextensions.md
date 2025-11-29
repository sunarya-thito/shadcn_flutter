---
title: "Extension: ShadcnLocalizationsExtensions"
description: "Extension methods for [ShadcnLocalizations] to provide additional formatting and utility functions."
---

```dart
/// Extension methods for [ShadcnLocalizations] to provide additional formatting and utility functions.
extension ShadcnLocalizationsExtensions on ShadcnLocalizations {
  /// The order of date parts for the current locale.
  ///
  /// Default is [DatePart.month], [DatePart.day], [DatePart.year].
  List<DatePart> get datePartsOrder;
  /// The abbreviation for the year component (e.g., 'YYYY').
  String get dateYearAbbreviation;
  /// The abbreviation for the month component (e.g., 'MM').
  String get dateMonthAbbreviation;
  /// The abbreviation for the day component (e.g., 'DD').
  String get dateDayAbbreviation;
  /// Gets the abbreviation for a specific [DatePart].
  String getDatePartAbbreviation(DatePart part);
  /// Formats a [DateTime] object into a string.
  ///
  /// [showDate] - Whether to include the date part.
  /// [showTime] - Whether to include the time part.
  /// [showSeconds] - Whether to include seconds in the time part.
  /// [use24HourFormat] - Whether to use 24-hour format for time.
  String formatDateTime(DateTime dateTime, {bool showDate = true, bool showTime = true, bool showSeconds = false, bool use24HourFormat = true});
  /// Formats a [TimeOfDay] object into a string.
  ///
  /// [use24HourFormat] - Whether to use 24-hour format.
  /// [showSeconds] - Whether to include seconds.
  String formatTimeOfDay(TimeOfDay time, {bool use24HourFormat = true, bool showSeconds = false});
  /// Formats a number as a string, removing decimal point if it's an integer.
  String formatNumber(double value);
  /// Gets the localized label for a [ColorPickerMode].
  String getColorPickerMode(ColorPickerMode mode);
  /// Gets the abbreviated weekday name for a given weekday index (1-7).
  String getAbbreviatedWeekday(int weekday);
  /// Gets the full month name for a given month index (1-12).
  String getMonth(int month);
  /// Gets the abbreviated month name for a given month index (1-12).
  String getAbbreviatedMonth(int month);
  /// Formats a [Duration] into a string.
  ///
  /// [showDays] - Whether to show days.
  /// [showHours] - Whether to show hours.
  /// [showMinutes] - Whether to show minutes.
  /// [showSeconds] - Whether to show seconds.
  String formatDuration(Duration duration, {bool showDays = true, bool showHours = true, bool showMinutes = true, bool showSeconds = true});
  /// Gets the abbreviation for a [DurationPart].
  String getDurationPartAbbreviation(DurationPart part);
  /// Gets the abbreviation for a [TimePart].
  String getTimePartAbbreviation(TimePart part);
}
```
