import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../../shadcn_flutter.dart';

/// Localization delegate for Shadcn Flutter components.
///
/// Provides localized strings and formatters for UI components.
/// Supports internationalization of form validation messages, date formats,
/// and other user-facing text.
class ShadcnLocalizationsDelegate
    extends LocalizationsDelegate<ShadcnLocalizations> {
  /// Singleton instance of the delegate.
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

/// Abstract base class for localized strings in Shadcn Flutter.
///
/// Provides internationalization support for all user-facing text including
/// form validation messages, date/time labels, command palette text, and more.
/// Implementations provide locale-specific translations.
///
/// Example:
/// ```dart
/// final localizations = ShadcnLocalizations.of(context);
/// print(localizations.formNotEmpty); // "This field cannot be empty"
/// ```
abstract class ShadcnLocalizations {
  /// Gets the localizations for the current context.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context.
  ///
  /// Returns: `ShadcnLocalizations` instance for the current locale.
  static ShadcnLocalizations of(BuildContext context) {
    return Localizations.of<ShadcnLocalizations>(
            context, ShadcnLocalizations) ??
        DefaultShadcnLocalizations.instance;
  }

  /// Creates a [ShadcnLocalizations].
  const ShadcnLocalizations();

  /// Validation message: "This field cannot be empty".
  String get formNotEmpty;

  /// Validation message: "Invalid value".
  String get invalidValue;

  /// Validation message: "Invalid email address".
  String get invalidEmail;

  /// Validation message: "Invalid URL".
  String get invalidURL;

  /// Formats a number for display.
  ///
  /// Parameters:
  /// - [value] (`double`, required): Number to format.
  ///
  /// Returns: `String` — formatted number.
  String formatNumber(double value);

  /// Validation message for values less than a threshold.
  ///
  /// Parameters:
  /// - [value] (`double`, required): Threshold value.
  ///
  /// Returns: `String` — formatted validation message.
  String formLessThan(double value);

  /// Validation message for values greater than a threshold.
  ///
  /// Parameters:
  /// - [value] (`double`, required): Threshold value.
  ///
  /// Returns: `String` — formatted validation message.
  String formGreaterThan(double value);

  /// Validation message for values less than or equal to a threshold.
  ///
  /// Parameters:
  /// - [value] (`double`, required): Threshold value.
  ///
  /// Returns: `String` — formatted validation message.
  String formLessThanOrEqualTo(double value);

  /// Validation message for values greater than or equal to a threshold.
  ///
  /// Parameters:
  /// - [value] (`double`, required): Threshold value.
  ///
  /// Returns: `String` — formatted validation message.
  String formGreaterThanOrEqualTo(double value);

  /// Validation message for values between two thresholds (inclusive).
  ///
  /// Parameters:
  /// - [min] (`double`, required): Minimum value.
  /// - [max] (`double`, required): Maximum value.
  ///
  /// Returns: `String` — formatted validation message.
  String formBetweenInclusively(double min, double max);

  /// Validation message for values between two thresholds (exclusive).
  ///
  /// Parameters:
  /// - [min] (`double`, required): Minimum value.
  /// - [max] (`double`, required): Maximum value.
  ///
  /// Returns: `String` — formatted validation message.
  String formBetweenExclusively(double min, double max);

  /// Validation message for string length less than a threshold.
  ///
  /// Parameters:
  /// - [value] (`int`, required): Maximum length.
  ///
  /// Returns: `String` — formatted validation message.
  String formLengthLessThan(int value);

  /// Validation message for string length greater than a threshold.
  ///
  /// Parameters:
  /// - [value] (`int`, required): Minimum length.
  ///
  /// Returns: `String` — formatted validation message.
  String formLengthGreaterThan(int value);

  /// Password validation message: "Must contain digits".
  String get formPasswordDigits;

  /// Password validation message: "Must contain lowercase letters".
  String get formPasswordLowercase;

  /// Password validation message: "Must contain uppercase letters".
  String get formPasswordUppercase;

  /// Password validation message: "Must contain special characters".
  String get formPasswordSpecial;

  /// Order of date parts for the locale (e.g., [year, month, day] or [month, day, year]).
  List<DatePart> get datePartsOrder;

  /// Abbreviation for "year" (e.g., "Y" or "YYYY").
  String get dateYearAbbreviation;

  /// Abbreviation for "month" (e.g., "M" or "MM").
  String get dateMonthAbbreviation;

  /// Abbreviation for "day" (e.g., "D" or "DD").
  String get dateDayAbbreviation;

  /// Gets the abbreviation for a specific date part.
  ///
  /// Parameters:
  /// - [part] (`DatePart`, required): The date part.
  ///
  /// Returns: `String` — abbreviation for the date part.
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

  /// Command palette: "Search" placeholder text.
  String get commandSearch;

  /// Command palette: "No results found" empty state text.
  String get commandEmpty;

  /// Date picker: "Select year" instruction text.
  String get datePickerSelectYear;

  /// Abbreviated day name: "Mon".
  String get abbreviatedMonday;

  /// Abbreviated day name: "Tue".
  String get abbreviatedTuesday;

  /// Abbreviated day name: "Wed".
  String get abbreviatedWednesday;

  /// Abbreviated day name: "Thu".
  String get abbreviatedThursday;

  /// Abbreviated day name: "Fri".
  String get abbreviatedFriday;

  /// Abbreviated day name: "Sat".
  String get abbreviatedSaturday;

  /// Abbreviated day name: "Sun".
  String get abbreviatedSunday;

  /// Full month name: "January".
  String get monthJanuary;

  /// Full month name: "February".
  String get monthFebruary;

  /// Full month name: "March".
  String get monthMarch;

  /// Full month name: "April".
  String get monthApril;

  /// Full month name: "May".
  String get monthMay;

  /// Full month name: "June".
  String get monthJune;

  /// Full month name: "July".
  String get monthJuly;

  /// Full month name: "August".
  String get monthAugust;

  /// Full month name: "September".
  String get monthSeptember;

  /// Full month name: "October".
  String get monthOctober;

  /// Full month name: "November".
  String get monthNovember;

  /// Full month name: "December".
  String get monthDecember;

  /// Abbreviated month name: "Jan".
  String get abbreviatedJanuary;

  /// Abbreviated month name: "Feb".
  String get abbreviatedFebruary;

  /// Abbreviated month name: "Mar".
  String get abbreviatedMarch;

  /// Abbreviated month name: "Apr".
  String get abbreviatedApril;

  /// Abbreviated month name: "May".
  String get abbreviatedMay;

  /// Abbreviated month name: "Jun".
  String get abbreviatedJune;

  /// Abbreviated month name: "Jul".
  String get abbreviatedJuly;

  /// Abbreviated month name: "Aug".
  String get abbreviatedAugust;

  /// Abbreviated month name: "Sep".
  String get abbreviatedSeptember;

  /// Abbreviated month name: "Oct".
  String get abbreviatedOctober;

  /// Abbreviated month name: "Nov".
  String get abbreviatedNovember;

  /// Abbreviated month name: "Dec".
  String get abbreviatedDecember;

  /// Button label: "Cancel".
  String get buttonCancel;

  /// Button label: "OK".
  String get buttonOk;

  /// Button label: "Close".
  String get buttonClose;

  /// Button label: "Save".
  String get buttonSave;

  /// Button label: "Reset".
  String get buttonReset;

  /// Time unit label: "Hour".
  String get timeHour;

  /// Time unit label: "Minute".
  String get timeMinute;

  /// Time unit label: "Second".
  String get timeSecond;

  /// Time period: "AM" (ante meridiem).
  String get timeAM;

  /// Time period: "PM" (post meridiem).
  String get timePM;

  /// Color component label: "Red".
  String get colorRed;

  /// Color component label: "Green".
  String get colorGreen;

  /// Color component label: "Blue".
  String get colorBlue;

  /// Color component label: "Alpha" (transparency).
  String get colorAlpha;

  /// Color component label: "Hue".
  String get colorHue;

  /// Color component label: "Saturation".
  String get colorSaturation;

  /// Color component label: "Value" (brightness in HSV).
  String get colorValue;

  /// Color component label: "Lightness" (in HSL).
  String get colorLightness;

  /// Context menu: "Cut" action.
  String get menuCut;

  /// Context menu: "Copy" action.
  String get menuCopy;

  /// Context menu: "Paste" action.
  String get menuPaste;

  /// Context menu: "Select All" action.
  String get menuSelectAll;

  /// Context menu: "Undo" action.
  String get menuUndo;

  /// Context menu: "Redo" action.
  String get menuRedo;

  /// Context menu: "Delete" action.
  String get menuDelete;

  /// Context menu: "Share" action.
  String get menuShare;

  /// Context menu: "Search Web" action.
  String get menuSearchWeb;

  /// Context menu: "Live Text Input" action.
  String get menuLiveTextInput;

  /// Formats a date and time for display.
  ///
  /// Parameters:
  /// - [dateTime] (`DateTime`, required): Date/time to format.
  /// - [showDate] (`bool`, default: `true`): Include date.
  /// - [showTime] (`bool`, default: `true`): Include time.
  /// - [showSeconds] (`bool`, default: `false`): Include seconds.
  /// - [use24HourFormat] (`bool`, default: `true`): Use 24-hour format.
  ///
  /// Returns: `String` — formatted date/time.
  String formatDateTime(DateTime dateTime,
      {bool showDate = true,
      bool showTime = true,
      bool showSeconds = false,
      bool use24HourFormat = true});

  /// Formats a time of day for display.
  ///
  /// Parameters:
  /// - [time] (`TimeOfDay`, required): Time to format.
  /// - [use24HourFormat] (`bool`, default: `true`): Use 24-hour format.
  /// - [showSeconds] (`bool`, default: `false`): Include seconds.
  ///
  /// Returns: `String` — formatted time.
  String formatTimeOfDay(
    TimeOfDay time, {
    bool use24HourFormat = true,
    bool showSeconds = false,
  });

  /// Placeholder text: "Select a date".
  String get placeholderDatePicker;

  /// Placeholder text: "Select a time".
  String get placeholderTimePicker;

  /// Placeholder text: "Select a color".
  String get placeholderColorPicker;

  /// Button label: "Previous".
  String get buttonPrevious;

  /// Button label: "Next".
  String get buttonNext;

  /// Pull-to-refresh: "Pull to refresh" instruction.
  String get refreshTriggerPull;

  /// Pull-to-refresh: "Release to refresh" instruction.
  String get refreshTriggerRelease;

  /// Pull-to-refresh: "Refreshing..." status.
  String get refreshTriggerRefreshing;

  /// Pull-to-refresh: "Complete" status.
  String get refreshTriggerComplete;

  /// Search placeholder: "Search country".
  String get searchPlaceholderCountry;

  /// Empty state: "No countries found".
  String get emptyCountryList;

  /// Toast notification: "Snippet copied".
  String get toastSnippetCopied;

  /// Color picker tab: "Recent".
  String get colorPickerTabRecent;

  /// Color picker tab: "RGB".
  String get colorPickerTabRGB;

  /// Color picker tab: "HSV".
  String get colorPickerTabHSV;

  /// Color picker tab: "HSL".
  String get colorPickerTabHSL;

  /// Color picker tab: "HEX".
  String get colorPickerTabHEX;

  /// Command palette: "Move up" hint.
  String get commandMoveUp;

  /// Command palette: "Move down" hint.
  String get commandMoveDown;

  /// Command palette: "Activate" hint.
  String get commandActivate;

  /// Data table: Selected rows count message.
  ///
  /// Parameters:
  /// - [count] (`int`, required): Number of selected rows.
  /// - [total] (`int`, required): Total number of rows.
  ///
  /// Returns: `String` — formatted message (e.g., "2 of 10 selected").
  String dataTableSelectedRows(int count, int total);

  /// Data table: "Next" button.
  String get dataTableNext;

  /// Data table: "Previous" button.
  String get dataTablePrevious;

  /// Data table: "Columns" menu.
  String get dataTableColumns;

  /// Gets the display name for a color picker mode.
  ///
  /// Parameters:
  /// - [mode] (`ColorPickerMode`, required): Color picker mode.
  ///
  /// Returns: `String` — mode display name.
  String getColorPickerMode(ColorPickerMode mode) {
    switch (mode) {
      case ColorPickerMode.rgb:
        return colorPickerTabRGB;
      case ColorPickerMode.hsv:
        return colorPickerTabHSV;
      case ColorPickerMode.hsl:
        return colorPickerTabHSL;
      case ColorPickerMode.hex:
        return colorPickerTabHEX;
    }
  }

  /// Gets the abbreviated weekday name for a given weekday constant.
  ///
  /// Parameters:
  /// - [weekday] (int, required): Weekday constant from DateTime (DateTime.monday through DateTime.sunday)
  ///
  /// Returns the localized abbreviated weekday name (e.g., "Mon", "Tue").
  ///
  /// Throws [ArgumentError] if weekday is not a valid constant.
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

  /// Gets the full month name for a given month constant.
  ///
  /// Parameters:
  /// - [month] (int, required): Month constant from DateTime (DateTime.january through DateTime.december)
  ///
  /// Returns the localized full month name (e.g., "January", "February").
  ///
  /// Throws [ArgumentError] if month is not a valid constant.
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

  /// Gets the abbreviated month name for a given month constant.
  ///
  /// Parameters:
  /// - [month] (int, required): Month constant from DateTime (DateTime.january through DateTime.december)
  ///
  /// Returns the localized abbreviated month name (e.g., "Jan", "Feb").
  ///
  /// Throws [ArgumentError] if month is not a valid constant.
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

  /// Gets the abbreviated label for days in time displays (e.g., "d").
  String get timeDaysAbbreviation;

  /// Gets the abbreviated label for hours in time displays (e.g., "h").
  String get timeHoursAbbreviation;

  /// Gets the abbreviated label for minutes in time displays (e.g., "m").
  String get timeMinutesAbbreviation;

  /// Gets the abbreviated label for seconds in time displays (e.g., "s").
  String get timeSecondsAbbreviation;

  /// Gets the placeholder text for duration picker inputs.
  String get placeholderDurationPicker;

  /// Formats a duration as a localized string.
  ///
  /// Parameters:
  /// - [duration] (Duration, required): The duration to format
  /// - [showDays] (bool): Whether to show days component, defaults to true
  /// - [showHours] (bool): Whether to show hours component, defaults to true
  /// - [showMinutes] (bool): Whether to show minutes component, defaults to true
  /// - [showSeconds] (bool): Whether to show seconds component, defaults to true
  ///
  /// Returns a formatted duration string (e.g., "2d 3h 45m 12s").
  String formatDuration(Duration duration,
      {bool showDays = true,
      bool showHours = true,
      bool showMinutes = true,
      bool showSeconds = true});

  /// Gets the full word for "day" in duration displays.
  String get durationDay;

  /// Gets the full word for "hour" in duration displays.
  String get durationHour;

  /// Gets the full word for "minute" in duration displays.
  String get durationMinute;

  /// Gets the full word for "second" in duration displays.
  String get durationSecond;

  /// Gets the abbreviated label for a duration component.
  ///
  /// Parameters:
  /// - [part] (DurationPart, required): The duration component type
  ///
  /// Returns the localized abbreviation string for the component (e.g., "d", "h", "m", "s").
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

  /// Gets the abbreviated label for a time component.
  ///
  /// Parameters:
  /// - [part] (TimePart, required): The time component type
  ///
  /// Returns the localized abbreviation string for the component (e.g., "h", "m", "s").
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

  /// Gets a map of MIME types to their localized display names.
  ///
  /// Provides human-readable names for file types used in file pickers
  /// and upload dialogs. The map keys are MIME type strings (e.g., "image/png")
  /// and values are localized descriptions (e.g., "PNG Image").
  Map<String, String> get localizedMimeTypes;
}

/// Default English implementation of Shadcn localizations.
///
/// Provides English translations for all localized strings in Shadcn Flutter.
/// This is the default localization used when no specific locale is provided.
class DefaultShadcnLocalizations extends ShadcnLocalizations {
  /// Singleton instance of the default localizations.
  static const ShadcnLocalizations instance = DefaultShadcnLocalizations();

  /// Creates a default English localizations instance.
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
  String get colorPickerTabHEX => 'HEX';

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
