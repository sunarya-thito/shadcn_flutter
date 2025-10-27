---
title: "Example: components/phone_input/phone_input_example_1.dart"
description: "Component example"
---

Source preview
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
