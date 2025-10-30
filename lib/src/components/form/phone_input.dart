import 'package:country_flags/country_flags.dart';
import 'package:flutter/services.dart';

import 'package:shadcn_flutter/shadcn_flutter.dart';

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
  final Country country;
  
  /// The phone number without the country code.
  final String number; // without country code

  /// Creates a [PhoneNumber] with the specified country and number.
  const PhoneNumber(this.country, this.number);

  /// Gets the complete phone number including country code.
  String get fullNumber => '${country.dialCode}$number';

  /// Gets the full number or null if the number is empty.
  String? get value => number.isEmpty ? null : fullNumber;

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
class PhoneInputTheme {
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
  final ValueChanged<PhoneNumber>? onChanged;

  /// Optional text editing controller for the number input field.
  ///
  /// When provided, this controller manages the text content of the phone
  /// number input field. If null, an internal controller is created and managed.
  final TextEditingController? controller;

  /// Whether to filter out plus (+) symbols from input.
  ///
  /// When true, plus symbols are automatically removed from user input
  /// since the country code already provides the international prefix.
  final bool filterPlusCode;

  /// Whether to filter out leading zeros from input.
  ///
  /// When true, leading zeros are automatically removed from the phone number
  /// to normalize the input format according to international standards.
  final bool filterZeroCode;

  /// Whether to filter out country codes from input.
  ///
  /// When true, prevents users from entering the country code digits manually
  /// since the country selector provides this information automatically.
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
    this.filterPlusCode = true,
    this.filterZeroCode = true,
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
  late Country _country;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _country = widget.initialCountry ??
        widget.initialValue?.country ??
        Country.unitedStates;
    _controller = widget.controller ??
        TextEditingController(text: widget.initialValue?.number);
    formValue = value;
    _controller.addListener(_dispatchChanged);
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
    widget.onChanged?.call(value);
    formValue = value;
  }

  PhoneNumber get value {
    var text = _controller.text;
    if (widget.filterPlusCode && text.startsWith(_country.dialCode)) {
      text = text.substring(_country.dialCode.length);
    } else if (widget.filterPlusCode && text.startsWith('+')) {
      text = text.substring(1);
    } else if (widget.filterZeroCode && text.startsWith('0')) {
      text = text.substring(1);
    } else if (widget.filterCountryCode &&
        text.startsWith(_country.dialCode.substring(1))) {
      // e.g. 628123456788 (indonesia) would be 8123456788
      text = text.substring(_country.dialCode.length - 1);
    }
    return PhoneNumber(_country, text);
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Select<Country>(
            padding: styleValue(
              defaultValue: EdgeInsets.only(
                  top: theme.scaling * 8,
                  left: theme.scaling * 8,
                  bottom: theme.scaling * 8,
                  right: theme.scaling * 4),
              themeValue: componentTheme?.padding,
            ),
            // searchPlaceholder: widget.searchPlaceholder ??
            //     Text(localization.searchPlaceholderCountry),
            // searchFilter: (item, query) {
            //   query = query.toLowerCase();
            //   var searchScore = item.name.toLowerCase().contains(query) ||
            //           item.dialCode.contains(query) ||
            //           item.code.toLowerCase().contains(query)
            //       ? 1
            //       : 0;
            //   return searchScore;
            // },
            // emptyBuilder: (context) {
            //   return Container(
            //     padding: EdgeInsets.all(theme.scaling * 16),
            //     child: Text(
            //       localization.emptyCountryList,
            //       textAlign: TextAlign.center,
            //     ).small().muted(),
            //   );
            // },
            value: _country,
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
                  _country = value;
                  _dispatchChanged();
                });
              }
            },
            itemBuilder: (context, item) {
              return Row(
                children: [
                  CountryFlag.fromCountryCode(
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
                  ),
                  Gap(
                    styleValue(
                      defaultValue: theme.scaling * 8,
                      themeValue: componentTheme?.flagGap,
                    ),
                  ),
                  Text(item.dialCode),
                ],
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
          LimitedBox(
            maxWidth: styleValue(
              defaultValue: 200 * theme.scaling,
              themeValue: componentTheme?.maxWidth,
            ),
            child: TextField(
              controller: _controller,
              autofillHints: const [AutofillHints.telephoneNumber],
              keyboardType: widget.onlyNumber ? TextInputType.phone : null,
              inputFormatters: [
                if (widget.onlyNumber) FilteringTextInputFormatter.digitsOnly,
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
