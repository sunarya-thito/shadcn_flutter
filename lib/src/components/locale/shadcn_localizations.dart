import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../../shadcn_flutter.dart';

/// Localizations delegate for the shadcn_flutter framework.
///
/// This delegate provides localized strings and formatting for all shadcn_flutter
/// components. It integrates with Flutter's localization system to provide
/// context-aware text content and formatting across different locales.
///
/// The delegate uses [DefaultShadcnLocalizations] as the implementation,
/// providing English text by default. Custom localizations can be provided
/// by extending [ShadcnLocalizations] and creating custom delegates.
///
/// Example:
/// ```dart
/// MaterialApp(
///   localizationsDelegates: [
///     ShadcnLocalizationsDelegate.delegate,
///     GlobalMaterialLocalizations.delegate,
///     GlobalWidgetsLocalizations.delegate,
///   ],
///   supportedLocales: [Locale('en', 'US')],
/// )
/// ```
class ShadcnLocalizationsDelegate
    extends LocalizationsDelegate<ShadcnLocalizations> {
  /// Shared instance of the shadcn_flutter localizations delegate.
  static const ShadcnLocalizationsDelegate delegate =
      ShadcnLocalizationsDelegate();
  
  /// Creates a [ShadcnLocalizationsDelegate].
  const ShadcnLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<ShadcnLocalizations> load(Locale locale) {
    return SynchronousFuture<ShadcnLocalizations>(
        DefaultShadcnLocalizations.instance);
  }

  @override
  bool shouldReload(ShadcnLocalizationsDelegate old) => false;
}

