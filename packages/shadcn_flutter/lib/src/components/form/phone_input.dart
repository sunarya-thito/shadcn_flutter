import 'dart:async';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/services.dart';

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// [Validator] for validating a [PhoneNumber] input value.
///
/// Provides customizable error messages for invalid and empty phone numbers, and can be used with the form validation system to ensure that user input meets the required phone number format and completeness criteria.
class PhoneNumberValid extends Validator<PhoneNumber> {
  /// Custom error message for invalid phone numbers.
  final String? invalidMessage;

  /// Custom error message for empty phone number input.
  final String? emptyMessage;

  /// Creates a [PhoneNumberValid] validator with optional custom error messages.
  const PhoneNumberValid({
    this.invalidMessage,
    this.emptyMessage,
  });

  @override
  FutureOr<ValidationResult?> validate(
      BuildContext context, PhoneNumber? value, FormValidationMode lifecycle) {
    if (value == null) {
      var localizations = Localizations.of(context, ShadcnLocalizations);
      return InvalidResult(emptyMessage ?? localizations.formPhoneNumberEmpty,
          state: lifecycle);
    }
    if (value.country == null || value.number.isEmpty) {
      var localizations = Localizations.of(context, ShadcnLocalizations);
      return InvalidResult(
          invalidMessage ?? localizations.formPhoneNumberInvalid,
          state: lifecycle);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    return other is PhoneNumberValid &&
        other.emptyMessage == emptyMessage &&
        other.invalidMessage == invalidMessage;
  }

  @override
  int get hashCode => Object.hash(emptyMessage, invalidMessage);
}

/// Represents a phone number with country code information.
///
/// [PhoneNumber] combines a country (with dial code) and a phone number
/// string to create a complete international phone number.
///
/// Example:
/// ```dart
/// final phone = PhoneNumber(
///   Country(dialCode: '+1', code: 'US'),
///   '5551234567',
/// );
/// print(phone.fullNumber); // +15551234567
/// ```
class PhoneNumber {
  /// The country associated with this phone number.
  final Country? country;

  /// The phone number without the country code.
  final String number; // without country code

  /// Creates a [PhoneNumber] with the specified country and number.
  const PhoneNumber(this.country, this.number);

  /// Creates a copy with a new country
  PhoneNumber withCountry(Country? country) {
    return PhoneNumber(country, number);
  }

  /// Gets the complete phone number including country code.
  String get fullNumber =>
      country != null ? '${country!.dialCode}$number' : number;

  /// Gets the complete phone number with a plus sign prefix.
  String get fullCodeNumber =>
      country != null ? '+${country!.dialCode}$number' : number;

  /// Gets the full number or null if the number is empty.
  String? get value => number.isEmpty || country == null ? null : fullNumber;

  @override
  String toString() {
    return number.isEmpty ? '' : fullNumber;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneNumber &&
        other.country == country &&
        other.number == number;
  }

  @override
  int get hashCode {
    return country.hashCode ^ number.hashCode;
  }
}

/// Theme data for [PhoneInput].
class PhoneInputTheme extends ComponentThemeData {
  /// The padding of the [PhoneInput].
  final EdgeInsetsGeometry? padding;

  /// The border radius of the [PhoneInput].
  final BorderRadiusGeometry? borderRadius;

  /// The constraints of the country selector popup.
  final BoxConstraints? popupConstraints;

  /// The maximum width of the [PhoneInput].
  final double? maxWidth;

  /// The height of the flag.
  final double? flagHeight;

  /// The width of the flag.
  final double? flagWidth;

  /// The gap between the flag and the country code.
  final double? flagGap;

  /// The gap between the country code and the text field.
  final double? countryGap;

  /// The shape of the flag.
  final Shape? flagShape;

  /// Theme data for [PhoneInput].
  const PhoneInputTheme({
    this.padding,
    this.borderRadius,
    this.popupConstraints,
    this.maxWidth,
    this.flagHeight,
    this.flagWidth,
    this.flagGap,
    this.countryGap,
    this.flagShape,
  });

