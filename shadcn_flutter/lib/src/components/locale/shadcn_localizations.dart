import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ShadcnLocalizationsDelegate
    extends LocalizationsDelegate<ShadcnLocalizations> {
  static const ShadcnLocalizationsDelegate delegate =
      ShadcnLocalizationsDelegate();
  const ShadcnLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<ShadcnLocalizations> load(Locale locale) {
    return SynchronousFuture<ShadcnLocalizations>(
        DefaultShadcnLocalizations.instance);
  }

  @override
  bool shouldReload(ShadcnLocalizationsDelegate old) => false;
}

abstract class ShadcnLocalizations {
  static ShadcnLocalizations of(BuildContext context) {
    return Localizations.of<ShadcnLocalizations>(
            context, ShadcnLocalizations) ??
        DefaultShadcnLocalizations.instance;
  }

  const ShadcnLocalizations();

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

  String get commandSearch;
  String get commandEmpty;
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
  String formatDateTime(DateTime dateTime,
      {bool showDate = true, bool showTime = true, bool showSeconds = false});
  String get placeholderDatePicker;
  String get buttonPrevious;
  String get buttonNext;

  String get searchPlaceholderCountry;

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
}

class DefaultShadcnLocalizations extends ShadcnLocalizations {
  static const ShadcnLocalizations instance = DefaultShadcnLocalizations();

  const DefaultShadcnLocalizations();

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
      {bool showDate = true, bool showTime = true, bool showSeconds = false}) {
    String result = '';
    if (showDate) {
      result += '${getMonth(dateTime.month)} ${dateTime.day}, ${dateTime.year}';
    }
    if (showTime) {
      if (result.isNotEmpty) {
        result += ' ';
      }
      result += '${dateTime.hour}:${dateTime.minute}';
      if (showSeconds) {
        result += ':${dateTime.second}';
      }
    }
    return result;
  }

  @override
  String get placeholderDatePicker => 'Select a date';

  @override
  String get buttonNext => 'Next';

  @override
  String get buttonPrevious => 'Previous';

  @override
  String get searchPlaceholderCountry => 'Search country...';
}
