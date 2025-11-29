import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'shadcn_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ShadcnLocalizations
/// returned by `ShadcnLocalizations.of(context)`.
///
/// Applications need to include `ShadcnLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'locale/shadcn_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ShadcnLocalizations.localizationsDelegates,
///   supportedLocales: ShadcnLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ShadcnLocalizations.supportedLocales
/// property.
abstract class ShadcnLocalizations {
  ShadcnLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ShadcnLocalizations of(BuildContext context) {
    return Localizations.of<ShadcnLocalizations>(context, ShadcnLocalizations)!;
  }

  static const LocalizationsDelegate<ShadcnLocalizations> delegate =
      _ShadcnLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @formNotEmpty.
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get formNotEmpty;

  /// No description provided for @invalidValue.
  ///
  /// In en, this message translates to:
  /// **'Invalid value'**
  String get invalidValue;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @invalidURL.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get invalidURL;

  /// No description provided for @formLessThan.
  ///
  /// In en, this message translates to:
  /// **'Must be less than {value}'**
  String formLessThan(double value);

  /// No description provided for @formGreaterThan.
  ///
  /// In en, this message translates to:
  /// **'Must be greater than {value}'**
  String formGreaterThan(double value);

  /// No description provided for @formLessThanOrEqualTo.
  ///
  /// In en, this message translates to:
  /// **'Must be less than or equal to {value}'**
  String formLessThanOrEqualTo(double value);

  /// No description provided for @formGreaterThanOrEqualTo.
  ///
  /// In en, this message translates to:
  /// **'Must be greater than or equal to {value}'**
  String formGreaterThanOrEqualTo(double value);

  /// No description provided for @formBetweenInclusively.
  ///
  /// In en, this message translates to:
  /// **'Must be between {min} and {max} (inclusive)'**
  String formBetweenInclusively(double min, double max);

  /// No description provided for @formBetweenExclusively.
  ///
  /// In en, this message translates to:
  /// **'Must be between {min} and {max} (exclusive)'**
  String formBetweenExclusively(double min, double max);

  /// No description provided for @formLengthLessThan.
  ///
  /// In en, this message translates to:
  /// **'Must be at least {value} characters'**
  String formLengthLessThan(int value);

  /// No description provided for @formLengthGreaterThan.
  ///
  /// In en, this message translates to:
  /// **'Must be at most {value} characters'**
  String formLengthGreaterThan(int value);

  /// No description provided for @formPasswordDigits.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least one digit'**
  String get formPasswordDigits;

  /// No description provided for @formPasswordLowercase.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least one lowercase letter'**
  String get formPasswordLowercase;

  /// No description provided for @formPasswordUppercase.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least one uppercase letter'**
  String get formPasswordUppercase;

  /// No description provided for @formPasswordSpecial.
  ///
  /// In en, this message translates to:
  /// **'Must contain at least one special character'**
  String get formPasswordSpecial;

  /// No description provided for @commandSearch.
  ///
  /// In en, this message translates to:
  /// **'Type a command or search...'**
  String get commandSearch;

  /// No description provided for @commandEmpty.
  ///
  /// In en, this message translates to:
  /// **'No results found.'**
  String get commandEmpty;

  /// No description provided for @datePickerSelectYear.
  ///
  /// In en, this message translates to:
  /// **'Select a year'**
  String get datePickerSelectYear;

  /// No description provided for @abbreviatedMonday.
  ///
  /// In en, this message translates to:
  /// **'Mo'**
  String get abbreviatedMonday;

  /// No description provided for @abbreviatedTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tu'**
  String get abbreviatedTuesday;

  /// No description provided for @abbreviatedWednesday.
  ///
  /// In en, this message translates to:
  /// **'We'**
  String get abbreviatedWednesday;

  /// No description provided for @abbreviatedThursday.
  ///
  /// In en, this message translates to:
  /// **'Th'**
  String get abbreviatedThursday;

  /// No description provided for @abbreviatedFriday.
  ///
  /// In en, this message translates to:
  /// **'Fr'**
  String get abbreviatedFriday;

  /// No description provided for @abbreviatedSaturday.
  ///
  /// In en, this message translates to:
  /// **'Sa'**
  String get abbreviatedSaturday;