const _fileByteUnits =
    SizeUnitLocale(1024, ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB']);
const _fileBitUnits = SizeUnitLocale(
    1024, ['Bi', 'KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB']);

/// Configuration for formatting file sizes with different unit systems.
///
/// [SizeUnitLocale] provides comprehensive control over how file sizes are
/// displayed, including the base unit system (1024 vs 1000), unit labels,
/// and digit grouping separators for different locales.
///
/// Supports both binary (1024-based) and decimal (1000-based) unit systems
/// commonly used for file sizes, with appropriate unit labels and formatting.
///
/// Example:
/// ```dart
/// // Custom binary units for European locales
/// final europeanUnits = SizeUnitLocale(
///   1024, 
///   ['B', 'KB', 'MB', 'GB', 'TB'], 
///   separator: ' ',
/// );
/// ```
class SizeUnitLocale {
  /// The base unit for size calculations.
  ///
  /// Typically 1024 for binary file sizes or 1000 for decimal sizes.
  /// This base is raised to powers to calculate larger units.
  final int base;
  
  /// List of unit labels from smallest to largest.
  ///
  /// Each position represents the next power of the base. For example,
  /// ['B', 'KB', 'MB'] represents bytes, kilobytes, and megabytes.
  final List<String> units;
  
  /// Separator character for digit grouping in large numbers.
  ///
  /// Used to format large numbers with thousands separators, e.g.,
  /// '1,000,000' with separator ',' or '1 000 000' with separator ' '.
  final String separator;
  /// Creates a [SizeUnitLocale] with base, units, and separator.
  ///
  /// Parameters:
  /// - [base] (int, required): Base for unit calculations (typically 1024 or 1000)
  /// - [units] (List<String>, required): Unit labels from smallest to largest
  /// - [separator] (String, default: ','): Digit grouping separator
  ///
  /// Example:
  /// ```dart
  /// SizeUnitLocale(
  ///   1024, 
  ///   ['B', 'KB', 'MB', 'GB'], 
  ///   separator: ' ',
  /// )
  /// ```
  const SizeUnitLocale(this.base, this.units, {this.separator = ','});

  /// Standard file byte units using binary (1024-based) system.
  ///
  /// Uses the conventional binary file size units: B, KB, MB, GB, TB, PB, EB, ZB, YB.
  static const SizeUnitLocale fileBytes = _fileByteUnits;
  
  /// Standard file bit units using binary (1024-based) system with 'i' notation.
  ///
  /// Uses binary units with proper 'i' notation: Bi, KiB, MiB, GiB, TiB, PiB, EiB, ZiB, YiB.
  static const SizeUnitLocale fileBits = _fileBitUnits;

  /// Returns the appropriate unit label for a given byte value.
  ///
  /// Calculates which unit label should be used based on the magnitude
  /// of the value and the configured base system.
  ///
  /// Parameters:
  /// - [value] (int): The size value to determine the unit for
  ///
  /// Returns: The appropriate unit string (e.g., 'KB', 'MB', 'GB').
  ///
  /// Example:
  /// ```dart
  /// final unit = SizeUnitLocale.fileBytes.getUnit(1048576); // Returns 'MB'
  /// ```
  String getUnit(int value) {
    if (value <= 0) return '0 ${units[0]}';
    var log10 = _log10(value);
    final digitGroups = (log10 / _log10(base)).floor();
    final unitIndex = min(digitGroups, units.length - 1);
    return units[unitIndex];
  }
}

/// Calculates base-10 logarithm for unit calculations.
///
/// Used internally for determining the appropriate unit scale for file sizes.
/// This avoids dependency on dart:math for a simple logarithm calculation.
double _log10(num x) {
  return log(x) / ln10;
}

/// Formats a file size value according to the specified unit locale.
///
/// Converts raw byte values into human-readable format with appropriate units
/// and formatting. Automatically selects the most appropriate unit based on
/// the magnitude of the value.
///
/// Parameters:
/// - [bytes] (int): The file size in bytes to format
/// - [unit] (SizeUnitLocale): The unit system and formatting configuration
///
/// Returns: A formatted string like '1.5 MB' or '2.3 GB'.
///
/// Example:
/// ```dart
/// final formatted = formatFileSize(1048576, SizeUnitLocale.fileBytes);
/// // Returns '1 MB'
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

/// Extracts the year from a DateTime.
///
/// Helper function for DatePart.year getter functionality.
int _getYear(DateTime dateTime) => dateTime.year;

/// Extracts the month from a DateTime.
///
/// Helper function for DatePart.month getter functionality.
int _getMonth(DateTime dateTime) => dateTime.month;

/// Extracts the day from a DateTime.
///
/// Helper function for DatePart.day getter functionality.
int _getDay(DateTime dateTime) => dateTime.day;

/// Computes valid year range (unrestricted).
///
/// Helper function for DatePart.year range computation.
/// Returns (null, null) indicating no inherent year restrictions.
(int? min, int? max) _computeYearValueRange(Map<DatePart, int> values) {
  return (null, null);
}

/// Computes valid month range (1-12).
///
/// Helper function for DatePart.month range computation.
/// Always returns (1, 12) regardless of other date components.
(int? min, int? max) _computeMonthValueRange(Map<DatePart, int> values) {
  return (1, 12);
}

/// Computes valid day range based on year and month.
///
/// Helper function for DatePart.day range computation.
/// Calculates the number of days in the specified month and year,
/// accounting for leap years and varying month lengths.
(int? min, int? max) _computeDayValueRange(Map<DatePart, int> values) {
  final year = values[DatePart.year];
  final month = values[DatePart.month];
  if (year == null || month == null) return (1, 31);
  final daysInMonth = DateTime(year, month + 1, 0).day;
  return (1, daysInMonth);
}

/// Enumeration of date parts for date formatting and validation.
///
/// [DatePart] represents different components of a date (year, month, day)
/// with associated parsing, validation, and range computation capabilities.
/// Each part knows how to extract its value from a DateTime and compute
/// valid ranges based on other date components.
///
/// Used primarily in date input components and date pickers for structured
/// date entry and validation.
///
/// Example:
/// ```dart
/// final year = DatePart.year.getter(DateTime.now()); // Extract year
/// final (min, max) = DatePart.day.computeValueRange({'year': 2024, 'month': 2});
/// // Returns (1, 29) for February 2024
/// ```
enum DatePart {
  /// Year component of a date.
  ///
  /// Extracts and validates 4-digit year values. Has no inherent range
  /// constraints, allowing for historical and future dates.
  year(_getYear, _computeYearValueRange, length: 4),
  
  /// Month component of a date.
  ///
  /// Extracts and validates month values with a fixed range of 1-12.
  /// Used for month selection and validation in date inputs.
  month(_getMonth, _computeMonthValueRange),
  
  /// Day component of a date.
  ///
  /// Extracts and validates day values with dynamic range based on the
  /// specific year and month to account for different month lengths.
  day(_getDay, _computeDayValueRange);

  /// Function to extract this date part's value from a DateTime.
  final int Function(DateTime dateTime) getter;
  
  /// Expected length in characters for this date part.
  ///
  /// Used for formatting and input validation. Year is 4 characters,
  /// month and day are 2 characters with leading zeros if needed.
  final int length;
  
  /// Function to compute the valid value range for this date part.
  ///
  /// Takes a map of other date part values and returns the minimum and
  /// maximum valid values for this part given those constraints.
  final (int? min, int? max) Function(Map<DatePart, int> values)
      computeValueRange;

  /// Creates a [DatePart] with extraction and validation functions.
  ///
  /// Parameters:
  /// - [getter] (Function): Extracts the value from a DateTime
  /// - [computeValueRange] (Function): Computes valid range for this part
  /// - [length] (int): Expected character length (defaults to 2)
  const DatePart(this.getter, this.computeValueRange, {this.length = 2});
}

abstract class ShadcnLocalizations {
  static ShadcnLocalizations of(BuildContext context) {
    return Localizations.of<ShadcnLocalizations>(
            context, ShadcnLocalizations) ??
        DefaultShadcnLocalizations.instance;
  }

  const ShadcnLocalizations();
  // String formatFileSize(int bytes);
  String get formNotEmpty;
  String get invalidValue;
  String get invalidEmail;
  String get invalidURL;
  String formatNumber(double value);
  String formLessThan(double value);
  String formGreaterThan(double value);
  String formLessThanOrEqualTo(double value);
  String formGreaterThanOrEqualTo(double value);
  String formBetweenInclusively(double min, double max);
  String formBetweenExclusively(double min, double max);
  String formLengthLessThan(int value);
  String formLengthGreaterThan(int value);
  String get formPasswordDigits;
  String get formPasswordLowercase;
  String get formPasswordUppercase;
  String get formPasswordSpecial;

  List<DatePart> get datePartsOrder;
  String get dateYearAbbreviation;
  String get dateMonthAbbreviation;
  String get dateDayAbbreviation;

  String getDatePartAbbreviation(DatePart part) {
    switch (part) {
      case DatePart.year:
        return dateYearAbbreviation;
      case DatePart.month:
        return dateMonthAbbreviation;
      case DatePart.day:
        return dateDayAbbreviation;
    }
  }

  String get commandSearch;
  String get commandEmpty;
  String get datePickerSelectYear;
  String get abbreviatedMonday;
  String get abbreviatedTuesday;
  String get abbreviatedWednesday;
  String get abbreviatedThursday;
  String get abbreviatedFriday;
  String get abbreviatedSaturday;
  String get abbreviatedSunday;
  String get monthJanuary;
  String get monthFebruary;
  String get monthMarch;
  String get monthApril;
  String get monthMay;
  String get monthJune;
  String get monthJuly;
  String get monthAugust;
  String get monthSeptember;
  String get monthOctober;
  String get monthNovember;
  String get monthDecember;
  String get abbreviatedJanuary;
  String get abbreviatedFebruary;
  String get abbreviatedMarch;
  String get abbreviatedApril;
  String get abbreviatedMay;
  String get abbreviatedJune;
  String get abbreviatedJuly;
  String get abbreviatedAugust;
  String get abbreviatedSeptember;
  String get abbreviatedOctober;
  String get abbreviatedNovember;
  String get abbreviatedDecember;
  String get buttonCancel;
  String get buttonOk;
  String get buttonClose;
  String get buttonSave;
  String get buttonReset;
  String get timeHour;
  String get timeMinute;
  String get timeSecond;
  String get timeAM;
  String get timePM;
  String get colorRed;
  String get colorGreen;
  String get colorBlue;
  String get colorAlpha;
  String get colorHue;
  String get colorSaturation;
  String get colorValue;
  String get colorLightness;
  String get menuCut;
  String get menuCopy;
  String get menuPaste;
  String get menuSelectAll;
  String get menuUndo;
  String get menuRedo;
  String get menuDelete;
  String get menuShare;
  String get menuSearchWeb;
  String get menuLiveTextInput;
  String formatDateTime(DateTime dateTime,
      {bool showDate = true,
      bool showTime = true,
      bool showSeconds = false,
      bool use24HourFormat = true});

  String formatTimeOfDay(
    TimeOfDay time, {
    bool use24HourFormat = true,
    bool showSeconds = false,
  });
  String get placeholderDatePicker;
  String get placeholderTimePicker;
  String get placeholderColorPicker;
  String get buttonPrevious;
  String get buttonNext;

  String get refreshTriggerPull;
  String get refreshTriggerRelease;
  String get refreshTriggerRefreshing;
  String get refreshTriggerComplete;

  String get searchPlaceholderCountry;
  String get emptyCountryList;
  String get toastSnippetCopied;

  String get colorPickerTabRecent;
  String get colorPickerTabRGB;
  String get colorPickerTabHSV;
  String get colorPickerTabHSL;

  String get commandMoveUp;
  String get commandMoveDown;
  String get commandActivate;

  String dataTableSelectedRows(int count, int total);
  String get dataTableNext;
  String get dataTablePrevious;
  String get dataTableColumns;

  String getColorPickerMode(ColorPickerMode mode) {
    switch (mode) {
      case ColorPickerMode.rgb:
        return colorPickerTabRGB;
      case ColorPickerMode.hsv:
        return colorPickerTabHSV;
      case ColorPickerMode.hsl:
        return colorPickerTabHSL;
    }
  }

  String getAbbreviatedWeekday(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return abbreviatedMonday;
      case DateTime.tuesday:
        return abbreviatedTuesday;
      case DateTime.wednesday:
        return abbreviatedWednesday;
      case DateTime.thursday:
        return abbreviatedThursday;
      case DateTime.friday:
        return abbreviatedFriday;
      case DateTime.saturday:
        return abbreviatedSaturday;
      case DateTime.sunday:
        return abbreviatedSunday;
      default:
        throw ArgumentError.value(weekday, 'weekday');
    }
  }

  String getMonth(int month) {
    switch (month) {
      case DateTime.january:
        return monthJanuary;
      case DateTime.february:
        return monthFebruary;
      case DateTime.march:
        return monthMarch;
      case DateTime.april:
        return monthApril;
      case DateTime.may:
        return monthMay;
      case DateTime.june:
        return monthJune;
      case DateTime.july:
        return monthJuly;
      case DateTime.august:
        return monthAugust;
      case DateTime.september:
        return monthSeptember;
      case DateTime.october:
        return monthOctober;
      case DateTime.november:
        return monthNovember;
      case DateTime.december:
        return monthDecember;
      default:
        throw ArgumentError.value(month, 'month');
    }
  }

  String getAbbreviatedMonth(int month) {
    switch (month) {
      case DateTime.january:
        return abbreviatedJanuary;
      case DateTime.february:
        return abbreviatedFebruary;
      case DateTime.march:
        return abbreviatedMarch;
      case DateTime.april:
        return abbreviatedApril;
      case DateTime.may:
        return abbreviatedMay;
      case DateTime.june:
        return abbreviatedJune;
      case DateTime.july:
        return abbreviatedJuly;
      case DateTime.august:
        return abbreviatedAugust;
      case DateTime.september:
        return abbreviatedSeptember;
      case DateTime.october:
        return abbreviatedOctober;
      case DateTime.november:
        return abbreviatedNovember;
      case DateTime.december:
        return abbreviatedDecember;
      default:
        throw ArgumentError.value(month, 'month');
    }
  }

  String get timeDaysAbbreviation;
  String get timeHoursAbbreviation;
  String get timeMinutesAbbreviation;
  String get timeSecondsAbbreviation;
  String get placeholderDurationPicker;
  String formatDuration(Duration duration,
      {bool showDays = true,
      bool showHours = true,
      bool showMinutes = true,
      bool showSeconds = true});
  String get durationDay;
  String get durationHour;
  String get durationMinute;
  String get durationSecond;

  String getDurationPartAbbreviation(DurationPart part) {
    switch (part) {
      case DurationPart.day:
        return timeDaysAbbreviation;
      case DurationPart.hour:
        return timeHoursAbbreviation;
      case DurationPart.minute:
        return timeMinutesAbbreviation;
      case DurationPart.second:
        return timeSecondsAbbreviation;
    }
  }

  String getTimePartAbbreviation(TimePart part) {
    switch (part) {
      case TimePart.hour:
        return timeHoursAbbreviation;
      case TimePart.minute:
        return timeMinutesAbbreviation;
      case TimePart.second:
        return timeSecondsAbbreviation;
    }
  }

  Map<String, String> get localizedMimeTypes;
}

