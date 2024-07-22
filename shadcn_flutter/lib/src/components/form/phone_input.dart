import 'package:country_flags/country_flags.dart';
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

  const PhoneInput({
    super.key,
    this.initialCountry,
    this.initialValue,
    this.onChanged,
    this.controller,
    this.filterPlusCode = true,
    this.filterZeroCode = true,
    this.filterCountryCode = true,
  });

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> with FormValueSupplier {
  late Country _country;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _country = widget.initialCountry ??
        widget.initialValue?.country ??
        Country.unitedStates;
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_dispatchChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reportNewFormValue(
      value,
      (value) {
        _country = value.country;
        _controller.text = value.number;
        _dispatchChanged();
        setState(() {});
      },
    );
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
    reportNewFormValue(value, (value) {
      _country = value.country;
      _controller.text = value.number;
      _dispatchChanged();
      setState(() {});
    });
  }

  PhoneNumber get value {
    var text = _controller.text;
    if (widget.filterPlusCode && text.startsWith('+')) {
      text = text.substring(_country.dialCode.length);
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
            padding:
                const EdgeInsets.only(top: 8, left: 8, bottom: 8, right: 4),
            searchPlaceholder: localization.searchPlaceholderCountry,
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
                padding: const EdgeInsets.all(16),
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
                    height: 18,
                    width: 24,
                  ),
                  gap(8),
                  Text(item.dialCode),
                ],
              );
            },
            popupConstraints: const BoxConstraints(
              maxWidth: 250,
              maxHeight: 300,
            ),
            children: [
              for (final country in Country.values)
                SelectItemButton(
                  value: country,
                  child: Row(
                    children: [
                      CountryFlag.fromCountryCode(country.code,
                          height: 18,
                          width: 24,
                          shape: RoundedRectangle(theme.radiusSm)),
                      gap(8),
                      Expanded(child: Text(country.name)),
                      gap(16),
                      Text(country.dialCode).muted(),
                    ],
                  ),
                ),
            ],
          ),
          LimitedBox(
            maxWidth: 200,
            child: TextField(
              controller: _controller,
              autofillHints: const [AutofillHints.telephoneNumber],
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
}