  /// No description provided for @abbreviatedSunday.
  ///
  /// In en, this message translates to:
  /// **'Su'**
  String get abbreviatedSunday;

  /// No description provided for @monthJanuary.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get monthJanuary;

  /// No description provided for @monthFebruary.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get monthFebruary;

  /// No description provided for @monthMarch.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get monthMarch;

  /// No description provided for @monthApril.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get monthApril;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJune.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get monthJune;

  /// No description provided for @monthJuly.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get monthJuly;

  /// No description provided for @monthAugust.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get monthAugust;

  /// No description provided for @monthSeptember.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get monthSeptember;

  /// No description provided for @monthOctober.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get monthOctober;

  /// No description provided for @monthNovember.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get monthNovember;

  /// No description provided for @monthDecember.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get monthDecember;

  /// No description provided for @abbreviatedJanuary.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get abbreviatedJanuary;

  /// No description provided for @abbreviatedFebruary.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get abbreviatedFebruary;

  /// No description provided for @abbreviatedMarch.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get abbreviatedMarch;

  /// No description provided for @abbreviatedApril.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get abbreviatedApril;

  /// No description provided for @abbreviatedMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get abbreviatedMay;

  /// No description provided for @abbreviatedJune.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get abbreviatedJune;

  /// No description provided for @abbreviatedJuly.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get abbreviatedJuly;

  /// No description provided for @abbreviatedAugust.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get abbreviatedAugust;

  /// No description provided for @abbreviatedSeptember.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get abbreviatedSeptember;

  /// No description provided for @abbreviatedOctober.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get abbreviatedOctober;

  /// No description provided for @abbreviatedNovember.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get abbreviatedNovember;

  /// No description provided for @abbreviatedDecember.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get abbreviatedDecember;

  /// No description provided for @buttonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get buttonCancel;

  /// No description provided for @buttonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get buttonSave;

  /// No description provided for @timeHour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get timeHour;

  /// No description provided for @timeMinute.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get timeMinute;

  /// No description provided for @timeSecond.
  ///
  /// In en, this message translates to:
  /// **'Second'**
  String get timeSecond;

  /// No description provided for @timeAM.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get timeAM;

  /// No description provided for @timePM.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get timePM;

  /// No description provided for @colorRed.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get colorRed;

  /// No description provided for @colorGreen.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get colorGreen;

  /// No description provided for @colorBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get colorBlue;

  /// No description provided for @colorAlpha.
  ///
  /// In en, this message translates to:
  /// **'Alpha'**
  String get colorAlpha;

  /// No description provided for @colorHue.
  ///
  /// In en, this message translates to:
  /// **'Hue'**
  String get colorHue;

  /// No description provided for @colorSaturation.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get colorSaturation;

  /// No description provided for @colorValue.
  ///
  /// In en, this message translates to:
  /// **'Val'**
  String get colorValue;

  /// No description provided for @colorLightness.
  ///
  /// In en, this message translates to:
  /// **'Lum'**
  String get colorLightness;

  /// No description provided for @menuCut.
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get menuCut;

  /// No description provided for @menuCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get menuCopy;

  /// No description provided for @menuPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get menuPaste;

  /// No description provided for @menuSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get menuSelectAll;

  /// No description provided for @menuUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get menuUndo;

  /// No description provided for @menuRedo.
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get menuRedo;

  /// No description provided for @menuDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get menuDelete;

  /// No description provided for @menuShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get menuShare;

  /// No description provided for @menuSearchWeb.
  ///
  /// In en, this message translates to:
  /// **'Search Web'**
  String get menuSearchWeb;

  /// No description provided for @menuLiveTextInput.
  ///
  /// In en, this message translates to:
  /// **'Live Text Input'**
  String get menuLiveTextInput;

  /// No description provided for @placeholderDatePicker.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get placeholderDatePicker;

  /// No description provided for @placeholderTimePicker.
  ///
  /// In en, this message translates to:
  /// **'Select a time'**
  String get placeholderTimePicker;

  /// No description provided for @placeholderColorPicker.
  ///
  /// In en, this message translates to:
  /// **'Select a color'**
  String get placeholderColorPicker;