class DefaultShadcnLocalizations extends ShadcnLocalizations {
  static const ShadcnLocalizations instance = DefaultShadcnLocalizations();

  const DefaultShadcnLocalizations();

  @override
  final Map<String, String> localizedMimeTypes = const {
    'audio/aac': 'AAC Audio',
    'application/x-abiword': 'AbiWord Document',
    'image/apng': 'Animated Portable Network Graphics',
    'application/x-freearc': 'Archive Document',
    'image/avif': 'AVIF Image',
    'video/x-msvideo': 'AVI: Audio Video Interleave',
    'application/vnd.amazon.ebook': 'Amazon Kindle eBook Format',
    'application/octet-stream': 'Binary Data',
    'image/bmp': 'Windows OS/2 Bitmap Graphics',
    'application/x-bzip': 'BZip Archive',
    'application/x-bzip2': 'BZip2 Archive',
    'application/x-cdf': 'CD Audio',
    'application/x-csh': 'C-Shell Script',
    'text/css': 'Cascading Style Sheets (CSS)',
    'text/csv': 'Comma-Separated Values (CSV)',
    'application/msword': 'Microsoft Word',
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
        'Microsoft Word (OpenXML)',
    'application/vnd.ms-fontobject': 'MS Embedded OpenType Fonts',
    'application/epub+zip': 'Electronic Publication (EPUB)',
    'application/gzip': 'GZip Compressed Archive',
    'image/gif': 'Graphics Interchange Format (GIF)',
    'text/html': 'HyperText Markup Language (HTML)',
    'image/vnd.microsoft.icon': 'Icon Format',
    'text/calendar': 'iCalendar Format',
    'application/java-archive': 'Java Archive (JAR)',
    'image/jpeg': 'JPEG Images',
    'text/javascript': 'JavaScript',
    'application/json': 'JSON Format',
    'application/ld+json': 'JSON-LD Format',
    'audio/midi': 'Musical Instrument Digital Interface (MIDI)',
    'audio/x-midi': 'Musical Instrument Digital Interface (MIDI)',
    'audio/mpeg': 'MP3 Audio',
    'video/mp4': 'MP4 Video',
    'video/mpeg': 'MPEG Video',
    'application/vnd.apple.installer+xml': 'Apple Installer Package',
    'application/vnd.oasis.opendocument.presentation':
        'OpenDocument Presentation Document',
    'application/vnd.oasis.opendocument.spreadsheet':
        'OpenDocument Spreadsheet Document',
    'application/vnd.oasis.opendocument.text': 'OpenDocument Text Document',
    'audio/ogg': 'Ogg Audio',
    'video/ogg': 'Ogg Video',
    'application/ogg': 'Ogg',
    'font/otf': 'OpenType Font',
    'image/png': 'Portable Network Graphics',
    'application/pdf': 'Adobe Portable Document Format (PDF)',
    'application/x-httpd-php': 'Hypertext Preprocessor (Personal Home Page)',
    'application/vnd.ms-powerpoint': 'Microsoft PowerPoint',
    'application/vnd.openxmlformats-officedocument.presentationml.presentation':
        'Microsoft PowerPoint (OpenXML)',
    'application/vnd.rar': 'RAR Archive',
    'application/rtf': 'Rich Text Format (RTF)',
    'application/x-sh': 'Bourne Shell Script',
    'image/svg+xml': 'Scalable Vector Graphics (SVG)',
    'application/x-tar': 'Tape Archive (TAR)',
    'image/tiff': 'Tagged Image File Format (TIFF)',
    'video/mp2t': 'MPEG Transport Stream',
    'font/ttf': 'TrueType Font',
    'text/plain': 'Text',
    'application/vnd.visio': 'Microsoft Visio',
    'audio/wav': 'Waveform Audio Format',
    'audio/webm': 'WEBM Audio',
    'video/webm': 'WEBM Video',
    'image/webp': 'WEBP Image',
    'font/woff': 'Web Open Font Format (WOFF)',
    'font/woff2': 'Web Open Font Format (WOFF)',
    'application/xhtml+xml': 'XHTML',
    'application/vnd.ms-excel': 'Microsoft Excel',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
        'Microsoft Excel (OpenXML)',
    'application/xml': 'XML',
    'application/vnd.mozilla.xul+xml': 'XUL',
    'application/zip': 'ZIP Archive',
    'video/3gpp': '3GPP Audio/Video Container',
    'audio/3gpp': '3GPP Audio/Video Container',
    'video/3gpp2': '3GPP2 Audio/Video Container',
    'audio/3gpp2': '3GPP2 Audio/Video Container',
    'application/x-7z-compressed': '7-Zip Archive',
  };