  /// Creates a copy of this [PhoneInputTheme] with the given values overridden.
  PhoneInputTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<BoxConstraints?>? popupConstraints,
    ValueGetter<double?>? maxWidth,
    ValueGetter<double?>? flagHeight,
    ValueGetter<double?>? flagWidth,
    ValueGetter<double?>? flagGap,
    ValueGetter<double?>? countryGap,
    ValueGetter<Shape?>? flagShape,
  }) {
    return PhoneInputTheme(
      padding: padding != null ? padding() : this.padding,
      borderRadius: borderRadius != null ? borderRadius() : this.borderRadius,
      popupConstraints:
          popupConstraints != null ? popupConstraints() : this.popupConstraints,
      maxWidth: maxWidth != null ? maxWidth() : this.maxWidth,
      flagHeight: flagHeight != null ? flagHeight() : this.flagHeight,
      flagWidth: flagWidth != null ? flagWidth() : this.flagWidth,
      flagGap: flagGap != null ? flagGap() : this.flagGap,
      countryGap: countryGap != null ? countryGap() : this.countryGap,
      flagShape: flagShape != null ? flagShape() : this.flagShape,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneInputTheme &&
        other.padding == padding &&
        other.borderRadius == borderRadius &&
        other.popupConstraints == popupConstraints &&
        other.maxWidth == maxWidth &&
        other.flagHeight == flagHeight &&
        other.flagWidth == flagWidth &&
        other.flagGap == flagGap &&
        other.countryGap == countryGap &&
        other.flagShape == flagShape;
  }

  @override
  int get hashCode => Object.hash(
        padding,
        borderRadius,
        popupConstraints,
        maxWidth,
        flagHeight,
        flagWidth,
        flagGap,
        countryGap,
        flagShape,
      );

  @override
  String toString() {
    return 'PhoneInputTheme(padding: $padding, borderRadius: $borderRadius, popupConstraints: $popupConstraints, maxWidth: $maxWidth, flagHeight: $flagHeight, flagWidth: $flagWidth, flagGap: $flagGap, countryGap: $countryGap, flagShape: $flagShape)';
  }
}

/// A specialized input widget for entering international phone numbers.
///
/// This widget provides a comprehensive phone number input interface with
/// country selection, automatic formatting, and validation. It displays a
/// country flag, country code, and a text field for the phone number,
/// handling the complexities of international phone number formats.
///
/// The component automatically filters input to ensure only valid phone
/// number characters are entered, and provides a searchable country
/// selector popup for easy country selection. It integrates with the form
/// system to provide phone number validation and data collection.
///
/// Example:
/// ```dart
/// PhoneInput(
///   initialCountry: Country.unitedStates,
///   onChanged: (phoneNumber) {
///     print('Phone: ${phoneNumber.fullNumber}');
///     print('Country: ${phoneNumber.country.name}');
///   },
///   searchPlaceholder: Text('Search countries...'),
/// );
/// ```
class PhoneInput extends StatefulWidget {
  /// The default country to display when no initial value is provided.
  ///
  /// If both [initialCountry] and [initialValue] are null, defaults to
  /// United States. When [initialValue] is provided, its country takes
  /// precedence over this setting.
  final Country? initialCountry;

  /// The initial phone number value including country and number.
  ///
  /// When provided, both the country selector and number field are
  /// initialized with the values from this phone number. Takes precedence
  /// over [initialCountry] for country selection.
  final PhoneNumber? initialValue;

  /// Callback invoked when the phone number changes.
  ///
  /// Called whenever the user changes either the country selection or
  /// the phone number text. The callback receives a [PhoneNumber] object
  /// containing both the selected country and entered number.
  final ValueChanged<PhoneNumber?>? onChanged;

  /// Optional text editing controller for the number input field.
  ///
  /// When provided, this controller manages the text content of the phone
  /// number input field. If null, an internal controller is created and managed.
  final TextEditingController? controller;

  /// Whether to filter out plus (+) symbols from input.
  ///
  /// When true, plus symbols are automatically removed from user input
  /// since the country code already provides the international prefix.
  @Deprecated('Plus code is now mandatory')
  final bool filterPlusCode;

  /// Whether to filter out leading zeros from input.
  ///
  /// When true, leading zeros are automatically removed from the phone number
  /// to normalize the input format according to international standards.
  @Deprecated('Plus code is now mandatory, leading zero is not a valid format')
  final bool filterZeroCode;

  /// Whether to filter out country codes from input.
  ///
  /// When true, prevents users from entering the country code digits manually
  /// since the country selector provides this information automatically.
  @Deprecated('Country code is now determined from input')
  final bool filterCountryCode;

  /// Whether to allow only numeric characters in the input.
  ///
  /// When true, restricts input to numeric characters only, removing
  /// any letters, symbols, or formatting characters that users might enter.
  final bool onlyNumber;

  /// Optional list of countries to display in the country selector.
  ///
  /// When provided, only these countries will be available for selection
  /// in the country picker popup. If null, all supported countries are available.
  final List<Country>? countries;

  /// Widget displayed as placeholder in the country search field.
  ///
  /// Appears in the search input at the top of the country selector popup
  /// to guide users on how to search for countries.
  final Widget? searchPlaceholder;

