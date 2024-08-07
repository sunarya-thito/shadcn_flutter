import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputExample1 extends StatelessWidget {
  const InputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      useNativeContextMenu: true,
      placeholder: 'Enter your name',
    );
  }
}
