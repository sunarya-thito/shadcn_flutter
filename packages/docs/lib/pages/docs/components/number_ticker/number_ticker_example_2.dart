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
