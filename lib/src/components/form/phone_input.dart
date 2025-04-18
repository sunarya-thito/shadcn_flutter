import 'package:country_flags/country_flags.dart';
import 'package:flutter/services.dart';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class PhoneNumber {
  final Country country;
  final String number; // without country code

  const PhoneNumber(this.country, this.number);

  String get fullNumber => '${country.dialCode}$number';

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

class PhoneInput extends StatefulWidget {
  final Country? initialCountry;
  final PhoneNumber? initialValue;
  final ValueChanged<PhoneNumber>? onChanged;
  final TextEditingController? controller;
  final bool filterPlusCode;
  final bool filterZeroCode;
  final bool filterCountryCode;
  final bool onlyNumber;
  final List<Country>? countries;
  final Widget? searchPlaceholder;

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
    _controller = widget.controller ?? TextEditingController();
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