  /// No description provided for @buttonPrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get buttonPrevious;

  /// No description provided for @buttonNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get buttonNext;

  /// No description provided for @refreshTriggerPull.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh'**
  String get refreshTriggerPull;

  /// No description provided for @refreshTriggerRelease.
  ///
  /// In en, this message translates to:
  /// **'Release to refresh'**
  String get refreshTriggerRelease;

  /// No description provided for @refreshTriggerRefreshing.
  ///
  /// In en, this message translates to:
  /// **'Refreshing...'**
  String get refreshTriggerRefreshing;

  /// No description provided for @refreshTriggerComplete.
  ///
  /// In en, this message translates to:
  /// **'Refresh complete'**
  String get refreshTriggerComplete;

  /// No description provided for @colorPickerTabRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get colorPickerTabRecent;

  /// No description provided for @colorPickerTabRGB.
  ///
  /// In en, this message translates to:
  /// **'RGB'**
  String get colorPickerTabRGB;

  /// No description provided for @colorPickerTabHSV.
  ///
  /// In en, this message translates to:
  /// **'HSV'**
  String get colorPickerTabHSV;

  /// No description provided for @colorPickerTabHSL.
  ///
  /// In en, this message translates to:
  /// **'HSL'**
  String get colorPickerTabHSL;

  /// No description provided for @colorPickerTabHEX.
  ///
  /// In en, this message translates to:
  /// **'HEX'**
  String get colorPickerTabHEX;

  /// No description provided for @commandMoveUp.
  ///
  /// In en, this message translates to:
  /// **'Move Up'**
  String get commandMoveUp;

  /// No description provided for @commandMoveDown.
  ///
  /// In en, this message translates to:
  /// **'Move Down'**
  String get commandMoveDown;

  /// No description provided for @commandActivate.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get commandActivate;

  /// No description provided for @dataTableSelectedRows.
  ///
  /// In en, this message translates to:
  /// **'{count} of {total} row(s) selected.'**
  String dataTableSelectedRows(int count, int total);

  /// No description provided for @dataTableNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get dataTableNext;

  /// No description provided for @dataTablePrevious.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get dataTablePrevious;

  /// No description provided for @dataTableColumns.
  ///
  /// In en, this message translates to:
  /// **'Columns'**
  String get dataTableColumns;

  /// No description provided for @timeDaysAbbreviation.
  ///
  /// In en, this message translates to:
  /// **'DD'**
  String get timeDaysAbbreviation;

  /// No description provided for @timeHoursAbbreviation.
  ///
  /// In en, this message translates to:
  /// **'HH'**
  String get timeHoursAbbreviation;

  /// No description provided for @timeMinutesAbbreviation.
  ///
  /// In en, this message translates to:
  /// **'MM'**
  String get timeMinutesAbbreviation;

  /// No description provided for @timeSecondsAbbreviation.
  ///
  /// In en, this message translates to:
  /// **'SS'**
  String get timeSecondsAbbreviation;

  /// No description provided for @placeholderDurationPicker.
  ///
  /// In en, this message translates to:
  /// **'Select a duration'**
  String get placeholderDurationPicker;

  /// No description provided for @durationDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get durationDay;

  /// No description provided for @durationHour.
  ///
  /// In en, this message translates to:
  /// **'Hour'**
  String get durationHour;

  /// No description provided for @durationMinute.
  ///
  /// In en, this message translates to:
  /// **'Minute'**
  String get durationMinute;

  /// No description provided for @durationSecond.
  ///
  /// In en, this message translates to:
  /// **'Second'**
  String get durationSecond;
}

class _ShadcnLocalizationsDelegate
    extends LocalizationsDelegate<ShadcnLocalizations> {
  const _ShadcnLocalizationsDelegate();

  @override
  Future<ShadcnLocalizations> load(Locale locale) {
    return SynchronousFuture<ShadcnLocalizations>(
        lookupShadcnLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_ShadcnLocalizationsDelegate old) => false;
}

ShadcnLocalizations lookupShadcnLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return ShadcnLocalizationsEn();
  }

  throw FlutterError(
      'ShadcnLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
