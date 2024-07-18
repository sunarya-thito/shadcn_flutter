import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputOTPExample1 extends StatelessWidget {
  const InputOTPExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return InputOTP(
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
