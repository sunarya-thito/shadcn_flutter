import 'package:shadcn_flutter/shadcn_flutter.dart';

class NumberInputExample1 extends StatelessWidget {
  const NumberInputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: const NumberInput(
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
