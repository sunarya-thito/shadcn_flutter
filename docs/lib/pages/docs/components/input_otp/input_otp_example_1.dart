import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputOTPExample1 extends StatefulWidget {
  const InputOTPExample1({super.key});

  @override
  State<InputOTPExample1> createState() => _InputOTPExample1State();
}

class _InputOTPExample1State extends State<InputOTPExample1> {
  String value = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InputOTP(
          onChanged: (value) {
            setState(() {
              this.value = value.otpToString();
            });
          },
          children: [
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
      ],
    );
  }
}
