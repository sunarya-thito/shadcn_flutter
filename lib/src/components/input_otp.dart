import 'package:flutter/widgets.dart';

class InputOTPCharacter extends StatelessWidget {
  final int? value;
  final ValueChanged<int?>? onChanged;
  final bool Function(int codepoint)? acceptCharacters;
  final bool? obscureText;

  const InputOTPCharacter({
    Key? key,
    this.value,
    this.onChanged,
    this.acceptCharacters,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class InputOTPSeparator extends StatelessWidget {
  const InputOTPSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class InputOTPChildData {
  final int index;
  final String? value;
  final bool? obscureText;
  final bool Function(int codepoint)? acceptCharacters;
  final FocusNode focusNode;
  final _InputOTPState _state;

  InputOTPChildData._(
    this._state, {
    required this.index,
    required this.value,
    required this.obscureText,
    required this.acceptCharacters,
    required this.focusNode,
  });
}

class InputOTP extends StatefulWidget {
  final List<Widget> children;
  final ValueChanged<String>? onChanged;
  final String? value;
  final bool Function(int codepoint)? acceptCharacters;
  final bool? obscureText;
  final bool autofocus;

  const InputOTP({
    Key? key,
    required this.children,
    required this.onChanged,
    required this.value,
    required this.acceptCharacters,
    required this.obscureText,
    required this.autofocus,
  }) : super(key: key);

  @override
  State<InputOTP> createState() => _InputOTPState();
}

class InputOTPChild {
  bool active = false;
  final FocusNode focusNode = FocusNode();
}

class _InputOTPState extends State<InputOTP> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
