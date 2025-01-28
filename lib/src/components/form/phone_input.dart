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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = ShadcnLocalizations.of(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Select<Country>(
            padding: EdgeInsets.only(
                top: theme.scaling * 8,
                left: theme.scaling * 8,
                bottom: theme.scaling * 8,
                right: theme.scaling * 4),
            searchPlaceholder: widget.searchPlaceholder ??
                Text(localization.searchPlaceholderCountry),
            searchFilter: (item, query) {
              query = query.toLowerCase();
              var searchScore = item.name.toLowerCase().contains(query) ||
                      item.dialCode.contains(query) ||
                      item.code.toLowerCase().contains(query)
                  ? 1
                  : 0;
              return searchScore;
            },
            emptyBuilder: (context) {
              return Container(
                padding: EdgeInsets.all(theme.scaling * 16),
                child: Text(
                  localization.emptyCountryList,
                  textAlign: TextAlign.center,
                ).small().muted(),
              );
            },
            value: _country,
            borderRadius: BorderRadius.only(
              topLeft: theme.radiusMdRadius,
              bottomLeft: theme.radiusMdRadius,
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
                    shape: RoundedRectangle(
                      theme.radiusSm,
                    ),
                    height: theme.scaling * 18,
                    width: theme.scaling * 24,
                  ),
                  Gap(theme.scaling * 8),
                  Text(item.dialCode),
                ],
              );
            },
            popupConstraints: BoxConstraints(
              maxWidth: 250 * theme.scaling,
              maxHeight: 300 * theme.scaling,
            ),
            children: [
              for (final country in widget.countries ?? Country.values)
                SelectItemButton(
                  value: country,
                  child: Row(
                    children: [
                      CountryFlag.fromCountryCode(country.code,
                          height: theme.scaling * 18,
                          width: theme.scaling * 24,
                          shape: RoundedRectangle(theme.radiusSm)),
                      Gap(8 * theme.scaling),
                      Expanded(child: Text(country.name)),
                      Gap(16 * theme.scaling),
                      Text(country.dialCode).muted(),
                    ],
                  ),
                ),
            ],
          ),
          LimitedBox(
            maxWidth: 200 * theme.scaling,
            child: TextField(
              controller: _controller,
              autofillHints: const [AutofillHints.telephoneNumber],
              keyboardType: widget.onlyNumber ? TextInputType.phone : null,
              inputFormatters: [
                if (widget.onlyNumber) FilteringTextInputFormatter.digitsOnly,
              ],
              borderRadius: BorderRadius.only(
                topRight: theme.radiusMdRadius,
                bottomRight: theme.radiusMdRadius,
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
