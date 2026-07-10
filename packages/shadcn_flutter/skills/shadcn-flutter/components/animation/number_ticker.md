# NumberTicker

A widget that smoothly animates between numeric values with customizable display.

## Usage

### Number Ticker Example 1
```dart
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates NumberTicker animating from its previous value to a new value.
// The TextField lets you enter a target integer; committing the edit triggers
// the ticker to animate the change. A formatter compact-prints large numbers.

class NumberTickerExample1 extends StatefulWidget {
  const NumberTickerExample1({super.key});

  @override
  State<NumberTickerExample1> createState() => _NumberTickerExample1State();
}

class _NumberTickerExample1State extends State<NumberTickerExample1> {
  // Current target number. Changing this causes NumberTicker to animate
  // from the old value to the new value.
  int _number = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberTicker(
          // Starting point for the first animation frame.
          initialNumber: 0,
          // The live value to animate toward. When this changes, the ticker
          // interpolates between the previous and the new value.
          number: _number,
          style: const TextStyle(fontSize: 32),
          formatter: (number) {
            // Optional display formatter: 1200 -> 1.2K, etc.
            return NumberFormat.compact().format(number);
          },
        ),
        const Gap(24),
        TextField(
          // Show the current number as the initial text.
          initialValue: _number.toString(),
          controller: _controller,
          onEditingComplete: () {
            // Commit input on edit complete and update the ticker target.
            int? number = int.tryParse(_controller.text);
            if (number != null) {
              setState(() {
                _number = number;
              });
            }
          },
        )
      ],
    );
  }
}

```

### Number Ticker Example 2
```dart
import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class NumberTickerExample2 extends StatefulWidget {
  const NumberTickerExample2({super.key});

  @override
  State<NumberTickerExample2> createState() => _NumberTickerExample2State();
}

class _NumberTickerExample2State extends State<NumberTickerExample2> {
  int _currentNumber = 100;
  void _nextRandomNumber() {
    setState(() {
      Random random = Random();
      _currentNumber = random.nextInt(9000) + 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFlipper(text: '$_currentNumber').x3Large.mono,
        const SizedBox(height: 16),
        Button.primary(
          onPressed: _nextRandomNumber,
          child: const Text('Next Random Number'),
        ),
      ],
    );
  }
}

```

### Number Ticker Tile
```dart
import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class NumberTickerTile extends StatelessWidget implements IComponentPage {
  const NumberTickerTile({super.key});

  @override
  String get title => 'Number Ticker';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'number_ticker',
      title: 'Number Ticker',
      scale: 1.2,
      example: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RepeatedAnimationBuilder(
            start: 0.0,
            end: 1234567.0,
            mode: LoopingMode.pingPong,
            duration: const Duration(seconds: 5),
            builder: (context, value, child) {
              return Text(
                NumberFormat.compact().format(value),
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          Transform.translate(
            offset: const Offset(0, -16),
            child: RepeatedAnimationBuilder(
              start: 1234567.0,
              end: 0.0,
              mode: LoopingMode.pingPong,
              duration: const Duration(seconds: 5),
              builder: (context, value, child) {
                return Text(
                  NumberFormat.compact().format(value),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.mutedForeground,
                  ),
                );
              },
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
| `initialNumber` | `num?` | The initial number value to start animation from.  If null, no initial animation occurs and the widget starts directly with the [number] value. When provided, causes an animation from this initial value to [number] on first build. |
| `number` | `num` | The target number value to animate to and display.  When this changes, triggers a smooth animation from the current displayed value to this new target value. Supports any numeric type (int, double). |
| `builder` | `NumberTickerBuilder?` | Custom builder function for complete display control.  Used only with [NumberTicker.builder] constructor. Receives the current animated numeric value and optional child widget. Allows for complex custom presentations beyond simple text formatting. |
| `child` | `Widget?` | Optional child widget passed to custom builders.  Available only when using [NumberTicker.builder]. Passed through to the builder function for optimization when part of the display remains constant. |
| `formatter` | `NumberTickerFormatted?` | Function to format numbers into display strings.  Used only with default constructor. Called with the current animated numeric value and must return a string representation for display. Enables custom formatting like currency, percentages, or localization. |
| `duration` | `Duration?` | Override duration for this widget's animations.  If null, uses the duration from [NumberTickerTheme] or defaults to 500 milliseconds. Controls how long transitions take when [number] changes. |
| `curve` | `Curve?` | Override animation curve for this widget.  If null, uses the curve from [NumberTickerTheme] or defaults to [Curves.easeInOut]. Controls the timing function of number transitions. |
| `style` | `TextStyle?` | Override text style for formatted number display.  Only used with default constructor. If null, uses the style from [NumberTickerTheme] or system default. Has no effect when using builder. |