  /// Creates a [PhoneInput] widget.
  ///
  /// The widget can be initialized with a specific country or complete phone
  /// number. Various filtering options control how user input is processed
  /// to ensure valid phone number format.
  ///
  /// Parameters:
  /// - [initialCountry] (Country?, optional): Default country when no initial value provided
  /// - [initialValue] (PhoneNumber?, optional): Complete initial phone number with country
  /// - [onChanged] (`ValueChanged<PhoneNumber>?`, optional): Callback for phone number changes
  /// - [controller] (TextEditingController?, optional): Controller for the number input field
  /// - [filterPlusCode] (bool, default: true): Whether to filter out plus symbols
  /// - [filterZeroCode] (bool, default: true): Whether to filter out leading zeros
  /// - [filterCountryCode] (bool, default: true): Whether to filter out country codes
  /// - [onlyNumber] (bool, default: true): Whether to allow only numeric input
  /// - [countries] (`List<Country>?`, optional): Specific countries to show in selector
  /// - [searchPlaceholder] (Widget?, optional): Placeholder for country search field
  ///
  /// Example:
  /// ```dart
  /// PhoneInput(
  ///   initialCountry: Country.canada,
  ///   filterPlusCode: true,
  ///   onChanged: (phone) => _validatePhoneNumber(phone),
  /// );
  /// ```
  const PhoneInput({
    super.key,
    this.initialCountry,
    this.initialValue,
    this.onChanged,
    this.controller,
    @Deprecated('Plus code is now mandatory') this.filterPlusCode = true,
    @Deprecated(
        'Plus code is now mandatory, leading zero is not a valid format')
    this.filterZeroCode = true,
    @Deprecated('Country code is now determined from input')
    this.filterCountryCode = true,
    this.onlyNumber = true,
    this.countries,
    this.searchPlaceholder,
  });

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput>
    with FormValueSupplier<PhoneNumber, PhoneInput> {
  late TextEditingController _controller;
  late bool _updatingPhone = false;
  late Country _lastValidCountry;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        TextEditingController(text: widget.initialValue?.number);
    _lastValidCountry = widget.initialValue?.country ??
        widget.initialCountry ??
        Country.unitedStates;
    _updateCountry(_lastValidCountry);
    formValue = value;
    _controller.addListener(_dispatchChanged);
  }

  void _updateCountry(Country country) {
    if (_updatingPhone) return;
    _updatingPhone = true;
    final textValue = _controller.value;
    var selection = textValue.selection;
    // get the plain number
    String number = textValue.text;
    String expectedDialCode = _lastValidCountry.dialCode;
    if (number.startsWith(expectedDialCode)) {
      number = number.substring(expectedDialCode.length);
      selection = selection.copyWith(
        baseOffset: selection.baseOffset - expectedDialCode.length,
        extentOffset: selection.extentOffset - expectedDialCode.length,
      );
    } else if (number.startsWith('+')) {
      // unknown code, but lets remove the + first
      number = number.substring(1);
      selection = selection.copyWith(
        baseOffset: selection.baseOffset - 1,
        extentOffset: selection.extentOffset - 1,
      );
    }
    String newDialCode = country.dialCode;
    number = '$newDialCode$number';
    selection = selection.copyWith(
      baseOffset: selection.baseOffset + newDialCode.length,
      extentOffset: selection.extentOffset + newDialCode.length,
    );
    _controller.value = TextEditingValue(
      text: number,
      selection: selection,
    );
    _lastValidCountry = country;
    _updatingPhone = false;
  }

  Country? _findByCode(String phone) {
    if (phone.startsWith('+')) {
      phone = phone.substring(1);
    }
    List<Country> sortedCountries = Country.values.toList()
      ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
    // Sort countries by dial code length in descending order to ensure the longest match is found first
    for (final country in sortedCountries) {
      var dialCode = country.dialCode;
      // sanitize
      if (dialCode.startsWith('+')) {
        dialCode = dialCode.substring(1);
      }
      if (phone.startsWith(dialCode)) {
        return country;
      }
    }
    return null;
  }

