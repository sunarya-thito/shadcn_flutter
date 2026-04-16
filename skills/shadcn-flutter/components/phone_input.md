# PhoneNumber

Represents a phone number with country code information.

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
| `country` | `Country` | The country associated with this phone number. |
| `number` | `String` | The phone number without the country code. |
