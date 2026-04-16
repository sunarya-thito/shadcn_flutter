# InputOTPTheme

Theme data for customizing [InputOTP] widget appearance.

## Usage

### Input Otp Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/input_otp/input_otp_example_1.dart';
import 'package:docs/pages/docs/components/input_otp/input_otp_example_3.dart';
import 'package:docs/pages/docs/components/input_otp/input_otp_example_4.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'input_otp/input_otp_example_2.dart';

class InputOTPExample extends StatelessWidget {
  const InputOTPExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'input_otp',
      description:
          'Input OTP is a component that allows users to enter OTP code.',
      displayName: 'Input OTP',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/input_otp/input_otp_example_1.dart',
          child: InputOTPExample1(),
        ),
        WidgetUsageExample(
          title: 'Initial Value Example',
          path: 'lib/pages/docs/components/input_otp/input_otp_example_2.dart',
          child: InputOTPExample2(),
        ),
        WidgetUsageExample(
          title: 'Obscured Example',
          path: 'lib/pages/docs/components/input_otp/input_otp_example_3.dart',
          child: InputOTPExample3(),
        ),
        WidgetUsageExample(
          title: 'Upper Case Alphabet Example',
          path: 'lib/pages/docs/components/input_otp/input_otp_example_4.dart',
          child: InputOTPExample4(),
        ),
      ],
    );
  }
}

```

### Input Otp Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputOTPExample1 extends StatefulWidget {
  const InputOTPExample1({super.key});

  @override
  State<InputOTPExample1> createState() => _InputOTPExample1State();
}

class _InputOTPExample1State extends State<InputOTPExample1> {
  String value = '';
  String? submittedValue;
  @override
  Widget build(BuildContext context) {
    // Basic OTP input with onChanged and onSubmitted callbacks.
    // The example groups 3 digits, a visual separator, then 3 more digits.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InputOTP(
          onChanged: (value) {
            setState(() {
              this.value = value.otpToString();
            });
          },
          onSubmitted: (value) {
            setState(() {
              submittedValue = value.otpToString();
            });
          },
          children: [
            // Each character cell allows digits. The separator is a visual divider only.
            InputOTPChild.character(allowDigit: true),
            InputOTPChild.character(allowDigit: true),
            InputOTPChild.character(allowDigit: true),
            InputOTPChild.separator,
            InputOTPChild.character(allowDigit: true),
            InputOTPChild.character(allowDigit: true),
            InputOTPChild.character(allowDigit: true),
          ],
        ),
        gap(16),
        Text('Value: $value'),
        Text('Submitted Value: $submittedValue'),
      ],
    );
  }
}

```

### Input Otp Example 2
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

### Input Otp Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputOTPExample3 extends StatelessWidget {
  const InputOTPExample3({super.key});

  @override
  Widget build(BuildContext context) {
    // Same layout as before but with obscured input to hide the characters
    // (useful for sensitive OTP codes).
    return InputOTP(
      children: [
        InputOTPChild.character(allowDigit: true, obscured: true),
        InputOTPChild.character(allowDigit: true, obscured: true),
        InputOTPChild.character(allowDigit: true, obscured: true),
        InputOTPChild.separator,
        InputOTPChild.character(allowDigit: true, obscured: true),
        InputOTPChild.character(allowDigit: true, obscured: true),
        InputOTPChild.character(allowDigit: true, obscured: true),
      ],
    );
  }
}

```

### Input Otp Example 4
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputOTPExample4 extends StatelessWidget {
  const InputOTPExample4({super.key});

  @override
  Widget build(BuildContext context) {
    // OTP comprised of uppercase alphabet characters only, split into
    // multiple groups with separators. Each InputOTPChild.character controls
    // what kinds of characters are permitted.
    return InputOTP(
      children: [
        InputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        InputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        InputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        InputOTPChild.separator,
        InputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        InputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        InputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        InputOTPChild.separator,
        InputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        InputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
        InputOTPChild.character(
            allowLowercaseAlphabet: true,
            allowUppercaseAlphabet: true,
            onlyUppercaseAlphabet: true),
      ],
    );
  }
}

```

### Input Otp Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../input_otp/input_otp_example_2.dart';

class InputOTPTile extends StatelessWidget implements IComponentPage {
  const InputOTPTile({super.key});

  @override
  String get title => 'Input OTP';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Input OTP',
      name: 'input_otp',
      scale: 1,
      example: Column(
        children: [
          const Card(
            child: InputOTPExample2(),
          ),
          const Gap(24),
          Transform.translate(
            offset: const Offset(-150, 0),
            child: Card(
              child: InputOTP(
                initialValue: '123456'.codeUnits,
                children: [
                  InputOTPChild.character(allowDigit: true, obscured: true),
                  InputOTPChild.character(allowDigit: true, obscured: true),
                  InputOTPChild.character(allowDigit: true, obscured: true),
                  InputOTPChild.separator,
                  InputOTPChild.character(allowDigit: true, obscured: true),
                  InputOTPChild.character(allowDigit: true, obscured: true),
                  InputOTPChild.character(allowDigit: true, obscured: true),
                ],
              ),
            ),
          ),
        ],
      ),
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
| `spacing` | `double?` | Horizontal spacing between OTP input fields. |
| `height` | `double?` | Height of each OTP input container. |
