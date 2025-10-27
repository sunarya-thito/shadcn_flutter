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
