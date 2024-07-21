import 'package:intl/intl.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NumberTickerExample1 extends StatefulWidget {
  const NumberTickerExample1({super.key});

  @override
  State<NumberTickerExample1> createState() => _NumberTickerExample1State();
}

class _NumberTickerExample1State extends State<NumberTickerExample1> {
  int _number = 0;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberTicker(
          initialNumber: 0,
          number: _number,
          formatter: (number) {
            return NumberFormat.currency().format(number);
          },
        ),
        gap(24),
        TextField(
          initialValue: _number.toString(),
          controller: _controller,
          onEditingComplete: () {
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
