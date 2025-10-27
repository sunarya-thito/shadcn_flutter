---
title: "Example: components/input_otp/input_otp_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputOTPExample2 extends StatelessWidget {
  const InputOTPExample2({super.key});

  @override
  Widget build(BuildContext context) {
    // Pre-populate the first group using the characters from the string '123'.
    // InputOTP takes a list of code units for its initial value.
    return InputOTP(
      initialValue: '123'.codeUnits,
      children: [
        InputOTPChild.character(allowDigit: true),
        InputOTPChild.character(allowDigit: true),
        InputOTPChild.character(allowDigit: true),
        InputOTPChild.separator,
        InputOTPChild.character(allowDigit: true),
        InputOTPChild.character(allowDigit: true),
        InputOTPChild.character(allowDigit: true),
      ],
    );
  }
}

```
