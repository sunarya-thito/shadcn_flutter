import 'dart:math';

import '../../util.dart';

/// Configuration for file size unit formatting.
///
/// Defines the base (1024 for binary) and unit labels for formatting
/// file sizes and data volumes.
class SizeUnitLocale {
  /// Base for unit conversion (typically 1024 for binary units).
  final int base;

  /// List of unit labels (e.g., ['B', 'KB', 'MB', 'GB']).
  final List<String> units;

  /// Separator for digit grouping (e.g., ',' for 1,000,000).
  final String separator;

  /// Creates a [SizeUnitLocale].
  ///
  /// Parameters:
  /// - [base] (`int`, required): Base for unit conversion.
  /// - [units] (`List<String>`, required): Unit labels.
  /// - [separator] (`String`, default: ','): Digit separator.
  const SizeUnitLocale(this.base, this.units, {this.separator = ','});

  /// Standard file size units in bytes (B, KB, MB, GB, etc.).
  static const SizeUnitLocale fileBytes = _fileByteUnits;

  /// Binary file size units (Bi, KiB, MiB, GiB, etc.).
  static const SizeUnitLocale fileBits = _fileBitUnits;

  /// Gets the appropriate unit label for a value.
  ///
  /// Parameters:
  /// - [value] (`int`, required): The value to get unit for.
  ///
  /// Returns: `String` — the unit label.
  String getUnit(int value) {
    if (value <= 0) return '0 ${units[0]}';
    var log10 = _log10(value);
    final digitGroups = (log10 / _log10(base)).floor();
    final unitIndex = min(digitGroups, units.length - 1);
    return units[unitIndex];
  }
}

const _fileByteUnits =
    SizeUnitLocale(1024, ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']);
const _fileBitUnits = SizeUnitLocale(
    1024, ['Bi', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB']);

double _log10(num x) {
  return log(x) / ln10;
}

/// Formats a file size in bytes to a human-readable string.
///
/// Converts byte values to appropriate units (B, KB, MB, GB, etc.) based
/// on the provided locale unit configuration.
///
/// Parameters:
/// - [bytes] (`int`, required): File size in bytes.
/// - [unit] (`SizeUnitLocale`, required): Unit locale configuration.
///
/// Returns: `String` — formatted file size with unit.
///
/// Example:
/// ```dart
/// formatFileSize(1024, SizeUnitLocale.fileBytes) // "1 KB"
/// formatFileSize(1536, SizeUnitLocale.fileBytes) // "1.5 KB"
/// ```
String formatFileSize(int bytes, SizeUnitLocale unit) {
  if (bytes <= 0) return '0 ${unit.units[0]}';
  final base = unit.base;
  final units = unit.units;
  int digitGroups = (_log10(bytes) / _log10(base)).floor();
  // return '${NumberFormat('#,##0.#').format(bytes / pow(base, digitGroups))} ${units[digitGroups]}';
  // do it without NumberFormat, but format to #,##0.# format
  final value = bytes / pow(base, digitGroups);
  final formattedValue =
      value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1);
  return '$formattedValue ${units[digitGroups]}';
}

int _getYear(DateTime dateTime) => dateTime.year;
int _getMonth(DateTime dateTime) => dateTime.month;
int _getDay(DateTime dateTime) => dateTime.day;

(int? min, int? max) _computeYearValueRange(Map<DatePart, int> values) {
  return (null, null);
}

(int? min, int? max) _computeMonthValueRange(Map<DatePart, int> values) {
  return (1, 12);
}

(int? min, int? max) _computeDayValueRange(Map<DatePart, int> values) {
  final year = values[DatePart.year];
  final month = values[DatePart.month];
  if (year == null || month == null) return (1, 31);
  final daysInMonth = DateTime(year, month + 1, 0).day;
  return (1, daysInMonth);
}

/// Represents a part of a date (year, month, or day).
///
/// Provides metadata and operations for individual date components.
enum DatePart {
  /// Year component (4 digits).
  year(_getYear, _computeYearValueRange, length: 4),

  /// Month component.
  month(_getMonth, _computeMonthValueRange),

  /// Day component.
  day(_getDay, _computeDayValueRange),
  ;

  /// Function that extracts the date/time component value from a DateTime.
  final int Function(DateTime dateTime) getter;

  /// Maximum number of digits for this date component.
  final int length;

  /// Function that computes the valid value range for this component.
  ///
  /// Takes a map of already-set date component values and returns the
  /// minimum and maximum valid values for this component, considering
  /// constraints like month lengths or leap years.
  final (int? min, int? max) Function(Map<DatePart, int> values)
      computeValueRange;

  const DatePart(this.getter, this.computeValueRange, {this.length = 2});
}

int _getDurationDay(Duration duration) => duration.inDays;
int _getDurationHour(Duration duration) => duration.inHours % 24;
int _getDurationMinute(Duration duration) => duration.inMinutes % 60;
int _getDurationSecond(Duration duration) => duration.inSeconds % 60;

(int? min, int? max) _computeDurationDayValueRange(
        Map<DurationPart, int> values) =>
    (0, null);
(int? min, int? max) _computeDurationHourValueRange(
        Map<DurationPart, int> values) =>
    (0, 23);
(int? min, int? max) _computeDurationMinuteValueRange(
        Map<DurationPart, int> values) =>
    (0, 59);
(int? min, int? max) _computeDurationSecondValueRange(
        Map<DurationPart, int> values) =>
    (0, 59);

/// Represents a part of a duration (day, hour, minute, or second).
enum DurationPart {
  /// Day component.
  day(_getDurationDay, _computeDurationDayValueRange),

  /// Hour component.
  hour(_getDurationHour, _computeDurationHourValueRange),

  /// Minute component.
  minute(_getDurationMinute, _computeDurationMinuteValueRange),

  /// Second component.
  second(_getDurationSecond, _computeDurationSecondValueRange),
  ;

  /// Function that extracts the duration component value from a Duration.
  final int Function(Duration duration) getter;

  /// Function that computes the valid value range for this component.
  final (int? min, int? max) Function(Map<DurationPart, int> values)
      computeValueRange;

  const DurationPart(this.getter, this.computeValueRange);
}

int _getTimeHour(TimeOfDay time) => time.hour;
int _getTimeMinute(TimeOfDay time) => time.minute;
int _getTimeSecond(TimeOfDay time) => time.second;

(int? min, int? max) _computeTimeHourValueRange(Map<TimePart, int> values) =>
    (0, 23);
(int? min, int? max) _computeTimeMinuteValueRange(Map<TimePart, int> values) =>
    (0, 59);
(int? min, int? max) _computeTimeSecondValueRange(Map<TimePart, int> values) =>
    (0, 59);

/// Represents a part of a time (hour, minute, or second).
enum TimePart {
  /// Hour component.
  hour(_getTimeHour, _computeTimeHourValueRange),

  /// Minute component.
  minute(_getTimeMinute, _computeTimeMinuteValueRange),

  /// Second component.
  second(_getTimeSecond, _computeTimeSecondValueRange),
  ;

  /// Function that extracts the time component value from a TimeOfDay.
  final int Function(TimeOfDay time) getter;

  /// Function that computes the valid value range for this component.
  final (int? min, int? max) Function(Map<TimePart, int> values)
      computeValueRange;

  const TimePart(this.getter, this.computeValueRange);
}
