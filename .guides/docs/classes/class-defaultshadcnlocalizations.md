---
title: "Class: DefaultShadcnLocalizations"
description: "Default English implementation of Shadcn localizations."
---

```dart
/// Default English implementation of Shadcn localizations.
///
/// Provides English translations for all localized strings in Shadcn Flutter.
/// This is the default localization used when no specific locale is provided.
class DefaultShadcnLocalizations extends ShadcnLocalizations {
  /// Singleton instance of the default localizations.
  static const ShadcnLocalizations instance = DefaultShadcnLocalizations();
  /// Creates a default English localizations instance.
  const DefaultShadcnLocalizations();
  final Map<String, String> localizedMimeTypes;
  String get commandMoveUp;
  String get commandMoveDown;
  String get commandActivate;
  String get timeDaysAbbreviation;
  String get timeHoursAbbreviation;
  String get timeMinutesAbbreviation;
  String get timeSecondsAbbreviation;
  String get commandSearch;
  String get commandEmpty;
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
  String get buttonCancel;
  String get buttonOk;
  String get buttonClose;
  String get buttonSave;
  String get buttonReset;
  String formatDateTime(DateTime dateTime, {bool showDate = true, bool showTime = true, bool showSeconds = false, bool use24HourFormat = true});
  String get dateYearAbbreviation;
  String get dateMonthAbbreviation;
  String get dateDayAbbreviation;
  String get placeholderDatePicker;
  String get placeholderColorPicker;
  String get buttonNext;
  String get buttonPrevious;
  String get searchPlaceholderCountry;
  String get emptyCountryList;
  String get placeholderTimePicker;
  String formatTimeOfDay(TimeOfDay time, {bool use24HourFormat = true, bool showSeconds = false});
  String get timeHour;
  String get timeMinute;
  String get timeSecond;
  String get timeAM;
  String get timePM;
  String get toastSnippetCopied;
  String get datePickerSelectYear;
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
  String get colorRed;
  String get colorGreen;
  String get colorBlue;
  String get colorAlpha;
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
  String get refreshTriggerPull;
  String get refreshTriggerRelease;
  String get refreshTriggerRefreshing;
  String get refreshTriggerComplete;
  String get colorPickerTabRecent;
  String get colorPickerTabRGB;
  String get colorPickerTabHSV;
  String get colorPickerTabHSL;
  String get colorPickerTabHEX;
  String get colorHue;
  String get colorSaturation;
  String get colorValue;
  String get colorLightness;
  String get dataTableColumns;
  String get dataTableNext;
  String get dataTablePrevious;
  String dataTableSelectedRows(int count, int total);
  List<DatePart> get datePartsOrder;
  String get durationDay;
  String get durationHour;
  String get durationMinute;
  String get durationSecond;
  String formatDuration(Duration duration, {bool showDays = true, bool showHours = true, bool showMinutes = true, bool showSeconds = true});
  String get placeholderDurationPicker;
}
```