  @override
  String get commandMoveUp => 'Move Up';

  @override
  String get commandMoveDown => 'Move Down';

  @override
  String get commandActivate => 'Select';

  @override
  String get timeDaysAbbreviation => 'DD';

  @override
  String get timeHoursAbbreviation => 'HH';

  @override
  String get timeMinutesAbbreviation => 'MM';

  @override
  String get timeSecondsAbbreviation => 'SS';

  @override
  String get commandSearch => 'Type a command or search...';

  @override
  String get commandEmpty => 'No results found.';

  @override
  String get formNotEmpty => 'This field cannot be empty';

  @override
  String get invalidValue => 'Invalid value';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get invalidURL => 'Invalid URL';

  @override
  String formatNumber(double value) {
    // if the value is an integer, return it as an integer
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  @override
  String formLessThan(double value) =>
      'Must be less than ${formatNumber(value)}';

  @override
  String formGreaterThan(double value) =>
      'Must be greater than ${formatNumber(value)}';

  @override
  String formLessThanOrEqualTo(double value) =>
      'Must be less than or equal to ${formatNumber(value)}';

  @override
  String formGreaterThanOrEqualTo(double value) =>
      'Must be greater than or equal to ${formatNumber(value)}';

  @override
  String formBetweenInclusively(double min, double max) =>
      'Must be between ${formatNumber(min)} and ${formatNumber(max)} (inclusive)';

  @override
  String formBetweenExclusively(double min, double max) =>
      'Must be between ${formatNumber(min)} and ${formatNumber(max)} (exclusive)';

  @override
  String formLengthLessThan(int value) => 'Must be at least $value characters';

  @override
  String formLengthGreaterThan(int value) =>
      'Must be at most $value characters';

  @override
  String get formPasswordDigits => 'Must contain at least one digit';

  @override
  String get formPasswordLowercase =>
      'Must contain at least one lowercase letter';

  @override
  String get formPasswordUppercase =>
      'Must contain at least one uppercase letter';

  @override
  String get formPasswordSpecial =>
      'Must contain at least one special character';

  @override
  String get abbreviatedMonday => 'Mo';

  @override
  String get abbreviatedTuesday => 'Tu';

  @override
  String get abbreviatedWednesday => 'We';

  @override
  String get abbreviatedThursday => 'Th';

  @override
  String get abbreviatedFriday => 'Fr';

  @override
  String get abbreviatedSaturday => 'Sa';

  @override
  String get abbreviatedSunday => 'Su';

  @override
  String get monthJanuary => 'January';

  @override
  String get monthFebruary => 'February';

  @override
  String get monthMarch => 'March';

  @override
  String get monthApril => 'April';

  @override
  String get monthMay => 'May';

  @override
  String get monthJune => 'June';

  @override
  String get monthJuly => 'July';

  @override
  String get monthAugust => 'August';

  @override
  String get monthSeptember => 'September';

  @override
  String get monthOctober => 'October';

  @override
  String get monthNovember => 'November';

  @override
  String get monthDecember => 'December';

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get buttonOk => 'OK';

  @override
  String get buttonClose => 'Close';

  @override
  String get buttonSave => 'Save';

  @override
  String get buttonReset => 'Reset';

  @override
  String formatDateTime(DateTime dateTime,
      {bool showDate = true,
      bool showTime = true,
      bool showSeconds = false,
      bool use24HourFormat = true}) {
    String result = '';
    if (showDate) {
      result += '${getMonth(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
    }
    if (showTime) {
      if (use24HourFormat) {
        if (result.isNotEmpty) {
          result += ' ';
        }
        result += '${dateTime.hour}:${dateTime.minute}';
        if (showSeconds) {
          result += ':${dateTime.second}';
        }
      } else {
        if (result.isNotEmpty) {
          result += ' ';
        }
        int hour = dateTime.hour;
        if (hour > 12) {
          hour -= 12;
          result += '$hour:${dateTime.minute} PM';
        } else {
          result += '$hour:${dateTime.minute} AM';
        }
      }
    }
    return result;
  }

  @override
  String get dateYearAbbreviation => 'YYYY';

  @override
  String get dateMonthAbbreviation => 'MM';

  @override
  String get dateDayAbbreviation => 'DD';

  @override
  String get placeholderDatePicker => 'Select a date';

  @override
  String get placeholderColorPicker => 'Select a color';

  @override
  String get buttonNext => 'Next';

  @override
  String get buttonPrevious => 'Previous';

  @override
  String get searchPlaceholderCountry => 'Search country...';

  @override
  String get emptyCountryList => 'No countries found';

  @override
  String get placeholderTimePicker => 'Select a time';

  @override
  String formatTimeOfDay(TimeOfDay time,
      {bool use24HourFormat = true, bool showSeconds = false}) {
    String result = '';
    if (use24HourFormat) {
      result +=
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      if (showSeconds) {
        result += ':${time.second.toString().padLeft(2, '0')}';
      }
    } else {
      int hour = time.hour;
      if (hour > 12) {
        hour -= 12;
        if (showSeconds) {
          result +=
              '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')} PM';
        } else {
          result +=
              '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} PM';
        }
      } else {
        if (showSeconds) {
          result +=
              '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')} AM';
        } else {
          result +=
              '${hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} AM';
        }
      }
    }
    return result;
  }

  @override
  String get timeHour => 'Hour';

  @override
  String get timeMinute => 'Minute';

  @override
  String get timeSecond => 'Second';

  @override
  String get timeAM => 'AM';

  @override
  String get timePM => 'PM';

  @override
  String get toastSnippetCopied => 'Copied to clipboard';

  @override
  String get datePickerSelectYear => 'Select a year';

  @override
  String get abbreviatedJanuary => 'Jan';

  @override
  String get abbreviatedFebruary => 'Feb';

  @override
  String get abbreviatedMarch => 'Mar';

  @override
  String get abbreviatedApril => 'Apr';

  @override
  String get abbreviatedMay => 'May';

  @override
  String get abbreviatedJune => 'Jun';

  @override
  String get abbreviatedJuly => 'Jul';

  @override
  String get abbreviatedAugust => 'Aug';

  @override
  String get abbreviatedSeptember => 'Sep';

  @override
  String get abbreviatedOctober => 'Oct';

  @override
  String get abbreviatedNovember => 'Nov';

  @override
  String get abbreviatedDecember => 'Dec';

  @override
  String get colorRed => 'Red';

  @override
  String get colorGreen => 'Green';

  @override
  String get colorBlue => 'Blue';

  @override
  String get colorAlpha => 'Alpha';

  @override
  String get menuCut => 'Cut';

  @override
  String get menuCopy => 'Copy';

  @override
  String get menuPaste => 'Paste';

  @override
  String get menuSelectAll => 'Select All';

  @override
  String get menuUndo => 'Undo';

  @override
  String get menuRedo => 'Redo';

  @override
  String get menuDelete => 'Delete';

  @override
  String get menuShare => 'Share';

  @override
  String get menuSearchWeb => 'Search Web';

  @override
  String get menuLiveTextInput => 'Live Text Input';

  @override
  String get refreshTriggerPull => 'Pull to refresh';

  @override
  String get refreshTriggerRelease => 'Release to refresh';

  @override
  String get refreshTriggerRefreshing => 'Refreshing...';

  @override
  String get refreshTriggerComplete => 'Refresh complete';

  @override
  String get colorPickerTabRecent => 'Recent';

  @override
  String get colorPickerTabRGB => 'RGB';

  @override
  String get colorPickerTabHSV => 'HSV';

  @override
  String get colorPickerTabHSL => 'HSL';

  @override
  String get colorHue => 'Hue';

  @override
  String get colorSaturation => 'Sat';

  @override
  String get colorValue => 'Val';

  @override
  String get colorLightness => 'Lum';

  @override
  String get dataTableColumns => 'Columns';

  @override
  String get dataTableNext => 'Next';

  @override
  String get dataTablePrevious => 'Previous';

  @override
  String dataTableSelectedRows(int count, int total) {
    return '$count of $total row(s) selected.';
  }

  @override
  List<DatePart> get datePartsOrder => const [
        // MM/DD/YYYY
        DatePart.month,
        DatePart.day,
        DatePart.year,
      ];

  @override
  String get durationDay => 'Day';

  @override
  String get durationHour => 'Hour';

  @override
  String get durationMinute => 'Minute';

  @override
  String get durationSecond => 'Second';

  @override
  String formatDuration(Duration duration,
      {bool showDays = true,
      bool showHours = true,
      bool showMinutes = true,
      bool showSeconds = true}) {
    final days = duration.inDays;
    final hours = duration.inHours % Duration.hoursPerDay;
    final minutes = duration.inMinutes % Duration.minutesPerHour;
    final seconds = duration.inSeconds % Duration.secondsPerMinute;
    final parts = <String>[];
    if (showDays && days > 0) {
      parts.add('${days}d');
    }
    if (showHours && hours > 0) {
      parts.add('${hours}h');
    }
    if (showMinutes && minutes > 0) {
      parts.add('${minutes}m');
    }
    if (showSeconds && seconds > 0) {
      parts.add('${seconds}s');
    }
    return parts.join(' ');
  }

  @override
  String get placeholderDurationPicker => 'Select a duration';
}
