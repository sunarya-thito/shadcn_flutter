import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class KeyboardDisplayExample1 extends StatelessWidget {
  const KeyboardDisplayExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        KeyboardDisplay(keys: [
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.alt,
          LogicalKeyboardKey.delete,
        ]),
        Gap(24),
        KeyboardDisplay.fromActivator(
          activator: SingleActivator(
            LogicalKeyboardKey.keyA,
            control: true,
            shift: true,
          ),
        )
      ],
    ).textSmall();
  }
}
