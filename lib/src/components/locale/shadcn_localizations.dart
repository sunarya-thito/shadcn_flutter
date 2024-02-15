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
}

class DefaultShadcnLocalizations implements ShadcnLocalizations {
  static const ShadcnLocalizations instance = DefaultShadcnLocalizations();

  const DefaultShadcnLocalizations();

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
  String formLengthLessThan(int value) => 'Must be less than $value characters';

  @override
  String formLengthGreaterThan(int value) =>
      'Must be greater than $value characters';

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
}
