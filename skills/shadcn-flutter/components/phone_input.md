# PhoneInput

A specialized input widget for entering international phone numbers.

## Usage

### Phone Input Example
```dart
import 'package:docs/pages/docs/components/phone_input/phone_input_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class PhoneInputExample extends StatelessWidget {
  const PhoneInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'phone_input',
      description: 'A widget that allows users to input phone numbers.',
      displayName: 'Phone Input',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/phone_input/phone_input_example_1.dart',
          child: PhoneInputExample1(),
        ),
      ],
    );
  }
}

```

### Phone Input Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PhoneInputExample1 extends StatefulWidget {
  const PhoneInputExample1({super.key});

  @override
  State<PhoneInputExample1> createState() => _PhoneInputExample1State();
}

class _PhoneInputExample1State extends State<PhoneInputExample1> {
  PhoneNumber? _phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PhoneInput(
          // Preselect a country; phone parsing/formatting adapt accordingly.
          initialCountry: Country.indonesia,
          onChanged: (value) {
            setState(() {
              _phoneNumber = value;
            });
          },
        ),
        const Gap(24),
        Text(
          _phoneNumber?.value ?? '(No value)',
        ),
      ],
    );
  }
}

```

### Phone Input Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class PhoneInputTile extends StatelessWidget implements IComponentPage {
  const PhoneInputTile({super.key});

  @override
  String get title => 'Phone Input';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'phone_input',
      title: 'Phone Input',
      scale: 1.5,
      example: Card(
        child: const PhoneInput(
          initialValue: PhoneNumber(Country.indonesia, '81234567890'),
        ).withAlign(Alignment.topLeft),
      ).sized(height: 300),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `initialCountry` | `Country?` | The default country to display when no initial value is provided.  If both [initialCountry] and [initialValue] are null, defaults to United States. When [initialValue] is provided, its country takes precedence over this setting. |
| `initialValue` | `PhoneNumber?` | The initial phone number value including country and number.  When provided, both the country selector and number field are initialized with the values from this phone number. Takes precedence over [initialCountry] for country selection. |
| `onChanged` | `ValueChanged<PhoneNumber>?` | Callback invoked when the phone number changes.  Called whenever the user changes either the country selection or the phone number text. The callback receives a [PhoneNumber] object containing both the selected country and entered number. |
| `controller` | `TextEditingController?` | Optional text editing controller for the number input field.  When provided, this controller manages the text content of the phone number input field. If null, an internal controller is created and managed. |
| `filterPlusCode` | `bool` | Whether to filter out plus (+) symbols from input.  When true, plus symbols are automatically removed from user input since the country code already provides the international prefix. |
| `filterZeroCode` | `bool` | Whether to filter out leading zeros from input.  When true, leading zeros are automatically removed from the phone number to normalize the input format according to international standards. |
| `filterCountryCode` | `bool` | Whether to filter out country codes from input.  When true, prevents users from entering the country code digits manually since the country selector provides this information automatically. |
| `onlyNumber` | `bool` | Whether to allow only numeric characters in the input.  When true, restricts input to numeric characters only, removing any letters, symbols, or formatting characters that users might enter. |
| `countries` | `List<Country>?` | Optional list of countries to display in the country selector.  When provided, only these countries will be available for selection in the country picker popup. If null, all supported countries are available. |
| `searchPlaceholder` | `Widget?` | Widget displayed as placeholder in the country search field.  Appears in the search input at the top of the country selector popup to guide users on how to search for countries. |
