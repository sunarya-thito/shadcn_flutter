import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a group of mutually exclusive Toggles (B/I/U) where exactly
// one formatting option can be active at a time.

class ToggleExample2 extends StatefulWidget {
  const ToggleExample2({super.key});

  @override
  ToggleExample2State createState() => ToggleExample2State();
}

class ToggleExample2State extends State<ToggleExample2> {
  int flag = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Toggle(
          // Exactly one of three toggles is active at a time.
          value: flag == 0,
          style: const ButtonStyle.outline(density: ButtonDensity.compact),
          onChanged: (v) {
            setState(() {
              // Activate when pressed; deactivate to clear selection.
              flag = v ? 0 : -1;
            });
          },
          child: const Text('B').bold().center(),
        ).sized(width: 40, height: 40),
        Toggle(
          value: flag == 1,
          style: const ButtonStyle.outline(density: ButtonDensity.compact),
          onChanged: (v) {
            setState(() {
              flag = v ? 1 : -1;
            });
          },
          child: const Text('I').italic().center(),
        ).sized(width: 40, height: 40),
        Toggle(
          value: flag == 2,
          style: const ButtonStyle.outline(density: ButtonDensity.compact),
          onChanged: (v) {
            setState(() {
              flag = v ? 2 : -1;
            });
          },
          child: const Text('U').underline().center(),
        ).sized(width: 40, height: 40),
      ],
    ).gap(4);
  }
}
