---
title: "Class: ShadcnLocalizations"
description: "Abstract base class for localized strings in Shadcn Flutter."
---

```dart
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
  static ShadcnLocalizations of(BuildContext context);
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
  String getDatePartAbbreviation(DatePart part);
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
  String formatDateTime(DateTime dateTime, {bool showDate = true, bool showTime = true, bool showSeconds = false, bool use24HourFormat = true});
  /// Formats a time of day for display.
  ///
  /// Parameters:
  /// - [time] (`TimeOfDay`, required): Time to format.
  /// - [use24HourFormat] (`bool`, default: `true`): Use 24-hour format.
  /// - [showSeconds] (`bool`, default: `false`): Include seconds.
  ///
  /// Returns: `String` — formatted time.
  String formatTimeOfDay(TimeOfDay time, {bool use24HourFormat = true, bool showSeconds = false});
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
  String getColorPickerMode(ColorPickerMode mode);
  /// Gets the abbreviated weekday name for a given weekday constant.
  ///
  /// Parameters:
  /// - [weekday] (int, required): Weekday constant from DateTime (DateTime.monday through DateTime.sunday)
  ///
  /// Returns the localized abbreviated weekday name (e.g., "Mon", "Tue").
  ///
  /// Throws [ArgumentError] if weekday is not a valid constant.
  String getAbbreviatedWeekday(int weekday);
  /// Gets the full month name for a given month constant.
  ///
  /// Parameters:
  /// - [month] (int, required): Month constant from DateTime (DateTime.january through DateTime.december)
  ///
  /// Returns the localized full month name (e.g., "January", "February").
  ///
  /// Throws [ArgumentError] if month is not a valid constant.
  String getMonth(int month);
  /// Gets the abbreviated month name for a given month constant.
  ///
  /// Parameters:
  /// - [month] (int, required): Month constant from DateTime (DateTime.january through DateTime.december)
  ///
  /// Returns the localized abbreviated month name (e.g., "Jan", "Feb").
  ///
  /// Throws [ArgumentError] if month is not a valid constant.
  String getAbbreviatedMonth(int month);
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
  String formatDuration(Duration duration, {bool showDays = true, bool showHours = true, bool showMinutes = true, bool showSeconds = true});
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
  String getDurationPartAbbreviation(DurationPart part);
  /// Gets the abbreviated label for a time component.
  ///
  /// Parameters:
  /// - [part] (TimePart, required): The time component type
  ///
  /// Returns the localized abbreviation string for the component (e.g., "h", "m", "s").
  String getTimePartAbbreviation(TimePart part);
  /// Gets a map of MIME types to their localized display names.
  ///
  /// Provides human-readable names for file types used in file pickers
  /// and upload dialogs. The map keys are MIME type strings (e.g., "image/png")
  /// and values are localized descriptions (e.g., "PNG Image").
  Map<String, String> get localizedMimeTypes;
}
```