  @override
  void didUpdateWidget(covariant PhoneInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_dispatchChanged);
      _controller = widget.controller ?? TextEditingController();
      _controller.addListener(_dispatchChanged);
    }
  }

  void _dispatchChanged() {
    setState(() {
      Country? detectedCountry = _findByCode(_controller.text);
      if (detectedCountry != null) {
        final validCountry = detectedCountry;
        if (validCountry.dialCode != _lastValidCountry.dialCode) {
          // some country have same dialCode (e.g. US and Canada),
          // so we use the preferred country
          _lastValidCountry = validCountry;
        } else {
          detectedCountry = _lastValidCountry;
        }
      }
      widget.onChanged?.call(value?.withCountry(detectedCountry));
      formValue = value;
    });
  }

  PhoneNumber? get value {
    var text = _controller.text;
    String dialCode = _lastValidCountry.dialCode;
    if (text.startsWith(dialCode)) {
      text = text.substring(dialCode.length);
    }
    return PhoneNumber(_lastValidCountry, text);
  }

  bool _filterCountryCode(Country country, String text) {
    return country.name.toLowerCase().contains(text) ||
        country.dialCode.contains(text) ||
        country.code.toLowerCase().contains(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final componentTheme = ComponentTheme.maybeOf<PhoneInputTheme>(context);
    return IntrinsicHeight(
      child: ButtonGroup.horizontal(
        children: [
          ButtonGroupItem(
            child: Select<Country>(
              padding: styleValue(
                defaultValue: EdgeInsets.all(theme.scaling * 8),
                themeValue: componentTheme?.padding,
              ),
              expandIcon: null,
              value: _lastValidCountry,
              borderRadius: styleValue(
                defaultValue: BorderRadius.only(
                  topLeft: theme.radiusMdRadius,
                  bottomLeft: theme.radiusMdRadius,
                ),
                themeValue: componentTheme?.borderRadius,
              ),
              popoverAlignment: Alignment.topLeft,
              popoverAnchorAlignment: Alignment.bottomLeft,
              popupWidthConstraint: PopoverConstraint.flexible,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _updateCountry(value);
                  });
                }
              },
              itemBuilder: (context, item) {
                return CountryFlag.fromCountryCode(
                  item.code,
                  theme: ImageTheme(
                    shape: styleValue(
                      defaultValue: RoundedRectangle(
                        theme.radiusSm,
                      ),
                      themeValue: componentTheme?.flagShape,
                    ),
                    height: styleValue(
                      defaultValue: theme.scaling * 18,
                      themeValue: componentTheme?.flagHeight,
                    ),
                    width: styleValue(
                      defaultValue: theme.scaling * 24,
                      themeValue: componentTheme?.flagWidth,
                    ),
                  ),
                );
              },
              popupConstraints: styleValue(
                defaultValue: BoxConstraints(
                  maxWidth: 250 * theme.scaling,
                  maxHeight: 300 * theme.scaling,
                ),
                themeValue: componentTheme?.popupConstraints,
              ),
              popup: SelectPopup.builder(
                builder: (context, searchQuery) {
                  return SelectItemList(children: [
                    for (final country in widget.countries ?? Country.values)
                      if (searchQuery == null ||
                          _filterCountryCode(country, searchQuery))
                        SelectItemButton(
                          value: country,
                          child: Row(
                            children: [
                              CountryFlag.fromCountryCode(
                                country.code,
                                theme: ImageTheme(
                                  shape: styleValue(
                                    defaultValue: RoundedRectangle(
                                      theme.radiusSm,
                                    ),
                                    themeValue: componentTheme?.flagShape,
                                  ),
                                  height: styleValue(
                                    defaultValue: theme.scaling * 18,
                                    themeValue: componentTheme?.flagHeight,
                                  ),
                                  width: styleValue(
                                    defaultValue: theme.scaling * 24,
                                    themeValue: componentTheme?.flagWidth,
                                  ),
                                ),
                              ),
                              Gap(
                                styleValue(
                                  defaultValue: theme.scaling * 8,
                                  themeValue: componentTheme?.flagGap,
                                ),
                              ),
                              Expanded(child: Text(country.name)),
                              Gap(
                                styleValue(
                                  defaultValue: 16 * theme.scaling,
                                  themeValue: componentTheme?.countryGap,
                                ),
                              ),
                              Text(country.dialCode).muted(),
                            ],
                          ),
                        ),
                  ]);
                },
              ).asBuilder,
            ),
          ),
          ButtonGroupFlexible(
            child: TextField(
              controller: _controller,
              autofillHints: const [AutofillHints.telephoneNumber],
              keyboardType: widget.onlyNumber ? TextInputType.phone : null,
              inputFormatters: [
                if (widget.onlyNumber) FilteringTextInputFormatter.digitsOnly,
                _AlwaysPrefixedPlus(),
              ],
              borderRadius: styleValue(
                defaultValue: BorderRadius.only(
                  topRight: theme.radiusMdRadius,
                  bottomRight: theme.radiusMdRadius,
                ),
                themeValue: componentTheme?.borderRadius,
              ),
              initialValue: widget.initialValue?.number,
            ),
          )
        ],
      ),
    );
  }

  @override
  void didReplaceFormValue(PhoneNumber value) {
    _controller.text = value.toString();
  }
}

class _AlwaysPrefixedPlus extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    if (text.startsWith('+')) {
      return newValue;
    } else {
      return TextEditingValue(
        text: '+$text',
        selection: newValue.selection.copyWith(
          baseOffset: newValue.selection.baseOffset + 1,
          extentOffset: newValue.selection.extentOffset + 1,
        ),
      );
    }
  }
}
