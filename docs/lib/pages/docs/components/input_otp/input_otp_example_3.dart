import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputOTPExample3 extends StatelessWidget {
  const InputOTPExample3({super.key});

  @override
  Widget build(BuildContext context) {
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
