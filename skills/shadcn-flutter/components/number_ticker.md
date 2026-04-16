# NumberTickerTheme

Theme configuration for [NumberTicker] widgets.

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
| `duration` | `Duration?` | The default animation duration for number transitions.  If null, individual [NumberTicker] widgets will use their own duration or fall back to the default value of 500 milliseconds. |
| `curve` | `Curve?` | The default animation curve for number transitions.  If null, individual [NumberTicker] widgets will use their own curve or fall back to [Curves.easeInOut]. |
| `style` | `TextStyle?` | The default text style for formatted number display.  Only used when [NumberTicker] is constructed with a [formatter] function. If null, the default system text style is used. |
